import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music/src/models/song.dart';
import 'package:youtube_music/src/models/song_details.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_provider.dart';
import 'package:youtube_music/src/screens/song_details_screen/song_details_service.dart';
import 'package:youtube_music/src/utils/constants.dart';
import 'package:youtube_music/src/utils/styles.dart';
import 'package:youtube_music/src/utils/utils.dart';

class SongDetailsScreen extends StatefulWidget {
  const SongDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SongDetailsScreen> createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  SongDetails? songDetails;
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isLoaded = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    getData();

    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  getData() async {
    setState(() {
      isLoaded = false;
    });
    songDetails = await SongDetailsService().getData(context);
    if (songDetails?.result?.downloadUrl != null) {
      setState(() {
        isLoaded = true;
      });
      await setAudio();
    }
  }

  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    String url = songDetails?.result?.downloadUrl ?? '';
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    Song? song = Provider.of<SongDetailsProvider>(context).song;
    duration = Duration(
        seconds: Provider.of<SongDetailsProvider>(context).songDuration);
    return Scaffold(
      appBar: AppBar(
        title: const Text(YmConstants.nowPlaying),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(YmStyles.padding20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  YmStyles.radius20,
                ),
                child: Image.network(
                  song?.thumbnail ?? '',
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const SizedBox(
                      height: YmStyles.height20,
                      width: YmStyles.width20,
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: YmStyles.height20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: YmStyles.padding20,
              ),
              child: Text(
                song?.title ?? '',
                style: TextStyle(
                  color: YmStyles.colorGrey100,
                  fontSize: YmStyles.size20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: YmStyles.height10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: YmStyles.padding25,
              ),
              child: Text(
                song?.artists
                        ?.map((artist) => artist.name)
                        .toList()
                        .join(', ') ??
                    '',
                style: TextStyle(
                  color: YmStyles.colorGrey500,
                  fontSize: YmStyles.size16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: YmStyles.padding20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    YmUtils().formatTime(position),
                    style: TextStyle(
                      color: YmStyles.colorGrey100,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: YmStyles.padding10,
                        vertical: YmStyles.padding20,
                      ),
                      child: Slider(
                        min: 0,
                        max: duration.inMinutes.toDouble(),
                        value: position.inMinutes.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(
                            seconds: value.toInt(),
                          );
                          await player.seek(position);
                        },
                      ),
                    ),
                  ),
                  Text(
                    YmUtils().formatTime(duration),
                    style: TextStyle(
                      color: YmStyles.colorGrey100,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: YmStyles.radius35,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await player.pause();
                  } else {
                    await player.resume();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: YmStyles.size30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
