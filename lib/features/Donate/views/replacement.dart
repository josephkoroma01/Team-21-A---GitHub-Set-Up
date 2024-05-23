import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Donate/views/replacementdonation.dart';

class ReplacementScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeblood Donation',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: ReplacementDonation(title: 'Schedule Replacement Donation'),
    );
  }
}
