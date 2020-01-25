import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'player.dart';
import 'api/main.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

var playerScore = 0;
var lysoramScore = 0;

String lyrics = '';


class HomePageState extends State<HomePage> {
  var isSearchButtonActive = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text('Lyrozam', style: TextStyle(
                        fontSize: 70,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: _buildSearch(context),
                ),
                  Spacer(
                    flex: 4,
                  )
              ],
            )
        )
    );
  }

  Widget _buildSearch(context) {
    return Center(
      child: Container(
        height: 60,
        child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0)),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.only(right: 10, left: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter lyrics to start game'
                      ),
                      onChanged: (string) {
                        lyrics = string;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.search, color: Colors.black,),
                        onPressed: () async {
                          if (lyrics.isNotEmpty && isSearchButtonActive)
                          {
                            isSearchButtonActive = false;
                            Player.songs = await getSong(lyrics);
                            popupDialog(context, Player());
                            isSearchButtonActive = true;
                          }
                        }
                    )
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}