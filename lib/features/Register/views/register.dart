import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Register/views/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    final Locale locale = Localizations.localeOf(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  RegisterPage(),
    );
  }
}