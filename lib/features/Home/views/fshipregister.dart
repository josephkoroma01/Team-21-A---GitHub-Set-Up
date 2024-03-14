import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbodyfship.dart';

class FshipBloodTestScreen extends StatelessWidget {
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
      home:
      BloodTestPageShip(title: 'Blood Group Test For A Friend'),
    );
  }
}
