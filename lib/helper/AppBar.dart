import 'package:flutter/material.dart';

Widget MyAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Dayı",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
        Text(
          "News",
          style: TextStyle(
              color: Color.fromARGB(255, 243, 93, 33),
              fontWeight: FontWeight.w600),
        )
      ],
    ),
    //widget is for allining the title

    actions: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.share,
            color: Colors.transparent,
          ))
    ],

    //backgroundColor: Color.fromARGB(255, 81, 81, 81),
    elevation: 0.0,
  );
}
