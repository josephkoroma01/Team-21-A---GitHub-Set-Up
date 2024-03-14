import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lifebloodworld/constants/images.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var subscription;
  String status = "Offline";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingPage(),
    );
  }
}

Future<bool> getInternetUsingInternetConnectivity() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => LoginScreen()),
    // );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/lifebloodbg.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(
    String assetName,
  ) {
    return Image.asset(
      'assets/icons/$assetName',
      width: 80.h,
      height: 80.h,
    );
  }

  String? onboarding;
  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('onboarding', onboarding!);
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    final Locale locale = Localizations.localeOf(context);
    // dropdown options
    var items = [
      'en',
      'fr',
    ];
    return 
    IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(0xFFe0e9e4),
      allowImplicitScrolling: false,
      infiniteAutoScroll: true,
      autoScrollDuration: 3500,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Images.logo,
                ],
              ),
            ),
          ),
        ),
      ),
      globalFooter: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
            child: SizedBox(
                width: double.infinity,
                child: FormBuilderDropdown(
                  onChanged: (String? newValue) {
                    LifeBlood.setLocale(context, Locale(newValue!));
                  },
                  decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    filled: true,
                    focusColor: kWhiteColor,
                    labelText: t.selectlanguage,
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: kWhiteColor,
                        letterSpacing: 0),
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: kWhiteColor),
                    hintText: t.selectlanguage,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ),
                  name: 'Select Language',
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(fontFamily: 'Montserrat',),
                      ),
                    );
                  }).toList(),
                )),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),

      pages: [
        PageViewModel(
          title: t.weaimto,
          body: t.increasesafeblood,
          image: _buildImage('transfusion.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Montserrat',
            ),
            bodyPadding: EdgeInsets.fromLTRB(10.w, 0.0, 10.w, 0.0),
            pageColor: const Color(0xFFe0e9e4),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: t.weaimto,
          body: t.increasevoluntary,
          image: _buildImage('vdonors.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Montserrat',
            ),
            bodyPadding: EdgeInsets.fromLTRB(10.w, 0.0, 10.w, 0.0),
            pageColor: const Color(0xFFe0e9e4),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: t.weaimto,
          body: t.establishpropercommunication,
          image: _buildImage('smartphone.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Montserrat',
            ),
            bodyPadding: EdgeInsets.fromLTRB(10.w, 0.w, 10.w, 0.w),
            pageColor: const Color(0xFFe0e9e4),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: t.weaimto,
          body: t.providepropercomm,
          image: _buildImage('bloodtest.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Montserrat',
            ),
            bodyPadding: EdgeInsets.fromLTRB(10.w, 0.w, 10.w, 0.w),
            pageColor: const Color(0xFFe0e9e4),
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () {
        setState(() {
          onboarding = "Yes";
          savePref();
        });
        Future.delayed(const Duration(seconds: 2));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback

      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showDoneButton: true,
      showNextButton: false,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(
        Icons.arrow_back,
        color: kPrimaryColor,
      ),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(
        Icons.arrow_forward,
        color: kPrimaryColor,
      ),
      done: Text(t.done,
          style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat')),
      curve: Curves.fastLinearToSlowEaseIn,

      controlsMargin: const EdgeInsets.all(20),
      controlsPadding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 0.h),
      dotsDecorator: DotsDecorator(
        size: Size(10.h, 10.h),
        color: const Color(0xFFBDBDBD),
        activeColor: kPrimaryColor,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
