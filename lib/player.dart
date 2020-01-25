import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  @override
  PlayerState createState() => PlayerState();
}

class PlayerState extends State<Player> with SingleTickerProviderStateMixin{
  bool isPlaying = false;

  Color textColor = Color.fromRGBO(219, 210, 70, 1);
  Color backColor = Color.fromRGBO(25, 32, 24, 1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(0, 0, 0, 0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Suggestions', style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w900)),
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: 350,
                height: 500,

                child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    elevation: 50,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: _buildPlayer(),
                        ),
                        Expanded(
                          flex: 5,
                          child: _buildLyrics(),
                        )
                      ],
                    )
                )
               ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 200,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          iconSize: 50,
                          icon: Icon(Icons.close, color: Colors.white)
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          iconSize: 50,
                          icon: Icon(Icons.check, color: Colors.white)
                      ),
                    ],
                  ),
                ),
              ),
            )
            ]
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Column (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'The End',
              style: TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w800),
            ),
            Text(
              'The Doors',
              style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
            ),
          ],
        ),

        Row( //TODO: Buttons Callbacks
          mainAxisAlignment: MainAxisAlignment.start, //todo: fix
          children: <Widget>[
            IconButton(
              iconSize: 30,
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.skip_previous, color: textColor),
            ),

            IconButton(
              iconSize: 40,
              padding: EdgeInsets.all(0),
              icon: Icon(isPlaying ? Icons.play_arrow : Icons.pause, color: textColor),
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
            IconButton(
              iconSize: 30,
              padding: EdgeInsets.all(0),
              icon: Icon( Icons.skip_next, color: textColor),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPlayer() {
    return Stack(
      children: <Widget>[
        Positioned(
            right: 0,
            child: Image.network( // TODO: uploading from database
              'https://lh5.ggpht.com/32nGIYKdvbjVKTHRCht2J1qL8EX9u2N1ZrnxSBqBl_u_SmtJTQIMMg9zmskeavPMkgBBFhlKLHg=s512-c-e100-rwu-v1',
              height: 145,
            )
        ),
        SizedBox ( //TODO: find better solution
          height: double.infinity,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.2, 0.0),
                end: Alignment(1, 0.0),
                colors: [backColor, Color.fromRGBO(0, 0, 0, 0)], // whitish to gray
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: _buildButtons(),
            ),
          ),
        )

      ],
    );
  }

  Widget _buildLyrics() {
    return Container(
      color: Colors.white,
    );
  }
}