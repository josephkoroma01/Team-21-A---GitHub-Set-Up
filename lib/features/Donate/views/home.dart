import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/features/Donate/views/joindonationcampaigns.dart';
import 'package:lifebloodworld/features/Donate/views/meligibilityscreen.dart';
import 'package:lifebloodworld/features/Donate/views/metrigger.dart';
import 'package:lifebloodworld/features/FAQ/welcome_screen.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Home/views/managebloodtestapp.dart';
import 'package:http/http.dart' as http;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../main.dart';
import '../../../constants/colors.dart';
import '../../../models/donationdrive_model.dart';
import 'search.dart';

class DonationCarddata {
  DonationCarddata({required this.donortype, required this.date});

  factory DonationCarddata.fromJson(Map<String, dynamic> json) {
    return DonationCarddata(donortype: json['donor_type'], date: json['date']);
  }

  String date;
  String donortype;
}

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class donate extends StatefulWidget {
  donate({Key? key}) : super(key: key);

  @override
  State<donate> createState() => _donateState();
}

class _donateState extends State<donate> with TickerProviderStateMixin {
  String? address;
  String? agecategory;
  String? bgbloodtestfor;
  String? bgdataready;
  String? bgdonationtype;
  String? bgfacility;
  String? bgstatus;
  String? bgtimeslot;
  String? bloodtype;
  String? community;
  String? communitydonor;
  String? dataready;
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());

  String? district;
  String? donated;
  bool donatenow = false;
  String donationquery = '';
  String? donationtype;
  String? donorid;
  String? email;
  String? facility;
  String? gender;
  String? getbda;
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());

  String? newscalltoaction;
  String? newsdescription;
  String? newslink;
  String? newsready;
  String? newstitle;
  String? nextdonationdate;
  final TextEditingController nextdonationdateinput =
      TextEditingController(text: formattedNextDonationDateFormat.toString());

  String? nody;
  int pageIndex = 0;
  String? phonenumber;
  String? prevdonation;
  String? prevdonationamt;
  String? status;
  late TabController tabController;
  late List tabs;
  String? timeslot;
  String? totalbgresult;
  String? totaldonation;
  String? totaldonationrep;
  String? totaldonationvol;
  String? totaldonationvolcan;
  String? totaldonationvolcon;
  String? totaldonationvold;
  String? totaldonationvolp;
  String? totaldonationvolr;
  String? totalsch;
  String? totalschfamily;
  String? totalschfriend;
  String? totalschmyself;
  String? ufname;
  String? ulname;
  String? umname;
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

  int _currentIndex = 0;
  final TextEditingController _feedbackCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Timer _getBgresulttimer;
  late Timer _getBgtschfamilytimer;
  late Timer _getBgtschfriendtimer;
  late Timer _getBgtschmyselftimer;
  late Timer _getBgtschtimer;
  late Timer _getBloodDonationDatatimer;
  late Timer _getBloodGroupDatatimer;
  late Timer _getDatatimer;
  late Timer _getDonationCardtimer;
  late Timer _getNewstimer;
  late Timer _getTotalDonationsReptimer;
  late Timer _getTotalDonationsVolcantimer;
  late Timer _getTotalDonationsVolcontimer;
  late Timer _getTotalDonationsVoldtimer;
  late Timer _getTotalDonationsVolptimer;
  late Timer _getTotalDonationsVolrtimer;
  late Timer _getTotalDonationsVoltimer;
  late Timer _getTotalDonationstimer;
  bool _isloginLoading = false;
  StreamController _streamController = StreamController();
  bool _validate = false;

  final _stopWatchTimer = StopWatchTimer();
  bool _isRunning = false;
  late Timer _weeklyResetTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    _startTimer();
    getPref();
    super.initState();
    tz.initializeTimeZones();
    _startWeeklyResetTimer();
    tabs = ['Donation Drives', 'Blood Donation'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);
    getCommunityDonationDrive();
    // getBloodDonationData();
    // getBloodGroupData();
    // getData();
    // getCommunityNews();
    // getTotalDonations();
    // getBgresult();
    // getBgtsch();
    // getBgtschmyself();
    // getBgtschfriend();
    // getBgtschfamily();
    // getTotalDonationsRep();
    // getTotalDonationsVol();
    // getTotalDonationsVold();
    // getTotalDonationsVolp();
    // getTotalDonationsVolcon();
    // getTotalDonationsVolr();
    // getTotalDonationsVolcan();
    // _getBloodDonationDatatimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBloodDonationData());
    // _getBloodGroupDatatimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBloodGroupData());
    // _getDatatimer =
    //     Timer.periodic(const Duration(seconds: 2), (timer) => getData());
    // _getNewstimer = Timer.periodic(
    //     const Duration(seconds: 1), (timer) => getCommunityNews());
    // _getTotalDonationstimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonations());
    // _getBgresulttimer =
    //     Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
    // _getBgtschtimer =
    //     Timer.periodic(const Duration(seconds: 2), (timer) => getBgtsch());
    // _getBgtschmyselftimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBgtschmyself());
    // _getBgtschfriendtimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBgtschfriend());
    // _getBgtschfamilytimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBgtschfamily());
    // _getTotalDonationsReptimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsRep());
    // _getTotalDonationsVoltimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVol());
    // _getTotalDonationsVoldtimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVold());
    // _getTotalDonationsVolptimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVolp());
    // _getTotalDonationsVolcontimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVolcon());
    // _getTotalDonationsVolrtimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVolr());
    // _getTotalDonationsVolcantimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getTotalDonationsVolcan());
  }

  void dispose() {
    _stopWatchTimer.dispose();
    if (_getBloodGroupDatatimer.isActive) _getBloodGroupDatatimer.cancel();
    if (_getBloodDonationDatatimer.isActive)
      _getBloodDonationDatatimer.cancel();
    if (_getDatatimer.isActive) _getDatatimer.cancel();
    if (_getDonationCardtimer.isActive) _getDonationCardtimer.cancel();
    if (_getNewstimer.isActive) _getNewstimer.cancel();
    if (_getTotalDonationstimer.isActive) _getTotalDonationstimer.cancel();
    if (_getBgresulttimer.isActive) _getBgresulttimer.cancel();
    if (_getBgtschtimer.isActive) _getBgtschtimer.cancel();
    if (_getBgtschmyselftimer.isActive) _getBgtschmyselftimer.cancel();
    if (_getBgtschfriendtimer.isActive) _getBgtschfriendtimer.cancel();
    if (_getBgtschfamilytimer.isActive) _getBgtschfamilytimer.cancel();
    if (_getTotalDonationsReptimer.isActive)
      _getTotalDonationsReptimer.cancel();
    if (_getTotalDonationsVoltimer.isActive)
      _getTotalDonationsVoltimer.cancel();
    if (_getTotalDonationsVoldtimer.isActive)
      _getTotalDonationsVoldtimer.cancel();
    if (_getTotalDonationsVolptimer.isActive)
      _getTotalDonationsVolptimer.cancel();
    if (_getTotalDonationsVolcontimer.isActive)
      _getTotalDonationsVolcontimer.cancel();
    if (_getTotalDonationsVolrtimer.isActive)
      _getTotalDonationsVolrtimer.cancel();
    if (_getTotalDonationsVolcantimer.isActive)
      _getTotalDonationsVolcantimer.cancel();
    tabController.dispose();
    super.dispose();
  }

  void _startWeeklyResetTimer() {
    final now = tz.TZDateTime.now(tz.local);
    final nextFriday = _nextFriday(now);
    final difference = nextFriday.difference(now);
    _weeklyResetTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = nextFriday.difference(tz.TZDateTime.now(tz.local));
      });
      if (difference <= Duration.zero) {
        timer.cancel();
      }
    });
  }

  tz.TZDateTime _nextFriday(tz.TZDateTime currentDate) {
    var nextFriday = currentDate.add(Duration(days: 1));
    while (nextFriday.weekday != DateTime.friday) {
      nextFriday = nextFriday.add(Duration(days: 1));
    }
    return tz.TZDateTime(
        tz.local, nextFriday.year, nextFriday.month, nextFriday.day, 20);
  }

  void _startTimer() {
    _stopWatchTimer.onStartTimer();
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _stopWatchTimer.onStopTimer();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopWatchTimer.onResetTimer();
    setState(() {
      _isRunning = false;
    });
  }

  String _formatTime(int milliseconds) {
    final Duration duration = Duration(milliseconds: milliseconds);
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }

  Future getBloodGroupData() async {
    var data = {'phonenumber': phonenumber, 'date': dateinput.text};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/bloodgrouptestts.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['bgtodayschStatus'] == true) {
      setState(() {
        bgdataready = "Yes";
        bgbloodtestfor = msg['userInfo']["bloodtestfor"];
        bgfacility = msg['userInfo']["facility"];
        bgdonationtype = msg['userInfo']["donor_type"];
        bgtimeslot = msg['userInfo']["timeslot"];
        bgstatus = msg['userInfo']["status"];
      });
    }
    return bgdataready;
  }

  Future getData() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/donationdate.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['donorStatusCheck'] == true) {
      setState(() {
        nextdonationdate = msg['userInfo']["nextdonation"];
        donorid = msg['userInfo']["donorid"];
        donated = "Yes";
        donatenow = true;
      });
      savenextdonationPref();
    } else if (msg['donorStatusCheck'] == false) {
      setState(() {
        donated = "No";
        donatenow = false;
        savenextdonationPref();
      });
    }
    return nextdonationdate;
  }

  Future makerequest() async {
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/DonationDrives.php"),
        body: {
          "firstname": ufname,
          "middlename": umname,
          "lastname": ulname,
          "agecategory": agecategory,
          "gender": gender,
          "phonenumber": phonenumber,
          "email": email,
          "district": district,
          "address": address,
          "bloodtype": bloodtype,
          "requestdistrict": 'Western Area',
          "facility": selectedFacility,
          "otherfacility": facilityCtrl.text,
          "requestaddress": _addressCtrl.text,
          "requestbloodtype": selectedBloodType,
          "bloodlitres": bloodlitresCtrl.text,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Try Again, Feedback Already Exists'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Request Made Successfully',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
            )),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));
      // scheduleAlarm();
    }
  }

  final List<String> facilityItems = [
    '34 Military Hospital',
    'Cottage/PCMH',
    'Connaught',
    'Rokupa'
  ];

  String? selectedFacility = '';

  final TextEditingController facilityCtrl = TextEditingController();
  List facilityList = [];
  final List<String> bloodgrouplist = [
    'A+',
    'A-',
    'AB+',
    'AB-',
    'B+',
    'B-',
    'O+',
    'O-',
  ];

  String query = '';
  TextEditingController refcode = TextEditingController();
  String? selectedBloodType = '';
  String? selectedDistrict = '';
  String? selectedReason = '';
  final TextEditingController timeinput = TextEditingController();
  final TextEditingController bloodlitresCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  final TextEditingController reasonCtrl = TextEditingController();

  final TextEditingController potentialdonorsdateinput =
      TextEditingController(text: formattedNewDate.toString());

  List<DonationDrives> communityDonationDrive = [];
  Future<List<DonationDrives>> getCommunityDonationDrive() async {
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donationcampaignsbycounrtry/1"),
      );

      if (response.statusCode == 200) {
        List<dynamic> msg = jsonDecode(response.body);

        List<DonationDrives> requests =
            msg.map((e) => DonationDrives.fromJson(e)).toList();

        setState(() {
          communityDonationDrive = requests;
        });
      }  

      return communityDonationDrive;
    } catch (e) {
      
    }

    return communityDonationDrive;
  }

  String? uname;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      countryId = prefs.getString('country_id');
      country = prefs.getString('country');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      prevdonationamt = prefs.getString('prevdonationamt');
      community = prefs.getString('community');
      communitydonor = prefs.getString('communitydonor');
      userId = prefs.getString('id');
      totaldonation = prefs.getString('totaldonation');
    });
  }

  savenextdonationPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nextdonationdate', nextdonationdate!);
    prefs.setString('donorid', donorid!);
    prefs.setString('donated', donated!);
  }

   

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 15.h),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Donate",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF205072)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFebf5f5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Why should I donate blood?",
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          decoration: TextDecoration.underline,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.squareArrowUpRight,
                                      color: Color(0xFF205072),
                                      size: 15,
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(dateinput.text,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: kWhiteColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: SizedBox(
                                          height: 5.h,
                                          child: const Divider(
                                            color: Colors.white,
                                            thickness: 0.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          5.verticalSpace,
                                          Column(
                                            children: [
                                              Visibility(
                                                visible: false,
                                                child: StreamBuilder<int>(
                                                  stream:
                                                      _stopWatchTimer.rawTime,
                                                  initialData: _stopWatchTimer
                                                      .rawTime.value,
                                                  builder: (context, snapshot) {
                                                    final value = snapshot.data;
                                                    final displayTime =
                                                        _formatTime(value!);
                                                    return Text(
                                                      displayTime,
                                                      style: TextStyle(
                                                          fontSize: 24.0),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Flexible(
                                                      child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: kWhiteColor,
                                                            shape: BoxShape
                                                                .rectangle),
                                                        child: Text(
                                                            '${_remainingTime.inDays}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize:
                                                                    14.h)),
                                                      ),
                                                      2.verticalSpace,
                                                      Text(
                                                        'days',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                                  Flexible(
                                                      child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: kWhiteColor,
                                                            shape: BoxShape
                                                                .rectangle),
                                                        child: Text(
                                                            '${_remainingTime.inHours.remainder(24)}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize:
                                                                    14.h)),
                                                      ),
                                                      2.verticalSpace,
                                                      Text(
                                                        'hrs',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                                  Flexible(
                                                      child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: kWhiteColor,
                                                            shape: BoxShape
                                                                .rectangle),
                                                        child: Text(
                                                            '${_remainingTime.inMinutes.remainder(60)}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize:
                                                                    14.h)),
                                                      ),
                                                      2.verticalSpace,
                                                      Text(
                                                        'min',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                                  Flexible(
                                                      child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: kWhiteColor,
                                                            shape: BoxShape
                                                                .rectangle),
                                                        child: Text(
                                                            '${_remainingTime.inSeconds.remainder(60)}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize:
                                                                    14.h)),
                                                      ),
                                                      2.verticalSpace,
                                                      Text(
                                                        'sec',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                              Text('Time till Next Donation',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white)),
                                              5.verticalSpace,
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: TextButton(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .idCard,
                                                                  color: Colors
                                                                      .teal,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    'Donor Card',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          11,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kPrimaryColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              kWhiteColor,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        managebloodtestAppointments()),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  5.horizontalSpace,
                                                  Flexible(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              kWhiteColor,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FAQPageScreen()),
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                FaIcon(
                                                                    FontAwesomeIcons
                                                                        .comments,
                                                                    color: Colors
                                                                        .teal),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text('FAQs',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          11,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kPrimaryColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              5.verticalSpace,
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FAQPageScreen()),
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                FaIcon(
                                                                    FontAwesomeIcons
                                                                        .history,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .teal),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    'Blood Donation History',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kPrimaryColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Color(0xff406986),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Community Blood Donation Drives',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      const SizedBox(
                                        width: double.infinity,
                                        child: SizedBox(
                                          child: Divider(
                                            color: Colors.white,
                                            thickness: 0.2,
                                          ),
                                        ),
                                      ),
                                      communityDonationDrive.isNotEmpty
                                          ? Column(
                                              children: communityDonationDrive
                                                  .map((e) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        .0,
                                                                        5.0,
                                                                        5.0,
                                                                        5.0),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          53,
                                                                          87,
                                                                          112),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            // Text('Blood Donor Request',
                                                                            //     textAlign: TextAlign.center,
                                                                            //     style: GoogleFonts.montserrat(fontSize: 10,
                                                                            //     letterSpacing: 0,
                                                                            //     color: kWhiteColor)),
                                                                            // SizedBox(
                                                                            //   height: 5.h,
                                                                            // ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text.rich(
                                                                                  TextSpan(
                                                                                    style: TextStyle(
                                                                                      color: Color(0xFF205072),
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: e.campaignfacility,
                                                                                        style: GoogleFonts.montserrat(
                                                                                          fontSize: 13,
                                                                                          letterSpacing: 0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: kWhiteColor,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                  textAlign: TextAlign.left,
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: kWhiteColor),
                                                                                  child: Text(
                                                                                    e.bloodcomponent.toString(),
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'Montserrat',
                                                                                      letterSpacing: 0,
                                                                                      color: kLifeBloodBlue,
                                                                                    ),
                                                                                    overflow: TextOverflow.clip,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Expanded(
                                                                                    child: Text(
                                                                                      e.campaignlocation.toString(),
                                                                                      style: TextStyle(
                                                                                        fontSize: 13,
                                                                                        overflow: TextOverflow.clip,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontFamily: 'Montserrat',
                                                                                        letterSpacing: 0,
                                                                                        color: kWhiteColor,
                                                                                      ),
                                                                                      overflow: TextOverflow.clip,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Text.rich(
                                                                              TextSpan(
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF205072),
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: e.campaignlocation,
                                                                                    style: GoogleFonts.montserrat(
                                                                                      fontSize: 13,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      color: kWhiteColor,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: Colors.white,
                                                                                backgroundColor: kWhiteColor,
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              ),
                                                                              onPressed: () {
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" + "&text=${Uri.encodeComponent('Hi LifeBlood, I want to volunteer to donate')}";
                                                                                try {
                                                                                  launch(whatsappUrl);
                                                                                } catch (e) {
                                                                                  //To handle error and display error message
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text('Could Not Launch WhatsApp', style: GoogleFonts.montserrat()),
                                                                                    backgroundColor: Colors.red,
                                                                                    behavior: SnackBarBehavior.fixed,
                                                                                    duration: Duration(seconds: 3),
                                                                                  ));
                                                                                }
                                                                              },
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text('Volunteer to Donate',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontSize: 12,
                                                                                        letterSpacing: 0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: kLifeBloodBlue,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: SizedBox(
                                                                height: 5.h,
                                                                child:
                                                                    const Divider(
                                                                  color: Colors
                                                                      .white,
                                                                  thickness:
                                                                      0.2,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          53,
                                                                          87,
                                                                          112),
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10))),
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .view_agenda_outlined,
                                                                      size: 15,
                                                                      color:
                                                                          kWhiteColor,
                                                                    ),
                                                                    5.horizontalSpace,
                                                                    Text(
                                                                        'View All Blood Donor Requests',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              11.sp,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                  .toList())
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'No Pending Blood Donation Drive',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 11),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text("$bloodtype",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                            )),
                                        Text('Drives Joined',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 11.h,
                                                color: Color.fromRGBO(
                                                    64, 105, 134, 1))),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Container(
                                        color: Color(0xFFe0e9e4),
                                        height: 50.h,
                                        width: 1.2.w,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text('$totaldonation',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 11.h,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal)),
                                        Text('Total Donations',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 11.h,
                                                color: Color(0xff406986))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => metriggerScreen()),
                );
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Container(
                              padding: EdgeInsets.all(15.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                // border: Border.all(color: kLifeBloodRed),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/images/alarm.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Make Emergency Trigger',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodRed)),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Notify the blood banks early.',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      letterSpacing: 0,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: kGreyColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => MEligibilityScreen(
                            quiz: 'No',
                          )),
                );
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Container(
                              padding: EdgeInsets.all(15.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFebf5f5),
                                // border: Border.all(color: kLifeBloodRed),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/icons/checklist.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Check Eligibility Status',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Not everyone can donate blood',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      letterSpacing: 0,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: kGreyColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // if donate is not eligible
                _showEligibilityDialog(context);
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Container(
                              padding: EdgeInsets.all(15.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFebf5f5),
                                // border: Border.all(color: kLifeBloodBlue),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/images/donation.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Schedule Blood Donation',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      letterSpacing: 0,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kLifeBloodBlue)),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '1 donation can save up to 3 lives',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: kGreyColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFebf5f5),
                              // border: Border.all(color: kLifeBloodBlue),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/images/drive.png',
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                20.horizontalSpace,
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text('Blood Donation Drives',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    letterSpacing: 0,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ),
                                        ],
                                      ),
                                      2.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Join, create and support drives',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    overflow: TextOverflow.clip,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kGreyColor)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _showEligibilityDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => RequestDialogContent());
  }
}

