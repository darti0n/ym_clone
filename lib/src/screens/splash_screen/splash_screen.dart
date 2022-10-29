import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_music/src/utils/constants.dart';
import 'package:youtube_music/src/utils/routes.dart';
import 'package:youtube_music/src/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: YmConstants.seconds4),
      () => Navigator.pushReplacementNamed(
        context,
        YmRoutes.authenticationScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                YmStyles.padding25,
              ),
              child: Image.asset(
                YmConstants.ymLogoPath,
              ),
            ),
            const SizedBox(
              height: YmStyles.height25,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
