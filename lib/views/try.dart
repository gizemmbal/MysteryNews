import 'package:flutter/material.dart';
import 'package:news_app_api/helper/AppBar.dart';

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  @override
  Widget build(BuildContext context) {
    print('TryburdaTry');
    return Scaffold(
      appBar: MyAppBar(),
    );
  }
}
