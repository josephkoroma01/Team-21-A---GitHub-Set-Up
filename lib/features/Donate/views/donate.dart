import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Donate/views/blooddonation.dart';

class BloodDoonationScreen extends StatelessWidget {
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
      home:
      BloodDonation(title: 'Schedule Voluntary Blood Donation'),
    );
  }
}
