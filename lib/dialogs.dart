import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void popupDialog(context, Widget widget) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (context, anim1, anim2) {},
    barrierColor: Color.fromRGBO(0, 0, 0, 0.70),
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 0 * anim1.value,
          sigmaX: 0 * anim1.value,
        ),
        child: Transform.scale(
            scale: anim1.value,
            child: Opacity(opacity: anim1.value, child: widget)),
      );
    },
  );
}

class ResultsDialog extends StatelessWidget{
  String text;
  String buttonText;

  ResultsDialog({this.text, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 125,
        width: 225,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                    child: Text(text, style: TextStyle(fontSize: 20))
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    child: Text("Ok", style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
