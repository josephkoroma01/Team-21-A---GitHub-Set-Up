import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/routes/route_config.dart';
import 'package:geocoding/geocoding.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? id, email, onboarding;

Future<void> main() async {
  // Use countryList as needed

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  onboarding = prefs.getString('onboarding');

  runApp(const LifeBlood());
}

class LifeBlood extends StatefulWidget {
  const LifeBlood({Key? key}) : super(key: key);

  @override
  State<LifeBlood> createState() => _LifeBloodState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _LifeBloodState? state = context.findAncestorStateOfType<_LifeBloodState>();
    state?.setLocale(newLocale);
  }
}

class _LifeBloodState extends State<LifeBlood> {
  @override
  void initState() {
    super.initState();
    // getPref();
  }

  late Position _currentPosition;
  String? _currentAddress;
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? getCurrentLocale() {
    return _locale;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LifeBlood',
              theme: ThemeData(
                fontFamily: 'Montserrat',
                primaryColor: kPrimaryColor,

                // textTheme:
                //     Typography.englishLike2018.apply(bodyColor: Colors.white),
                scaffoldBackgroundColor: kWhiteColor,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Colors.black,
                    primary: kPrimaryColor,
                    outline: Colors.grey,
                    background: kWhiteColor),
              ),
              onGenerateTitle: (BuildContext context) {
                final appLocalizations = AppLocalizations.of(context);
                return appLocalizations?.signupandsavelives ?? 'Fallback Title';
              },
              localizationsDelegates: const [
                AppLocalizations.delegate,
                FormBuilderLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: _locale,
              supportedLocales: const [
                Locale('en'),
                Locale('fr'),
              ],
              home: (email != null && onboarding == "Yes")
                  ? HomePageScreen(
                      pageIndex: 0,
                    )
                  : (email == null && onboarding == "Yes")
                      ? LoginScreen()
                      : WelcomeScreen(),
            ));
  }
}
