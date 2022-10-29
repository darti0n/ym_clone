import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/screens/authentication_screen/authentication_provider.dart';
import 'package:youtube_music/src/utils/constants.dart';
import 'package:youtube_music/src/utils/routes.dart';
import 'package:youtube_music/src/utils/styles.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(YmStyles.padding15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: YmStyles.width2,
                  ),
                  borderRadius: BorderRadius.circular(
                    YmStyles.radius5,
                  ),
                ),
                child: TextFormField(
                  style: const TextStyle(
                    color: YmStyles.colorWhite,
                  ),
                  decoration: InputDecoration(
                    hintText: YmConstants.enterYourRapidApiKey,
                    hintStyle: TextStyle(
                      color: YmStyles.colorGrey600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (apiKey) => Provider.of<AuthenticationProvider>(
                    context,
                    listen: false,
                  ).updateApiKey(apiKey),
                ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  Provider.of<AuthenticationProvider>(context).apiKey.isNotEmpty
                      ? () => Navigator.pushReplacementNamed(
                          context, YmRoutes.searchScreen)
                      : null,
              child: const Text(YmConstants.submit),
            ),
          ],
        ),
      ),
    );
  }
}
