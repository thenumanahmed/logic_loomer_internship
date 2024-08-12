import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internship_task/now_playing.dart';
import 'package:internship_task/provider/song_model_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<SongModel> allSongs = [];

  playSong(String? uri) {
    log("playeing");
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } catch (ex) {
      log("Error: $ex");
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              ignoreCase: true,
              uriType: UriType.EXTERNAL),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (item.data!.isEmpty) {
              return const Center(child: Text("No Songs Found"));
            }
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  itemCount: item.data?.length,
                  itemBuilder: (context, index) {
                    allSongs.addAll(item.data!);
                    return ListTile(
                        title: Text(item.data![index].displayNameWOExt),
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(Icons.music_note),
                        ),
                        subtitle: Text("${item.data![index].artist}"),
                        trailing: const Icon(Icons.more_horiz),
                        onTap: () {
                          context
                              .read<SongModelProvider>()
                              .setId(item.data![index].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlaying(
                                songModelsList: [item.data![index]],
                                audioPlayer: _audioPlayer,
                              ),
                            ),
                          );
                        }
                        // playSong("${item.data![index].uri}"),
                        );
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlaying(
                                songModelsList: allSongs,
                                audioPlayer: _audioPlayer,
                              ),
                            ),
                          );
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
