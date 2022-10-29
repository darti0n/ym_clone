import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:youtube_music/src/models/song_details.dart';
import 'package:youtube_music/src/screens/authentication_screen/authentication_provider.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_provider.dart';

class SongDetailsService {
  Future<SongDetails?>? getData(BuildContext context) async {
    SongDetailsProvider songDetailsProvider =
        Provider.of<SongDetailsProvider>(context, listen: false);
    SongDetails? songDetails;

    Uri uri = Uri.parse(
      'https://youtube-music1.p.rapidapi.com/get_download_url?id=${songDetailsProvider.song!.id}&ext=mp3',
    );

    try {
      var response = await http.get(uri, headers: {
        'X-RapidAPI-Key':
            Provider.of<AuthenticationProvider>(context, listen: false).apiKey,
        'X-RapidAPI-Host': 'youtube-music1.p.rapidapi.com',
      });
      songDetails = songDetailsFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }

    return songDetails;
  }
}
