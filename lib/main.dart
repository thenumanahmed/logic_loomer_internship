import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internship_task/all_songs_screen.dart';
import 'package:internship_task/provider/song_model_provider.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> SongModelProvider(),
      child: MaterialApp(
        title: 'OTP Verification',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AllSongsScreen(),
      ),
    );
  }
}
