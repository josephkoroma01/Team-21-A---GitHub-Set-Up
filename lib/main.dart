import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lifebloodworld/features/Home/views/bgresults.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:provider/provider.dart';
import 'features/Home/models/community_donor_request_model.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hive_boxes.dart';
import 'provider/manage_appointment_provider.dart';
import 'provider/prefs_provider.dart';
import 'utils/cloud-messaging.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.notification?.title}");
//   print("Handling a body background message: ${message.notification?.body}");
//   // print("Handling a background message: ${message.data}");
// }

String? id, countryid, email, onboarding;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  donorRequestBox = await Hive.openBox<CommunityDonorRequest>('DonorRequest');

  // Use countryList as needed
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseServices().initNotif();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  onboarding = prefs.getString('onboarding');
  id = prefs.getString('id');
  countryid = prefs.getString('country_id');
  print(countryid);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrefsProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseServices()),
        ChangeNotifierProvider(create: (_) => ManageAppoiynmentProvider()),
      ],
      child: const LifeBlood(),
    ),
  );
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
    Provider.of<PrefsProvider>(context, listen: false).getPref();
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
              routes: {
                '/notification': (context) =>
                    HomePageScreen(pageIndex: 3, userId: id.toString()),
                '/request': (context) =>
                    HomePageScreen(pageIndex: 2, userId: id.toString()),
                '/drives': (context) =>
                    HomePageScreen(pageIndex: 3, userId: id.toString()),
                '/result': (context) => BloodGroupResults()
              },
              navigatorKey: navigatorKey,
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
                      userId: id.toString(),
                      countryid: countryid.toString(),
                    )
                  : (email == null && onboarding == "Yes")
                      ? LoginScreen()
                      : WelcomeScreen(),
            ));
  }
}
