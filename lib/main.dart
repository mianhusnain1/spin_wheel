import 'package:flutter/material.dart';
import 'package:wheel_of_names/constant.dart';
import 'package:wheel_of_names/home.dart';

void main() {
  runApp(const MyApp());
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
