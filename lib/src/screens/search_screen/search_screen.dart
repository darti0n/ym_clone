import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/models/music_objects.dart';
import 'package:youtube_music/src/screens/drawer_screen/drawer_screen.dart';
import 'package:youtube_music/src/screens/search_screen/search_provider.dart';
import 'package:youtube_music/src/screens/search_screen/search_service.dart';
import 'package:youtube_music/src/screens/search_screen/widgets/search_results.dart';
import 'package:youtube_music/src/utils/constants.dart';
import 'package:youtube_music/src/utils/styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoaded = true;
  MusicObjects? musicObjects;

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    musicObjects = await SearchService().getData(context);
    if (musicObjects != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(YmConstants.youtubeMusic),
      ),
      drawer: const DrawerScreen(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: YmStyles.flex1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      YmStyles.padding10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: YmStyles.padding10,
                            ),
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
                                  border: InputBorder.none,
                                  hintText: YmConstants.searchExample,
                                  hintStyle: TextStyle(
                                    color: YmStyles.colorGrey600,
                                  ),
                                ),
                                onChanged: (queryString) =>
                                    Provider.of<SearchProvider>(
                                  context,
                                  listen: false,
                                ).updateQueryString(queryString),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: YmStyles.height50,
                          child: ElevatedButton(
                            onPressed: Provider.of<SearchProvider>(context)
                                    .queryString
                                    .isNotEmpty
                                ? () async {
                                    setState(() {
                                      isLoaded = false;
                                    });
                                    await getData();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: YmStyles.elevation5,
                              onSurface: YmStyles.colorGrey50,
                              shape: const CircleBorder(),
                              shadowColor: YmStyles.colorGrey600,
                            ),
                            child: const Icon(
                              Icons.search,
                              size: YmStyles.size30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: YmStyles.flex10,
              child: SearchResults(musicObjects: musicObjects),
            ),
          ],
        ),
      ),
    );
  }
}
