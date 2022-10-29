import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/screens/authentication_screen/authentication_provider.dart';
import 'package:youtube_music/src/screens/search_screen/search_provider.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_provider.dart';
import 'package:youtube_music/youtube_music.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => SongDetailsProvider()),
      ],
      child: const YoutubeMusic(),
    ),
  );
}
