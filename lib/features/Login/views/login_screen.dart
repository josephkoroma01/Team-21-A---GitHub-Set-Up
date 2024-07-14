import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/models/user_model.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/bteligibilityscreen.dart';
import 'package:lifebloodworld/features/Login/views/eligibilityscreen.dart';
import 'package:lifebloodworld/features/Login/views/etrigger.dart';
import 'package:lifebloodworld/features/Login/views/forgetpassword.dart';
import 'package:lifebloodworld/features/Register/views/register.dart';
import 'package:lifebloodworld/utils/cloud-messaging.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/prefs_provider.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    // final Locale locale = Localizations.localeOf(context);
    // Size size = MediaQuery.of(context).size;
    return const Scaffold(
      body: LoginPage(),
    );
  }
}

var myid;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? selectedBloodType = '';
  final TextEditingController _birthdateinput = TextEditingController();

  final TextEditingController bloodlitresCtrl = TextEditingController();
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());
  String? id,
      email,
      password,
      ufname,
      umname,
      ulname,
      agecategory,
      gender,
      phonenumber,
      address,
      nin,
      district,
      bloodtype,
      prevdonation,
      prevdonationamt,
      community,
      communitydonor;

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  late Position _currentPosition;
  String? _currentAddress;

  List<double> _extractLatLng(String displayValue) {
    var latLngStrings =
        displayValue.split(',').map((str) => str.trim()).toList();
    if (latLngStrings.length != 2) {
      throw FormatException(
          "Invalid displayValue format. Expected 'latitude, longitude'");
    }
    return latLngStrings.map(double.parse).toList();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      myid = id;
    });
    // getPref();
    _passwordVisible = false;

    Provider.of<FirebaseServices>(context, listen: false).initNotif();
    _toggleServiceStatusStream();
    _getCurrentPosition();
    getToken();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _validate = false;
  bool _passwordVisible = false;
  bool _isloginLoading = false;

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  FocusNode focusNode = FocusNode();
  String? token;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('deviceToken');
    });

    print(token);
  }

  savePref(Users data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', "${data.user!.email}");
    prefs.setString('name', "${data.user!.name}");
    prefs.setString('uname', "${data.user!.username}");
    prefs.setString('avatar', "${data.user!.avartar}");
    prefs.setString('gender', "${data.user!.gender}");
    prefs.setString('agecategory', "${data.user!.ageCategory}");
    prefs.setString('age', "${data.user!.age}");
    prefs.setString('dob', "${data.user!.dob}");
    prefs.setString('country', "${data.user!.country}");
    prefs.setString('country_id', "${data.user!.countryId}");
    prefs.setString('phonenumber', "${data.user!.phone}");
    prefs.setString('address', "${data.user!.address}");
    prefs.setString('district', "${data.user!.distict}");
    prefs.setString('bloodtype', "${data.user!.bloodGroup}");
    prefs.setString('prevdonation', "${data.user!.prvdonation}");
    prefs.setString('prevdonationamt', "${data.user!.prvdonationNo}");
    prefs.setString('totaldonation', "${data.user!.noOfDonation}");
    prefs.setString('community', "${data.user!.community}");
    prefs.setString('id', "${data.user!.id}");
    prefs.setString('trivia', "${data.user!.trivia}");

  }

  String? holdPhoneNo;

  Future userLogin(context) async {
    final prefsProvider = Provider.of<PrefsProvider>(context, listen: false);
    if (_phonenumber.text.isNotEmpty && _password.text.isNotEmpty) {
      // Getting username and password from Controller
      var data = {
        'phone': '+232${_phonenumber.text}',
        'password': _password.text
      };
      print(_phonenumber.text);
      //Starting Web API Call.

      try {
        var response = await http.post(
          Uri.parse(
              "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/login"),
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          //Server response into variable
          var msg = jsonDecode(response.body);
          Users data = Users.fromJson(msg);

          //Check Login Status
          if (data.message == "Login successful") {
            savePref(data);
            prefsProvider.savePref(data.user!);

            updateToken(data.user!.id!.toString());
            setState(() {
              _isloginLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login Successful',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 10)),
              backgroundColor: Colors.teal,
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(seconds: 3),
            ));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePageScreen(
                          pageIndex: 0,
                          userId: data.user!.id.toString(),
                        )),
                (route) => false);
            // Navigate to Home Screen
          } else if (response.body == "Invalid Credentials") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Phone Number and Password is not correct, Please Try Again',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 10)),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(seconds: 3),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Something went wrong. Please try again ${response.statusCode}',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 10)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 3),
          ));
          setState(() {
            _isloginLoading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong. Please try again $e',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 10)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 3),
        ));
        setState(() {
          _isloginLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter Phone Number or Password',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 11)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 5),
      ));
      setState(() {
        _isloginLoading = false;
      });
    }
  }

  Future updateToken(String id) async {
    String deviceToken =
        Provider.of<FirebaseServices>(context, listen: false).deviceToken;

    var data = {
      'device_token': deviceToken,
    };
    //Starting Web API Call.
    try {
      await http.post(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/updateUser/$id"),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // print(response);
    } catch (e) {}
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    print(position.toString());
    _updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription =
          serviceStatusStream.handleError((error) {
        _serviceStatusStreamSubscription?.cancel();
        _serviceStatusStreamSubscription = null;
      }).listen((serviceStatus) {
        String serviceStatusValue;
        if (serviceStatus == ServiceStatus.enabled) {
          if (positionStreamStarted) {
            _toggleListening();
          }
          serviceStatusValue = 'enabled';
        } else {
          if (_positionStreamSubscription != null) {
            setState(() {
              _positionStreamSubscription?.cancel();
              _positionStreamSubscription = null;
              _updatePositionList(
                  _PositionItemType.log, 'Position Stream has been canceled');
            });
          }
          serviceStatusValue = 'disabled';
        }
        _updatePositionList(
          _PositionItemType.log,
          'Location service has been $serviceStatusValue',
        );
      });
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => _updatePositionList(
            _PositionItemType.position,
            position.toString(),
          ));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      String statusDisplayValue;
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
        statusDisplayValue = 'resumed';
      } else {
        _positionStreamSubscription!.pause();
        statusDisplayValue = 'paused';
      }

      _updatePositionList(
        _PositionItemType.log,
        'Listening for position updates $statusDisplayValue',
      );
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  void _getLastKnownPosition() async {
    final position = await _geolocatorPlatform.getLastKnownPosition();
    print(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position!.latitude, position.longitude);

    Placemark place = placemarks[0];

    setState(() {
      _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
    });
    print(_currentAddress);
    if (position != null) {
      _updatePositionList(
        _PositionItemType.position,
        position.toString(),
      );
    } else {
      _updatePositionList(
        _PositionItemType.log,
        'No last known position available',
      );
    }
  }

  void _getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    _handleLocationAccuracyStatus(status);
  }

  void _requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    _handleLocationAccuracyStatus(status);
  }

  void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
    _updatePositionList(
      _PositionItemType.log,
      '$locationAccuracyStatusValue location accuracy granted.',
    );
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    _updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    _updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFe0e9e4),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 30.h, left: 30.h, right: 30.h),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntlPhoneField(
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontFamily: 'Montserrat'),
                              focusNode: focusNode,
                              validator: (value) {
                                if (value == null) {
                                  return 'Phone Number is required';
                                }
                                return null;
                              },
                              controller: _phonenumber,
                              decoration: InputDecoration(
                                counterText: '',
                                isDense: true,
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontFamily: 'Montserrat'),
                                errorStyle: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontFamily: 'Montserrat'),
                                helperStyle: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontFamily: 'Montserrat'),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontFamily: 'Montserrat'),
                                border: InputBorder.none,
                              ),
                              languageCode: "en",
                              onChanged: (phone) {
                                // setState(() {
                                //   holdPhoneNo = phone.completeNumber;
                                // });
                              },
                              onCountryChanged: (country) {
                                print('Country changed to: ' + country.name);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _password,
                              obscureText: !_passwordVisible,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: TextStyle(
                                    fontFamily: 'Montserrat', letterSpacing: 0),
                                focusColor: Colors.teal,
                                labelText: t.enterpassword,
                                labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFF205072),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  color: const Color(0xFF205072),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(t.forgotpassword,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.teal,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: _isloginLoading
                                  ? SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Text(
                                      t.login,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold),
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await getInternetUsingInternetConnectivity()) {
                                    setState(() {
                                      _isloginLoading = true;
                                    });
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             HomePageScreen(
                                    //               pageIndex: 0,
                                    //             )),
                                    //     (route) => false);
                                    // setState(() {
                                    //   holdPhoneNo = _phonenumber.text;
                                    // });
                                    userLogin(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.wifi_off_sharp,
                                            color: kWhiteColor,
                                          ),
                                          5.horizontalSpace,
                                          Text('You are currently offline',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: kWhiteColor)),
                                        ],
                                      ),
                                      backgroundColor: kGreyColor,
                                      behavior: SnackBarBehavior.fixed,
                                      duration: const Duration(seconds: 10),
                                      // duration: Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  _validate;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          10.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Divider(
                              thickness: 0.20,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Create Account'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await getInternetUsingInternetConnectivity()) {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      // _getLastKnownPosition();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                      // setState(() {
                                      //   _isloginLoading = false;
                                      // });
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.wifi_off_sharp,
                                            color: kWhiteColor,
                                          ),
                                          5.horizontalSpace,
                                          Text('You are currently offline',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: kWhiteColor)),
                                        ],
                                      ),
                                      backgroundColor: kGreyColor,
                                      behavior: SnackBarBehavior.fixed,
                                      duration: const Duration(seconds: 10),
                                      // duration: Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  _validate;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: kWhiteColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          10.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Schedule New Appointment'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.teal.shade50,
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20.0,
                                                20.0,
                                                20.0,
                                                0.0), // content padding
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'Schedule New Appointment',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor)),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                                child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EligibilityScreen(
                                                                  quiz: 'No',
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5.w),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(10
                                                                              .r),
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      FaIcon(
                                                                        FontAwesomeIcons
                                                                            .handHoldingDroplet,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Text(
                                                                          'Blood Donation',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 14,
                                                                              color: kPrimaryColor)),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      // Text('Know Your Blood Type',
                                                                      //     textAlign: TextAlign.center,
                                                                      //     style: GoogleFonts.montserrat(
                                                                      //         fontSize: 10,
                                                                      //         color: Colors.grey)),
                                                                      // SizedBox(
                                                                      //   height: 5.h,
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BTEligibilityScreen(),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5.w),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .fire,
                                                                          color:
                                                                              kPrimaryColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Text(
                                                                            'Blood Group Test',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.montserrat(fontSize: 14, color: kPrimaryColor)),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        // Text('Know Your Blood Type',
                                                                        //     textAlign: TextAlign.center,
                                                                        //     style: GoogleFonts.montserrat(
                                                                        //         fontSize: 10,
                                                                        //         color: Colors.grey)),
                                                                        // SizedBox(
                                                                        //   height: 5.h,
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EligibilityScreen(
                                                                    quiz: 'Yes',
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5.w),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .teal,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .personCircleQuestion,
                                                                          color:
                                                                              kWhiteColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Text(
                                                                            'Eligibility Quiz',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.montserrat(fontSize: 14, color: kWhiteColor)),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        // Text('Know Your Blood Type',
                                                                        //     textAlign: TextAlign.center,
                                                                        //     style: GoogleFonts.montserrat(
                                                                        //         fontSize: 10,
                                                                        //         color: Colors.grey)),
                                                                        // SizedBox(
                                                                        //   height: 5.h,
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    });

                                // if (_formKey.currentState!.validate()) {
                                //   if (await getInternetUsingInternetConnectivity()) {
                                //     setState(() {
                                //       _isloginLoading = true;
                                //     });
                                //     Navigator.of(context).pushAndRemoveUntil(
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 HomePageScreen(
                                //                   pageIndex: 0,
                                //                 )),
                                //         (route) => false);
                                //     userLogin();
                                //   } else {
                                //     ScaffoldMessenger.of(context)
                                //         .showSnackBar(SnackBar(
                                //       content: Row(
                                //         children: [
                                //           Icon(Icons.wifi_off_sharp, color: kWhiteColor,),
                                //           5.horizontalSpace,
                                //           Text(
                                //               'You are currently offline',
                                //               textAlign: TextAlign.center,
                                //               style: GoogleFonts.montserrat(
                                //                   fontSize: 12, color: kWhiteColor)),
                                //         ],
                                //       ),
                                //       backgroundColor: kGreyColor,
                                //       behavior: SnackBarBehavior.fixed,
                                //       duration: const Duration(seconds: 10),
                                //       // duration: Duration(seconds: 3),
                                //     ));
                                //   }
                                // } else {
                                //   _validate;
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: kLifeBloodBlue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          10.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Make A Trigger'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => etriggerScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: kLifeBloodRed,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextButton(
              //         child: Text(t.dhaveanaccountsign,
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.montserrat(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xFF205072))),
              //         style: TextButton.styleFrom(
              //           foregroundColor: Color(0xFF205072),
              //           backgroundColor: Colors.transparent,
              //           shape: const RoundedRectangleBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(10))),
              //         ),
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             new MaterialPageRoute(
              //               builder: (context) => RegisterScreen(),
              //             ),
              //           );
              //         }),
              //   ],
              // ),
              //
              // Text(
              //   'Blood Donor Needed!\nContact Donor Support Now',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kLifeBloodBlue,
              //       fontSize: 13,
              //       letterSpacing: 0,
              //       fontFamily: 'Montserrat'),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     TextButton(
              //       child: Row(children: [
              //         FaIcon(FontAwesomeIcons.whatsapp),

              //       ]),
              //       style: TextButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         backgroundColor: Color(0xFFaf0d0c),
              //         shape: const CircleBorder(
              //             ),
              //       ),
              //       onPressed: () async {
              //           showModalBottomSheet(
              //               isScrollControlled: true,
              //               backgroundColor: Color(0xFFebf5f5),
              //               context: context,
              //               builder: (context) {
              //                 return SingleChildScrollView(
              //                   child: Container(
              //                     padding: EdgeInsets.only(
              //                         bottom: MediaQuery.of(context)
              //                             .viewInsets
              //                             .bottom),
              //                     child: Padding(
              //                       padding: EdgeInsets.fromLTRB(20.0, 20.0,
              //                           20.0, 0.0), // content padding
              //                       child: Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 10.h,
              //                             ),
              //                             InkWell(
              //                               onTap: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.end,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.end,
              //                                 children: [
              //                                   Text(' Close',
              //                                       textAlign: TextAlign.center,
              //                                       style:
              //                                           GoogleFonts.montserrat(
              //                                               fontSize: 13,
              //                                               color: Colors.red)),
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text(
              //                                 'Request for \nBlood Community Donor(s)',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Color(0xff389e9d))),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Container(
              //                               width: double.infinity,
              //                               child: SizedBox(
              //                                 child: Divider(
              //                                   color: Colors.teal,
              //                                   thickness: 1,
              //                                 ),
              //                                 height: 5.h,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text('Ask LifeBlood for Help\n',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 14,
              //                                     fontWeight: FontWeight.normal,
              //                                     color: Color(0xff406986))),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text('Where is the blood needed?',
              //                                     textAlign: TextAlign.left,
              //                                     style: GoogleFonts.montserrat(
              //                                         fontSize: 12,
              //                                         fontWeight:
              //                                             FontWeight.normal,
              //                                         color:
              //                                             Color(0xff389e9d))),
              //                               ],
              //                             ),
              //                             SizedBox(height: 5.h),
              //                             Form(
              //                               key: _formKey,
              //                               child: Column(
              //                                 children: [
              //                                   Row(
              //                                     children: [
              //                                       Icon(
              //                                         Icons.info_outline,
              //                                         size: 17,
              //                                       ),
              //                                       Text(
              //                                           ' Currently, LifeBlood is only available in Freetown.',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 11,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Colors
              //                                                       .black)),
              //                                     ],
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),

              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'What bloodtype is needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   DropdownButtonFormField2(
              //                                     decoration: InputDecoration(
              //                                       labelText: 'Blood Group',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                       //Add isDense true and zero Padding.
              //                                       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              //                                       isDense: true,
              //                                       contentPadding:
              //                                           EdgeInsets.only(
              //                                               left: 5),
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       //Add more decoration as you want here
              //                                       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              //                                     ),
              //                                     buttonStyleData: const ButtonStyleData(
              //   padding: EdgeInsets.only(right: 0, left: 0),
              // ),
              // iconStyleData: const IconStyleData(
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     color: Colors.black45,
              //   ),
              //   iconSize: 30,
              // ),
              // dropdownStyleData: DropdownStyleData(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // ),
              // menuItemStyleData: const MenuItemStyleData(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              // ),
              //                                     items: bloodgrouplist
              //                                         .map((item) =>
              //                                             DropdownMenuItem<
              //                                                 String>(
              //                                               value: item,
              //                                               child: Text(
              //                                                 item,
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                 ),
              //                                               ),
              //                                             ))
              //                                         .toList(),
              //                                     validator: (value) {
              //                                       if (value == null) {
              //                                         return 'Please select an option.';
              //                                       }
              //                                     },
              //                                     onChanged: (String? value) {
              //                                       setState(() {
              //                                         selectedBloodType = value;
              //                                       });
              //                                     },
              //                                     onSaved: (value) {
              //                                       selectedBloodType =
              //                                           value.toString();
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   TextFormField(
              //                                     keyboardType:
              //                                         TextInputType.number,
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Unit of is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       labelText:
              //                                           'Units of Blood Required',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                     ),
              //                                     controller: bloodlitresCtrl,
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'When is the blood needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   TextFormField(
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Date is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     controller:
              //                                         dateinput, //editing controller of this TextField
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       // icon: Icon(Icons.calendar_today), //icon of text field
              //                                       labelText: "Date",
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'), //label text of field
              //                                     ),
              //                                     readOnly:
              //                                         true, //set it true, so that user will not able to edit text
              //                                     onTap: () async {
              //                                       DateTime? pickedDate =
              //                                           await showDatePicker(
              //                                               context: context,
              //                                               initialDate:
              //                                                   DateTime.now(),
              //                                               firstDate: DateTime
              //                                                   .now(), //DateTime.now() - not to allow to choose before today.
              //                                               lastDate:
              //                                                   DateTime(2101));

              //                                       if (pickedDate != null) {
              //                                         print(
              //                                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //                                         String formattedDate =
              //                                             DateFormat(
              //                                                     'd MMM yyyy')
              //                                                 .format(
              //                                                     pickedDate);
              //                                         print(
              //                                             formattedDate); //formatted date output using intl package =>  2021-03-16
              //                                         //you can implement different kind of Date Format here according to your requirement

              //                                         setState(() {
              //                                           dateinput.text =
              //                                               formattedDate; //set output date to TextField value.
              //                                         });
              //                                       } else {
              //                                         print(
              //                                             "Date is not selected");
              //                                       }
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   SizedBox(
              //                                     width: double.infinity,
              //                                     child: ElevatedButton(
              //                                       style: ButtonStyle(
              //                                         backgroundColor:
              //                                             MaterialStateProperty
              //                                                 .all(Colors.teal),
              //                                       ),
              //                                       onPressed: () async {

              //                                         if (_formKey.currentState!
              //                                             .validate()) {
              //                                          FocusManager.instance.foregroundColorFocus?.unfocus();
              //         var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
              //             "&text=${Uri.encodeComponent('Hi LifeBlood, I need a Blood Donor')}";
              //         try {
              //           launch(whatsappUrl);
              //         } catch (e) {
              //           //To handle error and display error message
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //             content: Text('Could Not Launch WhatsApp',
              //                 style: GoogleFonts.montserrat()),
              //             backgroundColor: Colors.red,
              //             behavior: SnackBarBehavior.fixed,
              //             duration: Duration(seconds: 3),
              //           ));
              //         }
              //                                         }
              //                                       },
              //                                       child: const Text(
              //                                         'Request for Community Donor',
              //                                         style: TextStyle(
              //                                             fontFamily:
              //                                                 'Montserrat'),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 20.h),
              //                                 ],
              //                               ),
              //                             )
              //                           ]),
              //                     ),
              //                   ),
              //                 );
              //               });

              //       },
              //     ),
              //     TextButton(
              //       child: Row(children: [
              //         FaIcon(FontAwesomeIcons.squarePhoneFlip),

              //       ]),
              //       style: TextButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         backgroundColor: Color(0xFFaf0d0c),
              //         shape: const CircleBorder(
              //             ),
              //       ),
              //       onPressed: () async {
              //           showModalBottomSheet(
              //               isScrollControlled: true,
              //               backgroundColor: Color(0xFFebf5f5),
              //               context: context,
              //               builder: (context) {
              //                 return SingleChildScrollView(
              //                   child: Container(
              //                     padding: EdgeInsets.only(
              //                         bottom: MediaQuery.of(context)
              //                             .viewInsets
              //                             .bottom),
              //                     child: Padding(
              //                       padding: EdgeInsets.fromLTRB(20.0, 20.0,
              //                           20.0, 0.0), // content padding
              //                       child: Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 10.h,
              //                             ),
              //                             InkWell(
              //                               onTap: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.end,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.end,
              //                                 children: [
              //                                   Text(' Close',
              //                                       textAlign: TextAlign.center,
              //                                       style:
              //                                           GoogleFonts.montserrat(
              //                                               fontSize: 13,
              //                                               color: Colors.red)),
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text(
              //                                 'Request for \nBlood Community Donor(s)',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Color(0xff389e9d))),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Container(
              //                               width: double.infinity,
              //                               child: SizedBox(
              //                                 child: Divider(
              //                                   color: Colors.teal,
              //                                   thickness: 1,
              //                                 ),
              //                                 height: 5.h,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text('Ask LifeBlood for Help\n',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 14,
              //                                     fontWeight: FontWeight.normal,
              //                                     color: Color(0xff406986))),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text('Where is the blood needed?',
              //                                     textAlign: TextAlign.left,
              //                                     style: GoogleFonts.montserrat(
              //                                         fontSize: 12,
              //                                         fontWeight:
              //                                             FontWeight.normal,
              //                                         color:
              //                                             Color(0xff389e9d))),
              //                               ],
              //                             ),
              //                             SizedBox(height: 5.h),
              //                             Form(
              //                               key: _formKey,
              //                               child: Column(
              //                                 children: [
              //                                   Row(
              //                                     children: [
              //                                       Icon(
              //                                         Icons.info_outline,
              //                                         size: 17,
              //                                       ),
              //                                       Text(
              //                                           ' Currently, LifeBlood is only available in Freetown.',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 11,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Colors
              //                                                       .black)),
              //                                     ],
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),

              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'What bloodtype is needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   DropdownButtonFormField2(
              //                                     decoration: InputDecoration(
              //                                       labelText: 'Blood Group',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                       //Add isDense true and zero Padding.
              //                                       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              //                                       isDense: true,
              //                                       contentPadding:
              //                                           EdgeInsets.only(
              //                                               left: 5),
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       //Add more decoration as you want here
              //                                       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              //                                     ),
              //                                     buttonStyleData: const ButtonStyleData(
              //   padding: EdgeInsets.only(right: 0, left: 0),
              // ),
              // iconStyleData: const IconStyleData(
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     color: Colors.black45,
              //   ),
              //   iconSize: 30,
              // ),
              // dropdownStyleData: DropdownStyleData(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // ),
              // menuItemStyleData: const MenuItemStyleData(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              // ),
              //                                     items: bloodgrouplist
              //                                         .map((item) =>
              //                                             DropdownMenuItem<
              //                                                 String>(
              //                                               value: item,
              //                                               child: Text(
              //                                                 item,
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                 ),
              //                                               ),
              //                                             ))
              //                                         .toList(),
              //                                     validator: (value) {
              //                                       if (value == null) {
              //                                         return 'Please select an option.';
              //                                       }
              //                                     },
              //                                     onChanged: (String? value) {
              //                                       setState(() {
              //                                         selectedBloodType = value;
              //                                       });
              //                                     },
              //                                     onSaved: (value) {
              //                                       selectedBloodType =
              //                                           value.toString();
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   TextFormField(
              //                                     keyboardType:
              //                                         TextInputType.number,
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Unit of is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       labelText:
              //                                           'Units of Blood Required',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                     ),
              //                                     controller: bloodlitresCtrl,
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'When is the blood needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   TextFormField(
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Date is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     controller:
              //                                         dateinput, //editing controller of this TextField
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       // icon: Icon(Icons.calendar_today), //icon of text field
              //                                       labelText: "Date",
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'), //label text of field
              //                                     ),
              //                                     readOnly:
              //                                         true, //set it true, so that user will not able to edit text
              //                                     onTap: () async {
              //                                       DateTime? pickedDate =
              //                                           await showDatePicker(
              //                                               context: context,
              //                                               initialDate:
              //                                                   DateTime.now(),
              //                                               firstDate: DateTime
              //                                                   .now(), //DateTime.now() - not to allow to choose before today.
              //                                               lastDate:
              //                                                   DateTime(2101));

              //                                       if (pickedDate != null) {
              //                                         print(
              //                                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //                                         String formattedDate =
              //                                             DateFormat(
              //                                                     'd MMM yyyy')
              //                                                 .format(
              //                                                     pickedDate);
              //                                         print(
              //                                             formattedDate); //formatted date output using intl package =>  2021-03-16
              //                                         //you can implement different kind of Date Format here according to your requirement

              //                                         setState(() {
              //                                           dateinput.text =
              //                                               formattedDate; //set output date to TextField value.
              //                                         });
              //                                       } else {
              //                                         print(
              //                                             "Date is not selected");
              //                                       }
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   SizedBox(
              //                                     width: double.infinity,
              //                                     child: ElevatedButton(
              //                                       style: ButtonStyle(
              //                                         backgroundColor:
              //                                             MaterialStateProperty
              //                                                 .all(Colors.teal),
              //                                       ),
              //                                       onPressed: () async {

              //                                         if (_formKey.currentState!
              //                                             .validate()) {
              //                                          FocusManager.instance.foregroundColorFocus?.unfocus();
              //         var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
              //             "&text=${Uri.encodeComponent('Hi LifeBlood, I need a Blood Donor')}";
              //         try {
              //           launch(whatsappUrl);
              //         } catch (e) {
              //           //To handle error and display error message
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //             content: Text('Could Not Launch WhatsApp',
              //                 style: GoogleFonts.montserrat()),
              //             backgroundColor: Colors.red,
              //             behavior: SnackBarBehavior.fixed,
              //             duration: Duration(seconds: 3),
              //           ));
              //         }
              //                                         }
              //                                       },
              //                                       child: const Text(
              //                                         'Request for Community Donor',
              //                                         style: TextStyle(
              //                                             fontFamily:
              //                                                 'Montserrat'),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 20.h),
              //                                 ],
              //                               ),
              //                             )
              //                           ]),
              //                     ),
              //                   ),
              //                 );
              //               });

              //       },
              //     ),

              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
