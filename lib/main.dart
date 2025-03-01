import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wheel_of_names/constant.dart';
import 'package:wheel_of_names/fcm.dart';
import 'package:wheel_of_names/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wheel of Name',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkColor),
          useMaterial3: true,
        ),
        home: const Home());
  }
}