class RequestDialogContent extends StatefulWidget {
  RequestDialogContent({
    super.key,
  });

  @override
  State<RequestDialogContent> createState() => _RequestDialogContentState();
}

class _RequestDialogContentState extends State<RequestDialogContent> {
  Timer? debouncer;
  String donationquery = '';

  @override
  final TextEditingController timeInput = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
  @override
  void initState() {
    getPref();
    super.initState();
  }

  String? uname;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      countryId = prefs.getString('country_id');
    });
  }

  String? selectedrc = '';
  String? selectedrcsolved = '';
  String? selectedscsolved = '';
  String? selectedsc = '';
  String? selectedtrivianame = '';
  String? selectedSampleBrought = '';
  String? _selectedrcRadioGroupValue;
  final _formKey = GlobalKey<FormState>();
  bool _scheduling = false;
  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search Laboratory Tests',
        onChanged: searchBook,
      );

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  void _onChanged(dynamic val) => setState(() {
        // usercommunity = val;
        debugPrint(val.toString());
      });
  Future searchBook(String donationquery) async => debounce(() async {
        // final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          // this.donationschedule = donationschedule;
        });
      });

  Future<List<BloodTestingFacilities>> getBloodFacilities(
      String donationquery) async {
    final url = Uri.parse(
        'https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donationcampaignsbycounrtry/$countryId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodTestingFacilities.fromJson(json))
          .where((donationschedule) {
        final regionLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.communityname!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kLifeBloodBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Blood Donor Requests',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<List<BloodTestingFacilities>>(
                    future: getBloodFacilities(donationquery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: kLifeBloodBlue,
                        ));
                      } else if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.faceSadCry),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "No facility found",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Color(0xFFE02020)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5.r, right: 15.r, left: 15.r),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            color: Colors.teal,
                                          ),
                                          Text('Refresh Page',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.teal)),
                                        ],
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView(
                                  children: snapshot.data!
                                      .map((data) => Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(.0, 5.0,
                                                                  5.0, 5.0),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color:
                                                                        kLifeBloodBlue),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // Text(
                                                                      //     'Blood Donor Request',
                                                                      //     textAlign: TextAlign
                                                                      //         .center,
                                                                      //     style: GoogleFonts.montserrat(
                                                                      //         fontSize: 10,
                                                                      //         letterSpacing: 0,
                                                                      //         color: kGreyColor)),
                                                                      // SizedBox(
                                                                      //   height:
                                                                      //       5.h,
                                                                      // ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: data.name,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          // Container(
                                                                          //   padding:
                                                                          //       EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                          //   decoration:
                                                                          //       BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF205072)),
                                                                          //   child:
                                                                          //       Text(
                                                                          //     data.!,
                                                                          //     style: TextStyle(
                                                                          //       fontSize: 12,
                                                                          //       fontWeight: FontWeight.normal,
                                                                          //       fontFamily: 'Montserrat',
                                                                          //       letterSpacing: 0,
                                                                          //       color: kWhiteColor,
                                                                          //     ),
                                                                          //     overflow: TextOverflow.clip,
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Expanded(
                                                                              child: Text(
                                                                                data.address!,
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                  overflow: TextOverflow.clip,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontFamily: 'Montserrat',
                                                                                  letterSpacing: 0,
                                                                                  color: Color(0xFF205072),
                                                                                ),
                                                                                overflow: TextOverflow.clip,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF205072),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: data.district,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 13,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xFF205072),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        textHeightBehavior:
                                                                            TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      TextButton(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.whatsapp,
                                                                              size: 20,
                                                                            ),
                                                                            5.horizontalSpace,
                                                                            Text('Volunteer to Donate',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontSize: 13,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: kWhiteColor,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              kLifeBloodBlue,
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: ((context) => JoinDrives(
                                                                                    campaignname: 'Test',
                                                                                  ))));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              )
                            ]);
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
