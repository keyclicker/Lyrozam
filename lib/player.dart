import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrozam/api/main.dart';
import 'package:lyrozam/dialogs.dart';
import 'package:lyrozam/homepage.dart';
import 'package:lyrozam/mywidgets.dart';

class Player extends StatefulWidget {
  static List<SongResponse> songs;

  @override
  PlayerState createState() => PlayerState();
}

class PlayerState extends State<Player> with SingleTickerProviderStateMixin{
  bool isPlaying = false;

  static var songNumber = 0;

  Color textColor = Color.fromRGBO(219, 210, 70, 1);
  Color backColor = Color.fromRGBO(25, 32, 24, 1);

  var currentSong = Player.songs[songNumber];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(0, 0, 0, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 90, left: 0, right: 0,
            child: Center(
              child: Text('Suggestion $songNumber', style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w900)),
            ),
          ),
          Positioned(
            top: 180, left: 0, right: 0,
            child: Center(
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
          ),
          Positioned(
            top: 700, left: 0, right: 0,

            child: Center(
              child: Container(
                width: 235,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                            playerScore++;
                            songNumber++;
                            if (songNumber <= 4) {
                              _nextSong();
                            }
                            else {
                              songNumber = 0;
                              victory();
                            }

                          },
                          iconSize: 55,
                          icon: Icon(Icons.close, color: Colors.white)
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                            lysoramScore++;
                            songNumber = 0;
                            defeat();
                          },
                          iconSize: 55,
                          icon: Icon(Icons.check, color: Colors.white)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          ]
      ),
    );
  }

  void showResults(string) {
    popupDialog(context, ResultsDialog(
      text: string,
      buttonText: "hell",
    ));
  }

  void victory() {
    showResults("Congratulations, you win!");
  }

  void defeat() {
    showResults("Sorry, but you loose(");
  }
  
  void _nextSong(){
    //todo:nextsong
    popupDialog(context, Player());
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
              currentSong.artist,
              style: TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w800),
            ),
            Text(
              currentSong.title,
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
            right: -5,
            child: Image.network(
              currentSong.pictureLink,
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
      width: double.infinity,
      child: SingleChildScrollView(
        child: Text(
          currentSong.lyrics,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    );
  }
}