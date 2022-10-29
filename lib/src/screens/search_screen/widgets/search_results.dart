import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/models/music_objects.dart';
import 'package:youtube_music/src/models/song.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_provider.dart';
import 'package:youtube_music/src/utils/constants.dart';
import 'package:youtube_music/src/utils/routes.dart';
import 'package:youtube_music/src/utils/styles.dart';
import 'package:youtube_music/src/utils/utils.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key? key,
    this.musicObjects,
  }) : super(key: key);

  final MusicObjects? musicObjects;

  @override
  Widget build(BuildContext context) {
    if (musicObjects == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Padding(
              padding: EdgeInsets.all(
                YmStyles.padding20,
              ),
              child: Text(
                YmConstants.searchHint,
                style: TextStyle(
                  fontSize: YmStyles.size20,
                  fontWeight: FontWeight.bold,
                  color: YmStyles.colorWhite,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: musicObjects?.result?.songs?.length ?? 0,
        itemBuilder: (context, songIndex) {
          Song? song = musicObjects?.result?.songs?[songIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: YmStyles.padding10,
              vertical: YmStyles.padding5,
            ),
            child: Material(
              elevation: YmStyles.elevation3,
              color: YmStyles.colorGrey800,
              child: ListTile(
                onTap: () {
                  Provider.of<SongDetailsProvider>(context, listen: false)
                      .updateSongDetails(song);
                  Provider.of<SongDetailsProvider>(context, listen: false)
                      .updateSongDuration(song?.duration ?? 0);
                  Navigator.pushNamed(context, YmRoutes.songDetails);
                },
                isThreeLine: true,
                leading: Image.network(
                  song?.thumbnail ?? '',
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const SizedBox(
                      height: YmStyles.height25,
                      width: YmStyles.width25,
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image);
                  },
                  fit: BoxFit.cover,
                ),
                title: Text(
                  song?.title ?? '',
                  style: TextStyle(
                    color: YmStyles.colorGrey100,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song?.artists
                              ?.map((artist) => artist.name)
                              .toList()
                              .join(', ') ??
                          '',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: YmStyles.height3,
                    ),
                    Text(
                      YmUtils().formatTime(
                        Duration(seconds: song?.duration ?? 0),
                      ),
                      style: TextStyle(
                        color: YmStyles.colorGrey100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
