import 'package:flutter/material.dart';
import 'package:news_app_api/views/xoxGame.dart/helper.dart';
import 'package:news_app_api/views/xoxGame.dart/minimax_ai.dart';

enum Mark { x, o, none }

enum Winner { x, o, tie, none }

const AI = Mark.x;
const HUMAN = Mark.o;

const STROKE_WIDTH = 6.0;
const HALF_STROKE_WIDTH = STROKE_WIDTH / 2.0;
const DOUBLE_STROKE_WIDTH = STROKE_WIDTH * 2.0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow[50],
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent,
        ),
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TicTacToeState();
}

class _TicTacToeState extends State {
  Map<int, Mark> _gameMarks = Map();
  Mark _currentMark = Mark.o;
  List<int> _winningLine;
  MiniMaxAI ai = MiniMaxAI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails details) {
            setState(() {
              if (_addMark(
                  x: details.localPosition.dx, y: details.localPosition.dy)) {
                Winner winner = getWinner(_gameMarks)['winner'];
                if (winner == Winner.none || winner == Winner.tie) {
                  _addMark(index: ai.move(_gameMarks));
                }
              }
            });
          },
          child: AspectRatio(
            aspectRatio: 1.0,
            child: CustomPaint(
              painter: GamePainter(_gameMarks, _winningLine),
            ),
          ),
        ),
      ),
    );
  }

  bool _addMark({int index = -1, double x = -1.0, double y = -1.0}) {
    bool isAbsent = false;

    if (_gameMarks.length >= 9 || _winningLine != null) {
      if (index == -1) {
        _gameMarks = Map<int, Mark>();
        _currentMark = Mark.o;
        _winningLine = null;
      }
    } else {
      double _dividedSize = GamePainter.getDividedSize();

      if (index == -1) {
        index = (x ~/ _dividedSize + (y ~/ _dividedSize) * 3).toInt();
      }

      _gameMarks.putIfAbsent(index, () {
        isAbsent = true;
        return _currentMark;
      });

      _winningLine = getWinner(_gameMarks)['winningLine'];

      if (isAbsent) _currentMark = _currentMark == Mark.o ? Mark.x : Mark.o;
    }

    return isAbsent;
  }
}

class GamePainter extends CustomPainter {
  static double _dividedSize;
  Map<int, Mark> _gameMarks;
  List<int> _winningLine;

  GamePainter(this._gameMarks, this._winningLine);

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = STROKE_WIDTH
      ..color = Colors.black;

    final blackThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = DOUBLE_STROKE_WIDTH
      ..color = Colors.black;

    final redThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = DOUBLE_STROKE_WIDTH
      ..color = Colors.red;

    final orangeThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = DOUBLE_STROKE_WIDTH
      ..color = Colors.orange;

    _dividedSize = size.width / 3.0;

    // 1st horizontal line
    canvas.drawLine(
        Offset(STROKE_WIDTH, _dividedSize - HALF_STROKE_WIDTH),
        Offset(size.width - STROKE_WIDTH, _dividedSize - HALF_STROKE_WIDTH),
        blackPaint);

    // 2nd horizontal line
    canvas.drawLine(
        Offset(STROKE_WIDTH, _dividedSize * 2 - HALF_STROKE_WIDTH),
        Offset(size.width - STROKE_WIDTH, _dividedSize * 2 - HALF_STROKE_WIDTH),
        blackPaint);

    // 1st vertical line
    canvas.drawLine(
        Offset(_dividedSize - HALF_STROKE_WIDTH, STROKE_WIDTH),
        Offset(_dividedSize - HALF_STROKE_WIDTH, size.height - STROKE_WIDTH),
        blackPaint);

    // 2nd vertical line
    canvas.drawLine(
        Offset(_dividedSize * 2 - HALF_STROKE_WIDTH, STROKE_WIDTH),
        Offset(
            _dividedSize * 2 - HALF_STROKE_WIDTH, size.height - STROKE_WIDTH),
        blackPaint);

    _gameMarks.forEach((index, mark) {
      switch (mark) {
        case Mark.o:
          drawNought(canvas, index, redThickPaint);
          break;
        case Mark.x:
          drawCross(canvas, index, blackThickPaint);
          break;
        default:
          break;
      }
    });

    drawWinningLine(canvas, _winningLine, orangeThickPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  static double getDividedSize() => _dividedSize;

  void drawNought(Canvas canvas, int index, Paint paint) {
    double left = (index % 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;
    double top = (index ~/ 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;
    double noughtSize = _dividedSize - DOUBLE_STROKE_WIDTH * 4;

    canvas.drawOval(Rect.fromLTWH(left, top, noughtSize, noughtSize), paint);
  }

  void drawCross(Canvas canvas, int index, Paint paint) {
    double x1, y1;
    double x2, y2;

    x1 = (index % 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;
    y1 = (index ~/ 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;

    x2 = (index % 3 + 1) * _dividedSize - DOUBLE_STROKE_WIDTH * 2;
    y2 = (index ~/ 3 + 1) * _dividedSize - DOUBLE_STROKE_WIDTH * 2;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

    x1 = (index % 3 + 1) * _dividedSize - DOUBLE_STROKE_WIDTH * 2;
    y1 = (index ~/ 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;

    x2 = (index % 3) * _dividedSize + DOUBLE_STROKE_WIDTH * 2;
    y2 = (index ~/ 3 + 1) * _dividedSize - DOUBLE_STROKE_WIDTH * 2;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  void drawWinningLine(Canvas canvas, List<int> winningLine, Paint paint) {
    if (winningLine == null) return;

    double x1 = 0, y1 = 0;
    double x2 = 0, y2 = 0;

    int firstIndex = winningLine.first;
    int lastIndex = winningLine.last;

    if (firstIndex % 3 == lastIndex % 3) {
      // Vertical line
      x1 = x2 = firstIndex % 3 * _dividedSize + _dividedSize / 2;
      y1 = STROKE_WIDTH;
      y2 = _dividedSize * 3 - STROKE_WIDTH;
    } else if (firstIndex ~/ 3 == lastIndex ~/ 3) {
      // Horizontal line
      x1 = STROKE_WIDTH;
      x2 = _dividedSize * 3 - STROKE_WIDTH;
      y1 = y2 = firstIndex ~/ 3 * _dividedSize + _dividedSize / 2;
    } else {
      // Diagonal line
      if (firstIndex == 0) {
        x1 = y1 = DOUBLE_STROKE_WIDTH;
        x2 = y2 = _dividedSize * 3 - DOUBLE_STROKE_WIDTH;
      } else {
        x1 = _dividedSize * 3 - DOUBLE_STROKE_WIDTH;
        y1 = DOUBLE_STROKE_WIDTH;
        x2 = DOUBLE_STROKE_WIDTH;
        y2 = _dividedSize * 3 - DOUBLE_STROKE_WIDTH;
      }
    }

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }
}
