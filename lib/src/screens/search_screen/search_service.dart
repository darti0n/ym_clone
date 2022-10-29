import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/models/music_objects.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_music/src/screens/authentication_screen/authentication_provider.dart';
import 'package:youtube_music/src/screens/search_screen/search_provider.dart';

class SearchService {
  Future<MusicObjects>? getData(BuildContext context) async {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    Uri uri = Uri.parse(
        'https://youtube-music1.p.rapidapi.com/v2/search?query=${searchProvider.queryString}');

    var response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key':
            Provider.of<AuthenticationProvider>(context, listen: false).apiKey,
        'X-RapidAPI-Host': 'youtube-music1.p.rapidapi.com',
      },
    );

    MusicObjects musicObjects = musicObjectsFromJson(response.body);

    return musicObjects;
  }
}
