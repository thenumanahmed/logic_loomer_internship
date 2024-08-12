import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internship_task/provider/song_model_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  final List<SongModel> songModelsList;
  final AudioPlayer audioPlayer;

  const NowPlaying(
      {super.key, required this.songModelsList, required this.audioPlayer});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  bool isPlaying = false;
  Duration duration = const Duration();
  Duration position = const Duration();
  List<AudioSource> songList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      widget.songModelsList.forEach((element) {
        songList.add(AudioSource.uri(
          Uri.parse(element.uri!),
          tag: MediaItem(
            id: element.id.toString(),
            album: element.album,
            title: element.displayNameWOExt,
            artUri: Uri.parse(element.uri!),
          ),
        ));
      });

      widget.audioPlayer
          .setAudioSource(ConcatenatingAudioSource(children: songList));

      widget.audioPlayer.play();
      isPlaying = true;
      listenToEvent();
      listenToSongIndex();
    } on Exception {
      log("Error while playing");
    }
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d ?? Duration.zero;
      });
    });
  }

  void listenToEvent() {
    widget.audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen((event) {
      setState(() {
        if (event != null) {
          currentIndex = event;
        }
        context
            .read<SongModelProvider>()
            .setId(widget.songModelsList[currentIndex].id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    const Center(
                      child: ArtWorkWidget(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.songModelsList[currentIndex].displayNameWOExt,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.songModelsList[currentIndex].artist.toString() ==
                              "<unknown>"
                          ? "Unknown Artist"
                          : widget.songModelsList[currentIndex].artist
                              .toString(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(position.toString().split(".")[0]),
                        Expanded(
                          child: Slider(
                              min: const Duration(seconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              value: position.inSeconds.toDouble(),
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  changeSeconds(value.toInt());
                                });
                              }),
                        ),
                        Text(duration.toString().split(".")[0]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if(widget.audioPlayer.hasPrevious){
                              widget.audioPlayer.seekToPrevious();
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                            if (!isPlaying) {
                              widget.audioPlayer.pause();
                            } else {
                              widget.audioPlayer.play();
                            }
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if(widget.audioPlayer.hasNext){
                              widget.audioPlayer.seekToNext();
                            }
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkFit: BoxFit.cover,
      id: context.watch<SongModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkHeight: 200,
      artworkWidth: 200,
      nullArtworkWidget: const Icon(Icons.music_note, size: 80),
    );
  }
}
