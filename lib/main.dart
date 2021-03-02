import 'package:find_my_therapist/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'view/pages/find_my_therapist_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Therapist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
              GoogleFonts.libreFranklinTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
              color: Colors.white,
              brightness: Brightness.light,
              centerTitle: true)),
      home: FindMyTherapistPage(),
    );
  }
}
