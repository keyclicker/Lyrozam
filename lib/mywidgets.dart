import 'dart:ui';
import 'package:flutter/material.dart';

Widget MyCard(
    {EdgeInsets padding = const EdgeInsets.all(3),
    Color color = Colors.white,
    double elevate = 5,
    Widget child}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(elevate, elevate),
            blurRadius: elevate * 2,
          )
        ]),
    child: child,
  );
}


