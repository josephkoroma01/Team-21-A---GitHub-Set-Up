import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbodyfam.dart';

class FamBloodTestScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeblood',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: BloodTestPageFam(title: 'Blood Group Test For Family'),
    );
  }
}
