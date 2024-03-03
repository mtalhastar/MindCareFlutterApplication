import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/chatScreen.dart';
import 'package:mindcareflutterapp/screens/questionScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindcareflutterapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: LoginScreen());
  }
}
