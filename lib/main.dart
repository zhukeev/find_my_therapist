import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'view/pages/find_my_therapist_page.dart';
import 'view/pages/recomended_therapy_page.dart';
import 'viewmodel/find_my_therapist_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));

  runApp(MultiProvider(providers: [
    ListenableProvider(create: (_) => FindMyTherapistProvider()..fetchAllData())
  ], child: MyApp()));
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
