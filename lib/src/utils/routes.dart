import 'package:flutter/material.dart';
import 'package:youtube_music/src/screens/authentication_screen/authentication_screen.dart';
import 'package:youtube_music/src/screens/search_screen/search_screen.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_screen.dart';
import 'package:youtube_music/src/screens/splash_screen/splash_screen.dart';

class YmRoutes {
  static const String splashScreen = '/splash-screen';
  static const String authenticationScreen = '/authentication-screen';
  static const String searchScreen = '/search-screen';
  static const String songDetails = '/song-details';

  static Map<String, WidgetBuilder> ymRoutes = {
    splashScreen: (context) => const SplashScreen(),
    authenticationScreen: (context) => const AuthenticationScreen(),
    searchScreen: (context) => const SearchScreen(),
    songDetails: (context) => const SongDetailsScreen(),
  };
}
