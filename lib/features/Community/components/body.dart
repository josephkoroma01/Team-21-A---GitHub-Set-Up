import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/FAQ/welcome_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestschedule.dart';
import 'package:lifebloodworld/features/Home/views/knowbloodtype.dart';
import 'package:lifebloodworld/features/Home/views/managebloodtestapp.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';
import '../../../constants/colors.dart';

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

class community extends StatefulWidget {
  community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> with TickerProviderStateMixin {
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
    getBloodDonationData();
    getBloodGroupData();
    getData();
    getCommunityNews();
    getTotalDonations();
    getBgresult();
    getBgtsch();
    getBgtschmyself();
    getBgtschfriend();
    getBgtschfamily();
    getTotalDonationsRep();
    getTotalDonationsVol();
    getTotalDonationsVold();
    getTotalDonationsVolp();
    getTotalDonationsVolcon();
    getTotalDonationsVolr();
    getTotalDonationsVolcan();
    _getBloodDonationDatatimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getBloodDonationData());
    _getBloodGroupDatatimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getBloodGroupData());
    _getDatatimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getData());
    _getNewstimer = Timer.periodic(
        const Duration(seconds: 1), (timer) => getCommunityNews());
    _getTotalDonationstimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonations());
    _getBgresulttimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
    _getBgtschtimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getBgtsch());
    _getBgtschmyselftimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getBgtschmyself());
    _getBgtschfriendtimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getBgtschfriend());
    _getBgtschfamilytimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getBgtschfamily());
    _getTotalDonationsReptimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsRep());
    _getTotalDonationsVoltimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVol());
    _getTotalDonationsVoldtimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVold());
    _getTotalDonationsVolptimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVolp());
    _getTotalDonationsVolcontimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVolcon());
    _getTotalDonationsVolrtimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVolr());
    _getTotalDonationsVolcantimer = Timer.periodic(
        const Duration(seconds: 2), (timer) => getTotalDonationsVolcan());
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

  Future getBgresult() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgroupresult.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalbgresults'] == true) {
      setState(() {
        totalbgresult = msg['userInfo'].toString();
      });
      savetbgrPref();
    }
    return totalbgresult;
  }

  Future getBgtsch() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgrouptestsch.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalsch'] == true) {
      setState(() {
        totalsch = msg['userInfo'].toString();
      });
      savetschPref();
    }
    return totalsch;
  }

  Future getBgtschmyself() async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Myself'};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgrouptestschmyself.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalschmyself'] == true) {
      setState(() {
        totalschmyself = msg['userInfo'].toString();
      });
      savetschmyselfPref();
    }
    return totalschmyself;
  }

  Future getBgtschfriend() async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Friend'};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgrouptestschfriend.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalschfriend'] == true) {
      setState(() {
        totalschfriend = msg['userInfo'].toString();
      });
      savetschfriendPref();
    }
    return totalschfriend;
  }

  Future getBgtschfamily() async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Family'};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgrouptestschfamily.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalschfamily'] == true) {
      setState(() {
        totalschfamily = msg['userInfo'].toString();
      });
      savetschfamilyPref();
    }
    return totalschfamily;
  }

  savetschmyselfPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalschmyself', totalschmyself!);
  }

  savetschfriendPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalschfriend', totalschfriend!);
  }

  savetschfamilyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalschfamily', totalschfamily!);
  }

  savetbgrPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalsch', totalsch!);
  }

  savetschPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalbgresult', totalbgresult!);
  }

  Future getBloodDonationData() async {
    var data = {'phonenumber': phonenumber, 'date': dateinput.text};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/blooddonationts.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['todayschStatus'] == true) {
      setState(() {
        dataready = "Yes";
        facility = msg['userInfo']["facility"];
        donationtype = msg['userInfo']["donor_type"];
        timeslot = msg['userInfo']["timeslot"];
        status = msg['userInfo']["status"];
      });
    }
    return dataready;
  }

  Future getCommunityNews() async {
    var data = {'status': 'Active'};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/communityappnews.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['commmuitynews'] == true) {
      setState(() {
        newsready = "Yes";
        newstitle = msg['userInfo']["title"];
        newsdescription = msg['userInfo']["description"];
        newscalltoaction = msg['userInfo']["cta"];
        newslink = msg['userInfo']["link"];
      });
      savenewsPref();
    } else if (msg['commmuitynews'] == false) {
      setState(() {
        newsready = "No";
      });
      savenewsPref();
    }
    return newsready;
  }

  Future getTotalDonations() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonations.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonations'] == true) {
      setState(() {
        totaldonation = msg['userInfo'].toString();
      });
      savetdPref();
    }
    return totaldonation;
  }

  Future getTotalDonationsRep() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsrep.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsrep'] == true) {
      setState(() {
        totaldonationrep = msg['userInfo'].toString();
      });
      savetdrepPref();
    }
    return totaldonationrep;
  }

  Future getTotalDonationsVol() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvol.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvol'] == true) {
      setState(() {
        totaldonationvol = msg['userInfo'].toString();
      });
      savetdvolPref();
    }
    return totaldonationvol;
  }

  Future getTotalDonationsVold() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvold.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvold'] == true) {
      setState(() {
        totaldonationvold = msg['userInfo'].toString();
      });
      savetdvoldPref();
    }
    return totaldonationvold;
  }

  Future getTotalDonationsVolp() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvolp.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvolp'] == true) {
      setState(() {
        totaldonationvolp = msg['userInfo'].toString();
      });
      savetdvolpPref();
    }
    return totaldonationvolp;
  }

  Future getTotalDonationsVolcon() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvolcon.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvolcon'] == true) {
      setState(() {
        totaldonationvolcon = msg['userInfo'].toString();
      });
      savetdvolconPref();
    }
    return totaldonationvolcon;
  }

  Future getTotalDonationsVolr() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvolr.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvolr'] == true) {
      setState(() {
        totaldonationvolr = msg['userInfo'].toString();
      });
      savetdvolrPref();
    }
    return totaldonationvolr;
  }

  Future getTotalDonationsVolcan() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/totaldonationsvolcan.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totaldonationsvolcan'] == true) {
      setState(() {
        totaldonationvolcan = msg['userInfo'].toString();
      });
      savetdvolcanPref();
    }
    return totaldonationvolcan;
  }

  savetdrepPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationrep', totaldonationrep!);
  }

  savetdvolPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvol', totaldonationvol!);
  }

  savetdvoldPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvold', totaldonationvold!);
  }

  savetdvolpPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvolp', totaldonationvolp!);
  }

  savetdvolconPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvolcon', totaldonationvolcon!);
  }

  savetdvolrPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvolr', totaldonationvolr!);
  }

  savetdvolcanPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonationvolcan', totaldonationvolcan!);
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

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      setState(() {
        getbda == "Yes";
      });
      final List donationschedule = json.decode(response.body);

      return donationschedule
          .map((json) => BloodDonationSchAppdata.fromJson(json))
          .where((donationschedule) {
        final facilityLower = donationschedule.facility.toLowerCase();
        final refcodeLower = donationschedule.refcode.toLowerCase();
        final searchLower = donationquery.toLowerCase();

        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<DonationCarddata>> getDonationCard() async {
    var data = {'phonenumber': phonenumber};

    try {
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/donationcard.php"),
          body: json.encode(data));
      if (response.statusCode == 200) {
        print(response.statusCode);

        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<DonationCarddata> bloodtestschList =
            items.map<DonationCarddata>((json) {
          return DonationCarddata.fromJson(json);
        }).toList();
        return bloodtestschList;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future makerequest() async {
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/communitydonorrequest.php"),
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
              fontSize: 13.sp,
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
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _dateinput = TextEditingController();
  final TextEditingController _birthdateinput = TextEditingController();
  final TextEditingController _firstnameCtrl = TextEditingController();

  bool _isbcdLoading = false;
  final TextEditingController _lastnameCtrl = TextEditingController();
  final TextEditingController _middlenameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController reasonCtrl = TextEditingController();
  late Timer _getReplacementtimer;
  late Timer _getPreftimer;

  final TextEditingController potentialdonorsdateinput =
      TextEditingController(text: formattedNewDate.toString());

  Future registerinterest() async {
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/potentialdonors.php"),
        body: {
          "firstname": ufname,
          "middlename": umname,
          "lastname": ulname,
          "birthdate": _birthdateinput.text,
          "agecategory": agecategory,
          "gender": gender,
          "phonenumber": phonenumber,
          "email": email,
          "district": district,
          "reason": selectedReason,
          "date": potentialdonorsdateinput.text,
          "month": monthinput.text,
          "year": yearinput.text,
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Try Again, Interest Already Exists',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Interest Registered Successfully',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
            )),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));
      // scheduleAlarm();
    }
  }

  Future sendfeedback() async {
    if (_feedbackCtrl.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/communityfeedback.php"),
          body: {
            "firstname": ufname,
            "lastname": ulname,
            "agecategory": agecategory,
            "gender": gender,
            "phonenumber": phonenumber,
            "email": email,
            "district": district,
            "bloodtype": bloodtype,
            "feedback": _feedbackCtrl.text,
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
          content: SizedBox(
            height: 20.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Feedback Successful Sent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0,
                      fontSize: 14.sp,
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 5),
        ));
        // scheduleAlarm();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(
              pageIndex: 0,
            ),
          ),
        );
      }
    }
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      prevdonationamt = prefs.getString('prevdonationamt');
      community = prefs.getString('community');
      communitydonor = prefs.getString('communitydonor');
      nextdonationdate = prefs.getString('nextdonationdate');
      donorid = prefs.getString('donorid');
      donated = prefs.getString('donated');
      newsready = prefs.getString('newsready');
      newstitle = prefs.getString('newstitle');
      newsdescription = prefs.getString('newsdescription');
      newslink = prefs.getString('newslink');
      newscalltoaction = prefs.getString('newscalltoaction');
      totaldonation = prefs.getString('totaldonation');
      totalbgresult = prefs.getString('totalbgresult');
      totalsch = prefs.getString('totalsch');
      totalschmyself = prefs.getString('totalschmyself');
      totalschfriend = prefs.getString('totalschfriend');
      totalschfamily = prefs.getString('totalschfamily');
      totaldonationrep = prefs.getString('totaldonationrep');
      totaldonationvol = prefs.getString('totaldonationvol');
      totaldonationvold = prefs.getString('totaldonationvold');
      totaldonationvolp = prefs.getString('totaldonationvolp');
      totaldonationvolcon = prefs.getString('totaldonationvolcon');
      totaldonationvolr = prefs.getString('totaldonationvolr');
      totaldonationvolcan = prefs.getString('totaldonationvolcan');
    });
  }

  savenextdonationPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nextdonationdate', nextdonationdate!);
    prefs.setString('donorid', donorid!);
    prefs.setString('donated', donated!);
  }

  savetdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonation', totaldonation!);
  }

  savenodyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nody', nody!);
  }

  savenewsPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('newsready', newsready!);
    prefs.setString('newstitle', newstitle!);
    prefs.setString('newsdescription', newsdescription!);
    prefs.setString('newslink', newslink!);
    prefs.setString('newscalltoaction', newscalltoaction!);
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

  _tabsContent() {
    if (_currentIndex == 0) {
      return Column(
        children: [
          (dataready == "Yes")
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Donor Type: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$donationtype",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Facility: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$facility",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Time Slot: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$timeslot",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$status",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'No Blood Donation Schedule',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      );
    } else if (_currentIndex == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (bgdataready == "Yes")
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Blood Group For: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '$bgbloodtestfor',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Facility: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '$bgfacility',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Time Slot: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$bgtimeslot",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xFF205072),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$bgstatus",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'No Blood Group Test Schedule',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.sp,
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
                                
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('LifeBlood Donor Mobilization Analysis',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor)),
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
                                          color: kPrimaryColor,
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
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('Communities ', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0,color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          5.horizontalSpace,
                                           Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('Champions ', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0, color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        5.verticalSpace,
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('Universities ', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0,color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          5.horizontalSpace,
                                           Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('Ambassadors ', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0, color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          
                                           
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        5.verticalSpace,
                                        Row(
                                          children: [
                                           
                                           Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('School Clubs ', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0, color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          
                                           
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        5.verticalSpace,
                                        Row(
                                          children: [
                                           
                                           Flexible(
                                              child: Container(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Text('Donation Groups', 
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0, color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp),)),
                                                    Text(
                                                        '${_remainingTime.inDays}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize:
                                                                14.h)),
                                                  ],
                                                ),
                                              ),
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
            SizedBox(
              height: 5.h,
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
                              color: Colors.transparent,
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text('University Ambassador',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('Act As liaison officer between LifeBlood & your University',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          if (await getInternetUsingInternetConnectivity()) {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Color(0xFFebf5f5),
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MediaQuery.of(context)
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
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(' Close',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            color: Colors
                                                                                .red)),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Request for \nBlood Community Donor(s)',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xff389e9d))),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Container(
                                                                width:
                                                                    double.infinity,
                                                                child: SizedBox(
                                                                  child: Divider(
                                                                    color:
                                                                        Colors.teal,
                                                                    thickness: 1,
                                                                  ),
                                                                  height: 5.h,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Ask LifeBlood for Help\n',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xff406986))),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Where is the blood needed?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .normal,
                                                                          color: Color(
                                                                              0xff389e9d))),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5.h),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .info_outline,
                                                                          size: 17,
                                                                        ),
                                                                        Text(
                                                                            ' Currently, LifeBlood is only available in Freetown.',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.black)),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        labelText:
                                                                            'Facility',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    8),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      isExpanded:
                                                                          true,
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: facilityItems
                                                                          .map(
                                                                              (items) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              items,
                                                                          child:
                                                                              Text(
                                                                            items,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select a facility.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (dynamic
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedFacility =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedFacility =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'What bloodtype is needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Blood Group',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    5),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: bloodgrouplist
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value:
                                                                                    item,
                                                                                child:
                                                                                    Text(
                                                                                  item,
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select an option.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedBloodType =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedBloodType =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Unit of is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        labelText:
                                                                            'Units of Blood Required',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                      ),
                                                                      controller:
                                                                          bloodlitresCtrl,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'When is the blood needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Date is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                          dateinput, //editing controller of this TextField
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        // icon: Icon(Icons.calendar_today), //icon of text field
                                                                        labelText:
                                                                            "Date",
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'), //label text of field
                                                                      ),
                                                                      readOnly:
                                                                          true, //set it true, so that user will not able to edit text
                                                                      onTap:
                                                                          () async {
                                                                        DateTime?
                                                                            pickedDate =
                                                                            await showDatePicker(
                                                                                context:
                                                                                    context,
                                                                                initialDate:
                                                                                    DateTime.now(),
                                                                                firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                                                lastDate: DateTime(2101));
                                    
                                                                        if (pickedDate !=
                                                                            null) {
                                                                          print(
                                                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                          String
                                                                              formattedDate =
                                                                              DateFormat('d MMM yyyy')
                                                                                  .format(pickedDate);
                                                                          print(
                                                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                          //you can implement different kind of Date Format here according to your requirement
                                    
                                                                          setState(
                                                                              () {
                                                                            dateinput.text =
                                                                                formattedDate; //set output date to TextField value.
                                                                          });
                                                                        } else {
                                                                          print(
                                                                              "Date is not selected");
                                                                        }
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(
                                                                                  Colors.teal),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            if (await getInternetUsingInternetConnectivity()) {
                                                                              Navigator.pop(
                                                                                  context);
                                                                              ScaffoldMessenger.of(context)
                                                                                  .showSnackBar(
                                                                                SnackBar(
                                                                                    backgroundColor: Colors.teal,
                                                                                    content: SingleChildScrollView(
                                                                                        child: Container(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                          SizedBox(
                                                                                            height: 15.0,
                                                                                            width: 15.0,
                                                                                            child: CircularProgressIndicator(
                                                                                              color: Colors.white,
                                                                                              strokeWidth: 2.0,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text.rich(
                                                                                            TextSpan(
                                                                                              style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                              children: [
                                                                                                TextSpan(
                                                                                                  text: 'Requesting Blood Donor for ',
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(
                                                                                                  recognizer: TapGestureRecognizer()
                                                                                                    ..onTap = () {
                                                                                                      // Single tapped.
                                                                                                    },
                                                                                                  text: selectedBloodType,
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    color: Colors.amber,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                            textAlign: TextAlign.left,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Container(
                                                                                            width: double.infinity,
                                                                                            child: SizedBox(
                                                                                              child: Divider(
                                                                                                color: Colors.white,
                                                                                                thickness: 1,
                                                                                              ),
                                                                                              height: 5.h,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text('The Gift of Blood irs a gift of Love.\nLet’s Share the Love.',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 14.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ))
                                                                                        ]),
                                                                                      ),
                                                                                    ))),
                                                                              );
                                                                              Future.delayed(
                                                                                  Duration(seconds: 3),
                                                                                  () async {
                                                                                makerequest();
                                                                              });
                                                                            }
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Request for Community Donor',
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                                  'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20.h),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10.sp)),
                                              backgroundColor: Color(0xFFE02020),
                                              behavior: SnackBarBehavior.fixed,
                                              duration: const Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.squareArrowUpRight, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Know More',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      letterSpacing: 0,
                                                      color: Colors.white)),
                                            ]),
                                      ),
                                    ),
                                    5.horizontalSpace,
                                  Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: ()  async{
                                         
    const url =
        'https://lifebloodsl.com/uamb.php';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.userPlus, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Join Us Today',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      letterSpacing: 0,
                                                      color: Colors.white)),
                                            ]),
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
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
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
                              color: Colors.transparent,
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text('Community Champions',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('Raise awareness, educate, & mobilize people as a Community Champion.',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          if (await getInternetUsingInternetConnectivity()) {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Color(0xFFebf5f5),
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MediaQuery.of(context)
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
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(' Close',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            color: Colors
                                                                                .red)),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Request for \nBlood Community Donor(s)',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xff389e9d))),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Container(
                                                                width:
                                                                    double.infinity,
                                                                child: SizedBox(
                                                                  child: Divider(
                                                                    color:
                                                                        Colors.teal,
                                                                    thickness: 1,
                                                                  ),
                                                                  height: 5.h,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Ask LifeBlood for Help\n',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xff406986))),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Where is the blood needed?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .normal,
                                                                          color: Color(
                                                                              0xff389e9d))),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5.h),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .info_outline,
                                                                          size: 17,
                                                                        ),
                                                                        Text(
                                                                            ' Currently, LifeBlood is only available in Freetown.',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.black)),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        labelText:
                                                                            'Facility',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    8),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      isExpanded:
                                                                          true,
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: facilityItems
                                                                          .map(
                                                                              (items) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              items,
                                                                          child:
                                                                              Text(
                                                                            items,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select a facility.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (dynamic
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedFacility =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedFacility =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'What bloodtype is needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Blood Group',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    5),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: bloodgrouplist
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value:
                                                                                    item,
                                                                                child:
                                                                                    Text(
                                                                                  item,
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select an option.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedBloodType =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedBloodType =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Unit of is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        labelText:
                                                                            'Units of Blood Required',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                      ),
                                                                      controller:
                                                                          bloodlitresCtrl,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'When is the blood needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Date is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                          dateinput, //editing controller of this TextField
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        // icon: Icon(Icons.calendar_today), //icon of text field
                                                                        labelText:
                                                                            "Date",
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'), //label text of field
                                                                      ),
                                                                      readOnly:
                                                                          true, //set it true, so that user will not able to edit text
                                                                      onTap:
                                                                          () async {
                                                                        DateTime?
                                                                            pickedDate =
                                                                            await showDatePicker(
                                                                                context:
                                                                                    context,
                                                                                initialDate:
                                                                                    DateTime.now(),
                                                                                firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                                                lastDate: DateTime(2101));
                                    
                                                                        if (pickedDate !=
                                                                            null) {
                                                                          print(
                                                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                          String
                                                                              formattedDate =
                                                                              DateFormat('d MMM yyyy')
                                                                                  .format(pickedDate);
                                                                          print(
                                                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                          //you can implement different kind of Date Format here according to your requirement
                                    
                                                                          setState(
                                                                              () {
                                                                            dateinput.text =
                                                                                formattedDate; //set output date to TextField value.
                                                                          });
                                                                        } else {
                                                                          print(
                                                                              "Date is not selected");
                                                                        }
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(
                                                                                  Colors.teal),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            if (await getInternetUsingInternetConnectivity()) {
                                                                              Navigator.pop(
                                                                                  context);
                                                                              ScaffoldMessenger.of(context)
                                                                                  .showSnackBar(
                                                                                SnackBar(
                                                                                    backgroundColor: Colors.teal,
                                                                                    content: SingleChildScrollView(
                                                                                        child: Container(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                          SizedBox(
                                                                                            height: 15.0,
                                                                                            width: 15.0,
                                                                                            child: CircularProgressIndicator(
                                                                                              color: Colors.white,
                                                                                              strokeWidth: 2.0,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text.rich(
                                                                                            TextSpan(
                                                                                              style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                              children: [
                                                                                                TextSpan(
                                                                                                  text: 'Requesting Blood Donor for ',
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(
                                                                                                  recognizer: TapGestureRecognizer()
                                                                                                    ..onTap = () {
                                                                                                      // Single tapped.
                                                                                                    },
                                                                                                  text: selectedBloodType,
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    color: Colors.amber,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                            textAlign: TextAlign.left,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Container(
                                                                                            width: double.infinity,
                                                                                            child: SizedBox(
                                                                                              child: Divider(
                                                                                                color: Colors.white,
                                                                                                thickness: 1,
                                                                                              ),
                                                                                              height: 5.h,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text('The Gift of Blood irs a gift of Love.\nLet’s Share the Love.',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 14.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ))
                                                                                        ]),
                                                                                      ),
                                                                                    ))),
                                                                              );
                                                                              Future.delayed(
                                                                                  Duration(seconds: 3),
                                                                                  () async {
                                                                                makerequest();
                                                                              });
                                                                            }
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Request for Community Donor',
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                                  'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20.h),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10.sp)),
                                              backgroundColor: Color(0xFFE02020),
                                              behavior: SnackBarBehavior.fixed,
                                              duration: const Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.squareArrowUpRight, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Know More',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                            ]),
                                      ),
                                    ),
                                    5.horizontalSpace,
                                  Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          const url =
        'https://lifebloodsl.com/cchampion.php';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.userPlus, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Join Us Today',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                            ]),
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
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
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
                              color: Colors.transparent,
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text('LifeBlood School Clubs',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('Engage students in the activities of the LifeBlood.',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          if (await getInternetUsingInternetConnectivity()) {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Color(0xFFebf5f5),
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MediaQuery.of(context)
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
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(' Close',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            color: Colors
                                                                                .red)),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Request for \nBlood Community Donor(s)',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xff389e9d))),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Container(
                                                                width:
                                                                    double.infinity,
                                                                child: SizedBox(
                                                                  child: Divider(
                                                                    color:
                                                                        Colors.teal,
                                                                    thickness: 1,
                                                                  ),
                                                                  height: 5.h,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  'Ask LifeBlood for Help\n',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xff406986))),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Where is the blood needed?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .normal,
                                                                          color: Color(
                                                                              0xff389e9d))),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5.h),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .info_outline,
                                                                          size: 17,
                                                                        ),
                                                                        Text(
                                                                            ' Currently, LifeBlood is only available in Freetown.',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.black)),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        labelText:
                                                                            'Facility',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    8),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      isExpanded:
                                                                          true,
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: facilityItems
                                                                          .map(
                                                                              (items) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              items,
                                                                          child:
                                                                              Text(
                                                                            items,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select a facility.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (dynamic
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedFacility =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedFacility =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'What bloodtype is needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    DropdownButtonFormField2(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Blood Group',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                        //Add isDense true and zero Padding.
                                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.only(
                                                                                left:
                                                                                    5),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        //Add more decoration as you want here
                                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                      ),
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                0),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color: Colors
                                                                              .black45,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16),
                                                                      ),
                                                                      items: bloodgrouplist
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value:
                                                                                    item,
                                                                                child:
                                                                                    Text(
                                                                                  item,
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select an option.';
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          selectedBloodType =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        selectedBloodType =
                                                                            value
                                                                                .toString();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Unit of is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        labelText:
                                                                            'Units of Blood Required',
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'),
                                                                      ),
                                                                      controller:
                                                                          bloodlitresCtrl,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'When is the blood needed?',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize:
                                                                                    12.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d))),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Date is required';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                          dateinput, //editing controller of this TextField
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5),
                                                                        ),
                                                                        // icon: Icon(Icons.calendar_today), //icon of text field
                                                                        labelText:
                                                                            "Date",
                                                                        labelStyle: TextStyle(
                                                                            fontSize: 13
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Montserrat'), //label text of field
                                                                      ),
                                                                      readOnly:
                                                                          true, //set it true, so that user will not able to edit text
                                                                      onTap:
                                                                          () async {
                                                                        DateTime?
                                                                            pickedDate =
                                                                            await showDatePicker(
                                                                                context:
                                                                                    context,
                                                                                initialDate:
                                                                                    DateTime.now(),
                                                                                firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                                                lastDate: DateTime(2101));
                                    
                                                                        if (pickedDate !=
                                                                            null) {
                                                                          print(
                                                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                          String
                                                                              formattedDate =
                                                                              DateFormat('d MMM yyyy')
                                                                                  .format(pickedDate);
                                                                          print(
                                                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                          //you can implement different kind of Date Format here according to your requirement
                                    
                                                                          setState(
                                                                              () {
                                                                            dateinput.text =
                                                                                formattedDate; //set output date to TextField value.
                                                                          });
                                                                        } else {
                                                                          print(
                                                                              "Date is not selected");
                                                                        }
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.h),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(
                                                                                  Colors.teal),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            if (await getInternetUsingInternetConnectivity()) {
                                                                              Navigator.pop(
                                                                                  context);
                                                                              ScaffoldMessenger.of(context)
                                                                                  .showSnackBar(
                                                                                SnackBar(
                                                                                    backgroundColor: Colors.teal,
                                                                                    content: SingleChildScrollView(
                                                                                        child: Container(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                          SizedBox(
                                                                                            height: 15.0,
                                                                                            width: 15.0,
                                                                                            child: CircularProgressIndicator(
                                                                                              color: Colors.white,
                                                                                              strokeWidth: 2.0,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text.rich(
                                                                                            TextSpan(
                                                                                              style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                              children: [
                                                                                                TextSpan(
                                                                                                  text: 'Requesting Blood Donor for ',
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(
                                                                                                  recognizer: TapGestureRecognizer()
                                                                                                    ..onTap = () {
                                                                                                      // Single tapped.
                                                                                                    },
                                                                                                  text: selectedBloodType,
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    fontSize: 14.sp,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    color: Colors.amber,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                            textAlign: TextAlign.left,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Container(
                                                                                            width: double.infinity,
                                                                                            child: SizedBox(
                                                                                              child: Divider(
                                                                                                color: Colors.white,
                                                                                                thickness: 1,
                                                                                              ),
                                                                                              height: 5.h,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text('The Gift of Blood irs a gift of Love.\nLet’s Share the Love.',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 14.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ))
                                                                                        ]),
                                                                                      ),
                                                                                    ))),
                                                                              );
                                                                              Future.delayed(
                                                                                  Duration(seconds: 3),
                                                                                  () async {
                                                                                makerequest();
                                                                              });
                                                                            }
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Request for Community Donor',
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                                  'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20.h),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10.sp)),
                                              backgroundColor: Color(0xFFE02020),
                                              behavior: SnackBarBehavior.fixed,
                                              duration: const Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.squareArrowUpRight, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Know More',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                            ]),
                                      ),
                                    ),
                                    5.horizontalSpace,
                                  Flexible(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          
                                          const url =
        'https://lifebloodsl.com/school_club.php';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
                                        
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.userPlus, size: 15,),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text('Register School',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                            ]),
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
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
