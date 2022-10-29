import 'package:flutter/material.dart';
import 'package:youtube_music/src/utils/routes.dart';

class YoutubeMusic extends StatelessWidget {
  const YoutubeMusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: YmRoutes.splashScreen,
      routes: YmRoutes.ymRoutes,
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.grey.shade900,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
