import 'dart:typed_data';

import 'config.dart';
import 'dart:math' as math;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var auddIoLink = 'https://api.audd.io/findLyrics/?q=';
var deezerLink = 'https://api.deezer.com/search?limit=1&output=json&q=';

var client = http.Client();

class SongResponse {
  String title;
  String artist;
  String lyrics;
  Uint8List picture;
  String trackLink;
  bool empty = true;
}

String convertURL(String originURL)
{
  var newURL = '';

  for (var charIndex = 0; charIndex < originURL.length; charIndex++)
    {
      newURL += originURL[charIndex];
    }

  return newURL;
}

Future<List> searchSong(String lyricsExcerpt) async
{
  var requestLink = auddIoLink + convertURL(lyricsExcerpt);
  var requestPayload = {'api_token': config['auddIoApiKey']};
  var searchRequest = await client.post(requestLink, body: requestPayload);

  if (searchRequest.statusCode == 200)
  {
    var searchResponse = convert.jsonDecode(searchRequest.body);
    if (searchResponse['status'] == 'success')
    {
      var resultList = [];
      for (var songNumber = 0; songNumber < math.min(config['resultsLimit'],
           searchResponse['result'].length); songNumber++)
      {
        var artist = convert.utf8.decode(
                     convert.latin1.encode(
                     searchResponse['result'][songNumber]['artist']));
        var title = convert.utf8.decode(
                    convert.latin1.encode(
                    searchResponse['result'][songNumber]['title']));
        var lyrics = convert.utf8.decode(
                     convert.latin1.encode(
                     searchResponse['result'][songNumber]['lyrics']));
        resultList.add([artist, title, lyrics]);
      }
      return resultList;
    }
  }
  return [];
}

Future<SongResponse> getInfo(String songArtist, String songTitle) async
{
  var songResponse = SongResponse();
  var requestLink = deezerLink + 'artist:"$songArtist" track:"$songTitle"';
  var searchRequest = await client.get(requestLink);

  if (searchRequest.statusCode == 200)
  {
    var searchResponse = convert.jsonDecode(searchRequest.body)['data'];

    if (searchResponse.length != 0)
    {
      songResponse.title = searchResponse[0]['title'];
      songResponse.artist = searchResponse[0]['artist']['name'];
      songResponse.trackLink = searchResponse[0]['preview'];
      songResponse.empty = false;

      var picReq = await client.get(searchResponse[0]['album']['cover_medium']);
      if (picReq.statusCode == 200)
      {
        songResponse.picture = picReq.bodyBytes;
      }
    }
  }

  return songResponse;
}

Future<List<SongResponse>> getSong(String lyricsExcerpt) async
{
  List<SongResponse> responseList = [];
  var searchResults = await searchSong(lyricsExcerpt);

  for (var songNumber = 0; songNumber < searchResults.length; songNumber++)
  {
    var songResponse = await getInfo(searchResults[songNumber][0],
                                     searchResults[songNumber][1]);
    songResponse.lyrics = searchResults[songNumber][2];
    if (songResponse.empty)
    {
      songResponse.title = searchResults[songNumber][0];
      songResponse.artist = searchResults[songNumber][1];
      songResponse.lyrics = searchResults[songNumber][2];
    }
    responseList.add(songResponse);
  }

  return responseList;
}
