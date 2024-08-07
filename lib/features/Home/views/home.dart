import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lifebloodworld/features/Home/views/blooddonorrequest.dart';
import 'package:lifebloodworld/features/Home/views/leaderboard.dart';
import 'package:lifebloodworld/features/Home/views/quiz.dart';
import 'package:lifebloodworld/features/Home/views/trivia.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:lifebloodworld/provider/manage_appointment_provider.dart';
import 'package:provider/provider.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../hive_boxes.dart';
import '../../../main.dart';
import '../../../constants/colors.dart';
import '../../../models/bhloodtestschedule_model.dart';
import '../../../models/donationschedule.dart';
import '../../../provider/prefs_provider.dart';
import '../models/community_donor_request_model.dart';
import '../models/user_model.dart';
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

class home extends StatefulWidget {
  home({Key? key, this.userId, this.countryId}) : super(key: key);

  String? userId;
  String? countryId;

  @override
  State<home> createState() => _nameState();
}

class _nameState extends State<home> with TickerProviderStateMixin {
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
  String? totaldonation = "0";
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
  String? name;
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

  String? uname;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  String? token;

  int? totalBloodTestSchedule = 0;
  int? totalBloodTestScheduleMyself = 0;
  int? totalBloodTestScheduleOthers = 0;
  int? totalBloodTestScheduleResult = 0;
  int? totalBloodDonationReplacement = 0;
  int? totalBloodDonationVolumtary = 0;

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
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
      token = prefs.getString('deviceToken');
    });
  }

  @override
  void initState() {
    getPref();
    _startTimer();
    print('Country id: ${widget.countryId}');
    // updateToken();
    getCommunityDonorRequest();

    super.initState();
    tz.initializeTimeZones();
    // _startWeeklyResetTimer();
    loadCommunityDonorRequest().then((requests) {
      setState(() {
        communityDonorRequest = requests;
      });
    });

    getCommunityNews();
    getBloodTestAllAppointment();
    getBloodDonationAllAppointment();
    // donorRequestBox = Hive.box<List<CommunityDonorRequest>>('DonorRequest');

    // _getBloodDonationDatatimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBloodDonationData());
    // _getBloodGroupDatatimer = Timer.periodic(
    //     const Duration(seconds: 2), (timer) => getBloodGroupData());
    // _getDatatimer =
    //     Timer.periodic(const Duration(seconds: 2), (timer) => getData());
    // _getNewstimer = Timer.periodic(
    //     const Duration(seconds: 1), (timer) => getCommunityNews());

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

  List<TestSchedule> bloodtestAppointments = [];
  List<Schedule> blooddonationAppointments = [];
  Future getBloodTestAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloostestschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        BloodTestSchedule data = BloodTestSchedule.fromJson(jsonData);

        List<TestSchedule> schedules = data.schedule!;

        print(data);

        setState(() {
          bloodtestAppointments = schedules;
          totalBloodTestSchedule = bloodtestAppointments.length;
          totalBloodTestScheduleMyself = bloodtestAppointments
              .where((item) => item.bloodtestfor == 'Myself')
              .length;
          totalBloodTestScheduleOthers = bloodtestAppointments
              .where((item) => item.bloodtestfor != 'Myself')
              .length;
          totalBloodTestScheduleResult = bloodtestAppointments
              .where((item) => item.result == 'Yes')
              .length;
        });
        setState(() {
          prefs.setInt('totalschedule', totalBloodTestSchedule!);
          prefs.setInt('BcountMyself', totalBloodTestScheduleMyself!);
          prefs.setInt('BcountOther', totalBloodTestScheduleOthers!);
          prefs.setInt('Bresult', totalBloodTestScheduleResult!);
        });

        return bloodtestAppointments;
      } else {}
    } catch (e) {}
  }

  Future getBloodDonationAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloosdonationschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        DonationSchedule data = DonationSchedule.fromJson(jsonData);

        List<Schedule> schedules = data.schedule!;
        print(data);
        setState(() {
          blooddonationAppointments = schedules;
          totalBloodDonationReplacement = blooddonationAppointments
              .where((item) => item.donorType == 'Replacement')
              .length;
          totalBloodDonationVolumtary = blooddonationAppointments
              .where((item) => item.donorType == 'Volunteer')
              .length;
        });
        setState(() {
          prefs.setInt('replacement', totalBloodDonationReplacement!);
          prefs.setInt('voluntary', totalBloodDonationVolumtary!);
        });

        return bloodtestAppointments;
      } else {}
    } catch (e) {}
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

  List<CommunityDonorRequest> communityDonorRequest = [];
  List<CommunityDonorRequest> donorRequests = [];
  Future<List<CommunityDonorRequest>> getCommunityDonorRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/countrycommunitydonorrequests/${widget.countryId}"),
      );
      if (response.statusCode == 200) {
        List<dynamic> msg = jsonDecode(response.body);
        List<CommunityDonorRequest> request =
            msg.map((e) => CommunityDonorRequest.fromJson(e)).toList();

        setState(() {
          donorRequests = request;
        });
        List<String> requests =
            donorRequests.map((e) => jsonEncode(e.toJson())).toList();
        await prefs.setStringList('communityDonorRequest', requests);

        // await saveCommunityDonorRequest(request);
        setState(() {
          loadCommunityDonorRequest();
        });

        return request;
      }
      return communityDonorRequest;
    } catch (e) {
      print(e.toString());
    }

    return communityDonorRequest;
  }

  Future<void> saveCommunityDonorRequest(
      List<CommunityDonorRequest> requests) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(requests.map((e) => e.toJson()).toList());
    await prefs.setString('communityDonorRequest', jsonString);
  }

  Future<List<CommunityDonorRequest>> loadCommunityDonorRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonString = prefs.getStringList('communityDonorRequest');
    if (jsonString != null) {
      // List<dynamic> jsonResponse = jsonDecode(jsonString);
      List<CommunityDonorRequest> requests = jsonString
          .map((e) => CommunityDonorRequest.fromJson(json.decode(e)))
          .toList();

      setState(() {
        communityDonorRequest = requests;
      });
      return requests;
    }
    return [];
  }

  // savePref(Users data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('email', "${data.user!.email}");
  //   prefs.setString('name', "${data.user!.name}");
  //   prefs.setString('uname', "${data.user!.username}");
  //   prefs.setString('avatar', "${data.user!.avartar}");
  //   prefs.setString('gender', "${data.user!.gender}");
  //   prefs.setString('agecategory', "${data.user!.ageCategory}");
  //   prefs.setString('age', "${data.user!.age}");
  //   prefs.setString('dob', "${data.user!.dob}");
  //   prefs.setString('country', "${data.user!.country}");
  //   prefs.setString('country_id', "${data.user!.countryId}");
  //   prefs.setString('phonenumber', "${data.user!.phone}");
  //   prefs.setString('address', "${data.user!.address}");
  //   prefs.setString('district', "${data.user!.distict}");
  //   prefs.setString('bloodtype', "${data.user!.bloodGroup}");
  //   prefs.setString('prevdonation', "${data.user!.prvdonation}");
  //   prefs.setString('prevdonationamt', "${data.user!.prvdonationNo}");
  //   prefs.setString('community', "${data.user!.community}");
  //   prefs.setString('id', "${data.user!.id}");
  // }

  Future getCommunityNews() async {
    var data = {'status': 'Active'};
    var response = await http.get(
      Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/newsfeed"),
    );
    print(response.body);
    var msg = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        newsready = "Yes";
        newstitle = msg[0]["title"];
        newsdescription = msg[0]["description"];
        newscalltoaction = msg[0]["cta"];
        newslink = msg[0]["link"];
      });

      savenewsPref();
    } else if (response.statusCode != 200) {
      setState(() {
        newsready = "No";
      });
    }
    return newsready;
  }

  // Future com

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
                      fontSize: 14,
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

  @override
  Widget build(BuildContext context) {
    // var t = AppLocalizations.of(context)!;/
    Provider.of<PrefsProvider>(context, listen: false).getPref();

    return Scaffold(
      backgroundColor: const Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072)),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Thanks for making a difference',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontSize: 15,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomePageScreen(pageIndex: 4)));
                              },
                              child: Image.asset(
                                "assets/images/bronze-medal.png",
                                height: 40,
                                // width: size.width * 0.4,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.solidStar,
                                      size: 25, color: Colors.amber)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
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
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('News Feed',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                  fontSize: 12,
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
                                            color: Colors.teal,
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
                                          ((newsready == "Yes"))
                                              ? Column(
                                                  children: [
                                                    Text("$newstitle",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .teal)),
                                                    Text("$newsdescription",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .teal)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: TextButton(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                FaIcon(
                                                                    FontAwesomeIcons
                                                                        .squareArrowUpRight,
                                                                    size: 15),
                                                                5.horizontalSpace,
                                                                Text(
                                                                    '$newscalltoaction',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                              ],
                                                            ),
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.teal,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              //To remove the keyboard when button is pressed
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                              var linkUrl =
                                                                  "$newslink";
                                                              try {
                                                                launch(linkUrl);
                                                              } catch (e) {
                                                                //To handle error and display error message
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      'Could Not Launch Link',
                                                                      style: GoogleFonts
                                                                          .montserrat()),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .fixed,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              4),
                                                                ));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        5.horizontalSpace,
                                                        Flexible(
                                                          child: TextButton(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .solidNewspaper,
                                                                  size: 15,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                5.horizontalSpace,
                                                                Text(
                                                                    'See Other News',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kPrimaryColor,
                                                                    )),
                                                              ],
                                                            ),
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.teal
                                                                      .shade100,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          HomePageScreen(
                                                                              pageIndex: 3)));
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    const Text("No News Today",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 0,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.teal)),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    kPrimaryColor,
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const managebloodtestAppointments(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .solidNewspaper,
                                                                    size: 15,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  5.horizontalSpace,
                                                                  Text(
                                                                      'See Older News',
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
                                                                            FontWeight.w400,
                                                                        color:
                                                                            kWhiteColor,
                                                                      )),
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
                                        height: 5.h,
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
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('LifeBlood Trivia',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
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
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Colors.teal.shade100,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                            ),
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyQuiz(),
                                                  ),
                                                  (route) => false);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.play,
                                                  size: 15,
                                                  color: kPrimaryColor,
                                                ),
                                                5.horizontalSpace,
                                                Text('Start LifeBlood Trivia',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 11,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kPrimaryColor,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Colors.teal.shade100,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                            ),
                                            onPressed: () {
                                              _showDialog(context, uname);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.peopleLine,
                                                  size: 15,
                                                  color: kPrimaryColor,
                                                ),
                                                5.horizontalSpace,
                                                Text('Join LifeBlood Trivia',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 11,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kPrimaryColor,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          const Text('Every Friday from 08:00',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white)),
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
                                                      style: const TextStyle(
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
                                                            const EdgeInsets
                                                                .only(
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
                                                      const Text(
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
                                                            const EdgeInsets
                                                                .only(
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
                                                      const Text(
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
                                                            const EdgeInsets
                                                                .only(
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
                                              Text('Time till Next Session',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white)),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: SizedBox(
                                                  height: 5.h,
                                                  child: Divider(
                                                    color: Colors.white,
                                                    thickness: 0.2,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
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
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .fileContract,
                                                              size: 15,
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                            5.horizontalSpace,
                                                            Text('Trivia Rules',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 11,
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
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.teal
                                                                  .shade100,
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
                                                                        trivia()),
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
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidChessKing,
                                                              size: 15,
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                            5.horizontalSpace,
                                                            Text('Leaderboard',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 11,
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
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.teal
                                                                  .shade100,
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
                                                                        leaderboardbody()),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          // Column(
                                          //         children: [
                                          //           SizedBox(
                                          //             height: 5.h,
                                          //           ),
                                          //           SizedBox(
                                          //             width: double.infinity,
                                          //             child: SizedBox(
                                          //               child: Divider(
                                          //                 color: Colors.white,
                                          //                 thickness: 0.2,
                                          //               ),
                                          //               height: 5.h,
                                          //             ),
                                          //           ),
                                          //           SizedBox(
                                          //             height: 3.h,
                                          //           ),
                                          //           Text.rich(
                                          //             TextSpan(
                                          //               style: TextStyle(
                                          //                 color: Colors.white,
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                     FontWeight.w400,
                                          //               ),
                                          //               children: [
                                          //                 TextSpan(
                                          //                   text:
                                          //                       "Next Donation Date: ",
                                          //                   style: GoogleFonts
                                          //                       .montserrat(
                                          //                     fontSize: 11,
                                          //                     letterSpacing: 0,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w400,
                                          //                     color:
                                          //                         Colors.white,
                                          //                   ),
                                          //                 ),
                                          //                 TextSpan(
                                          //                   text:
                                          //                       nextdonationdate,
                                          //                   style: GoogleFonts
                                          //                       .montserrat(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color:
                                          //                         Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //             textHeightBehavior:
                                          //                 TextHeightBehavior(
                                          //                     applyHeightToFirstAscent:
                                          //                         false),
                                          //             textAlign: TextAlign.left,
                                          //           ),
                                          //         ],
                                          //       )
                                        ],
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
                                          Text('Community Blood Donor Requests',
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
                                      communityDonorRequest.isNotEmpty
                                          ? Builder(builder: (context) {
                                              return Column(
                                                  children:
                                                      communityDonorRequest
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
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            .0,
                                                                            5.0,
                                                                            5.0,
                                                                            5.0),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 10.w),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10.r),
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color.fromARGB(255, 53, 87, 112),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                                text: e.facility,
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
                                                                                            e.bloodtype.toString(),
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
                                                                                              e.address.toString(),
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
                                                                                            text: e.district,
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
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            5.h,
                                                                        child:
                                                                            Divider(
                                                                          color:
                                                                              Colors.white,
                                                                          thickness:
                                                                              0.2,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.view_agenda_outlined,
                                                                              size: 15,
                                                                              color: kWhiteColor,
                                                                            ),
                                                                            5.horizontalSpace,
                                                                            Text('View All Blood Donor Requests',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontSize: 11.sp,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: Colors.white,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor: Color.fromARGB(
                                                                              255,
                                                                              53,
                                                                              87,
                                                                              112),
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => blooddonorrequest(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ))
                                                          .toList());
                                            })
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
                                                            'No Pending Blood Donor Request',
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
                                        Text(bloodtype.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                            )),
                                        Text('Blood Type',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 13,
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
                                        Text(totaldonation!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal)),
                                        const Text('Total Donations',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 13,
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
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => scheduletypebody(),
                  ),
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
                                // border: Border.all(color: kLifeBloodBlue),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/images/blood-test.png',
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
                                                  'Schedule Blood Group Test',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
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
                                                  'Become a Potential Donor',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12,
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
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bloodtypebody(),
                  ),
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
                                // border: Border.all(color: kLifeBloodBlue),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/images/group.png',
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
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text('Blood Type Facts',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kLifeBloodBlue)),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Know about your blood type',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const managebloodtestAppointments(),
                  ),
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
                                // border: Border.all(color: kLifeBloodBlue),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/images/badge.png',
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
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text('Manage Appointments',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kLifeBloodBlue)),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'See all appointments',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12,
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
              onTap: () async {
                if (await getInternetUsingInternetConnectivity()) {
                  // Navigator.push(
                  //   context,
                  //   new MaterialPageRoute(
                  //     builder: (context) => sendfeedback(),
                  //   ),
                  // );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            fontSize: 10)),
                    backgroundColor: Color(0xFFE02020),
                    behavior: SnackBarBehavior.fixed,
                    duration: const Duration(seconds: 5),
                    // duration: Duration(seconds: 3),
                  ));
                }
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
                                      'assets/images/review.png',
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
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text('Send Feedback',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kLifeBloodBlue)),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Tell us where we can improve',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12,
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
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, userName) {
    showDialog(
        context: context,
        builder: (BuildContext context) => DialogContent(
              username: userName,
              userId: widget.userId.toString(),
              accountName: name.toString(),
            ));
  }

  void _showTriviaRulesDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => TriviaDialogContent());
  }

  void _showRequestsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => RequestDialogContent());
  }
}

class DialogContent extends StatefulWidget {
  DialogContent(
      {super.key,
      required this.username,
      required this.userId,
      required this.accountName});
  String username;
  String userId;
  String accountName;

  @override
  State<DialogContent> createState() => _DialogContentState(username: username);
}

class _DialogContentState extends State<DialogContent> {
  _DialogContentState({required this.username});
  String donationquery = '';

  String username;
  Timer? debouncer;
  TextEditingController? _usernameCtrl;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController(text: username);
  }

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
  String? selectedrc = '';
  String? selectedrcsolved = '';
  String? selectedscsolved = '';
  String? selectedsc = '';
  String? selectedtrivianame = '';
  String? selectedSampleBrought = '';
  String? _selectedrcRadioGroupValue;
  final _formKey = GlobalKey<FormState>();
  bool _scheduling = false;
  String? error;
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

  @override
  void dispose() {
    _usernameCtrl!.dispose();
    super.dispose();
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

  bool _isLoading = false;
  Future updatUser() async {
    setState(() {
      _isLoading = true;
    });
    String name = '';

    if (selectedtrivianame == 'Account Name') {
      setState(() {
        name = widget.accountName;
      });
    } else {
      setState(() {
        name = _usernameCtrl!.text;
      });
    }
    var data = {
      'trivia': "Yes",
      "username": name,
    };
    try {
      var response = await http.post(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/updateUser/${widget.userId}"),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        // var msg = jsonDecode(response.body);
        Users data = Users.fromJson(msg);

        setState(() {
          _isLoading = false;
          savePref(data);
        });
        // Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(pageIndex: 0),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Trivia Joined Successfully"),
            // content: Text("Trivia Joined Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        // savePref(data);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not join trivia. Please try again. "),
            // content: Text("Trivia Joined Successfully"),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(pageIndex: 0),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Something went wrong. Please try again ${e.toString()}"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
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
                      'Join LifeBlood Trivia',
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
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                // Use Expanded to allow the SingleChildScrollView to take remaining space
                child: SingleChildScrollView(
                  // Wrap your content with SingleChildScrollView
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.teal[50],
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('LifeBlood Trivia',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "The LifeBlood Trivia Quiz is an engaging and educational initiative open to all registered users of the LifeBlood Community Mobile App. Participants can test their knowledge of blood-related topics through a weekly quiz featuring 10 multiple-choice questions. The quiz will be held every Friday between 8:00 am - 10:00 pm, encouraging users to explore and learn. Scoring is straightforward, with correct answers earning one point each, and rankings are displayed in real time. The monthly winners, based on cumulative points, receive Gold, Silver, and Bronze distinctions, with special recognition for the highest scorer.",
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.teal)))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          child: Column(
                            children: [
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0),
                                  labelText: 'Trivia Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 0, left: 0),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                items: trivianameItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select name to Use.';
                                  }
                                },
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedtrivianame = value;
                                  });
                                },
                                onSaved: (value) {
                                  selectedtrivianame = value.toString();
                                },
                              ),
                              selectedtrivianame == "Username"
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Username';
                                            }
                                            return null;
                                          },
                                          // initialValue: username,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(),
                                            labelText: 'User Name',
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontFamily: 'Montserrat'),
                                          ),
                                          controller: _usernameCtrl,
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              FormBuilderCheckbox(
                                name: 'accept_terms',
                                initialValue: false,
                                onChanged: _onChanged,
                                title: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'I have read and agree to the ',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'Trivia Rules',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xFFe0e9e4),
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
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
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Terms of Reference',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .teal)),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Text(
                                                              'Last updated: 2022-06-14 1. \n\nIntroduction Welcome to AutoHealth (“Company”, “we”, “our”, “us”)! \n\nThese Terms of Service (“Terms”, “Terms of Service”) govern your use of our application LifeBlood (together or individually “Service”) operated by AutoHealth. \n\nOur Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages. \n\nYour agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them. \n\nIf you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at support@lifebloodsl.com so we can try to find a solution. \n\nThese Terms apply to all visitors, users and others who wish to access or use Service. \n\n2. Communications\n\n By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at support@lifebloodsl.com.\n\n 3. Contests\n\n Sweepstakes and Promotions Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. \n\nIf the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply. \n\n4. Content\n\nContent found on or through this Service are the property of AutoHealth or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us. \n\n5. Prohibited\n\n Uses You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service: \n\n0.1. In any way that violates any applicable national or international law or regulation. \n0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise. \n0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation. \n0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity. \n0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity. \n0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability. \nAdditionally, you agree not to: \n\n0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service. \n\n0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service. \n\n0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent. \n\n0.4. Use any device, software, or routine that interferes with the proper working of Service. \n\n0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful. \n\n0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service. \n\n0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack. \n\n0.8. Take any action that may damage or falsify Company rating. \n\n0.9. Otherwise attempt to interfere with the proper working of Service. \n\n6. Analytics \nWe may use third-party Service Providers to monitor and analyze the use of our Service. \n\n7. No Use \nBy Minors Service is intended only for access and use by individuals at least eighteen (18) years old. \n\nBy accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service. \n\n8.\n\nAccounts When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service. You are responsible for maintaining the confidentiality of your account and password, including but not limited to the restriction of access to your computer and/or account. \n\nYou agree to accept responsibility for any and all activities or actions that occur under your account and/or password, whether your password is with our Service or a third-party service. \n\nYou must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account. \n\nYou may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you, without appropriate authorization. \n\nYou may not use as a username any name that is offensive, vulgar or obscene. We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion. 9. Intellectual Property Service and its original content (excluding Content provided by users), features and functionality are and will remain the exclusive property of AutoHealth and its licensors. \n\nService is protected by copyright, trademark, and other laws of and foreign countries. Our trademarks may not be used in connection with any product or service without the prior written consent of AutoHealth\n\n. 10. Copyright Policy\n We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity. If you are a copyright owner, or authorized on behalf of one, and you believe that the copyrighted work has been copied in a way that constitutes copyright infringement, please submit your claim via email to support@lifebloodsl.com, with the subject line: “Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims” You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright. \n\n11. DMCA Notice and Procedure for Copyright Infringement Claims\n\n You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA) by providing our Copyright Agent with the following information in writing (see 17 U.S.C 512(c)(3) for further detail): \n\n0.1. an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright’s interest; \n0.2. a description of the copyrighted work that you claim has been infringed, including the URL (i.e., web page address) of the location where the copyrighted work exists or a copy of the copyrighted work; \n0.3. identification of the URL or other specific location on Service where the material that you claim is infringing is located; \n0.4. your address, telephone number, and email address; \n0.5. a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; \n0.6. a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf. \n\nYou can contact our Copyright Agent via email at support@lifebloodsl.com. \n\n12. \nError Reporting and Feedback You may provide us either directly at support@lifebloodsl.com or via third party sites and tools with information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: \n\n(i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; \n(ii) Company may have development ideas similar to the Feedback; \n(iii) Feedback does not contain confidential information or proprietary information from you or any third party; and \n(iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose. \n\n13. Links To Other Web Sites \n\nOur Service may contain links to third party web sites or services that are not owned or controlled by AutoHealth. \n\nAutoHealth has no control over, and assumes no responsibility for the content, privacy policies, or practices of any third party web sites or services. We do not warrant the offerings of any of these entities/individuals or their websites. For example, the outlined Terms of Use have been created using PolicyMaker.io, a free web application for generating high-quality legal documents. \n\nPolicyMaker’s Terms and Conditions generator is an easy-to-use free tool for creating an excellent standard Terms of Service template for a website, blog, e-commerce store or app. \n\nYOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT, GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES OR SERVICES. \n\nWE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.\n\n 14. Disclaimer Of Warranty \n\nTHESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE” BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS OBTAINED FROM US IS AT YOUR SOLE RISK. NEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY, RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE, ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THE SERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS. COMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR PARTICULAR PURPOSE. THE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW. 15. Limitation Of Liability EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU. \n\n16. Termination \n\nWe may terminate or suspend your account and bar access to Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of Terms. If you wish to terminate your account, you may simply discontinue using Service. All provisions of Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability. 17. Governing Law These Terms shall be governed and construed in accordance with the laws of Sierra Leone, which governing law applies to agreement without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service and supersede and replace any prior agreements we might have had between us regarding Service.\n\n 18. Changes\n\n To Service We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users. \n\n19. Amendments\n\n To Terms We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically. Your continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you. By continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service. \n\n20. Waiver And Severability \n\nNo waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision. If any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect. \n\n21. Acknowledgement\n\n BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM. \n\n22. \n\nContact Us Please send your feedback, comments, requests for technical support by email: support@lifebloodsl.com.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Color(
                                                                      0xff406986))),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: 5.h,
                                                              ),
                                                              TextButton(
                                                                  child: Text(
                                                                      'Close',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .white)),
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xffd12624),
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                            // Single tapped.
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                validator: FormBuilderValidators.equal(
                                  true,
                                  errorText:
                                      'You must accept terms and conditions to continue',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        backgroundColor: Colors.teal,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    onPressed: () async {
                                      // setState(() {
                                      //   _isLoading = true;
                                      // });
                                      updatUser();

                                      // Navigator.pop(context);
                                      if (_formKey.currentState!.validate()) {
                                        if (await getInternetUsingInternetConnectivity()) {
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'You are offline, Turn On Data or Wifi',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 11)),
                                            backgroundColor: Color(0xFFE02020),
                                            behavior: SnackBarBehavior.fixed,
                                            duration:
                                                const Duration(seconds: 5),
                                            // duration: Duration(seconds: 3),
                                          ));
                                        }
                                      }
                                    },
                                    child: _isLoading
                                        ? const SizedBox(
                                            height: 15.0,
                                            width: 15.0,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.0,
                                            ),
                                          )
                                        : const Text(
                                            'Join LifeBlood Trivia',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0),
                                          )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriviaDialogContent extends StatefulWidget {
  TriviaDialogContent({
    super.key,
  });

  @override
  State<TriviaDialogContent> createState() => _TriviaDialogContentState();
}

class _TriviaDialogContentState extends State<TriviaDialogContent> {
  Timer? debouncer;
  String donationquery = '';

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': '+23278621647'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
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

  @override
  final TextEditingController timeInput = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
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
        final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          // this.donationschedule = donationschedule;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
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
                      'LifeBlood Trivia Rules',
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
                // Use Expanded to allow the SingleChildScrollView to take remaining space
                child: SingleChildScrollView(
                  // Wrap your content with SingleChildScrollView
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.teal[50],
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Intro',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "The LifeBlood Trivia Quiz is an engaging and fun-filled experience designed to boost your understanding of blood-related topics. It is not just a competition but an opportunity to enhance your knowledge of blood information. Embark on a thrilling journey of knowledge with the LifeBlood Trivia Quiz. Whether you're a seasoned participant or a trivia enthusiast, this quiz is tailored for everyone!",
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.teal))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Rules',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Eligibility',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• The LifeBlood Trivia Quiz is open to all registered users of the LifeBlood Community Mobile App.\n• A user can only attempt the quiz once.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Participation',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• Users can participate in the weekly trivia quiz by logging into the LifeBlood Community Mobile App.\n• The Trivia will be published and held every Friday.\n• Users can access and participate in the quiz between 8:00 am - 10:00 pm.\n• Each user has 3 minutes to answer 10 multiple-choice questions.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Scoring',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• All questions carry equal marks.\n• Each correct answer will account for one (1) point.\n• Every incorrect answer is recorded as a zero (0) point.\n• The system will only record the points of the attempted question(s).\n• The sum of points gained from each question will determine the final score.\n• No points are deducted for incorrect answers.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Weekly Ranking',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• Users will be ranked based on their weekly points.\n• Rankings will be displaced in real-time via the Community Mobile App.\n• The final score ranking will be published at the end of the quiz.\n• The user (s) with the highest points will be the Star Person(s) of the week.\n• A Star Person will have a star badge displayed at the top of their dashboard via the Community Mobile App, throughout the week.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Monthly Ranking',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• Monthly rankings are based on the cumulative points earned throughout the month.\n• The month's top three (3) participants will be ranked as Gold, Silver, and Bronze winners, respectively.\n• The user with the highest points at the end of the month will be declared the monthly winner.\n• In the case of a score tie (equal points gained), participants will be ranked based on how quickly they complete the quiz.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Prize',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• The monthly winner will receive a special package from LifeBlood as a token of appreciation.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Results',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• Weekly and monthly rankings will be displayed via the LifeBlood Community mobile app.\n• LifeBlood reserves the right to make the final decision on rankings and prizes.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Notification',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "• The LifeBlood Community App and other media handles will notify users of upcoming quizzes and results.",
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': '+23278621647'};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
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

  @override
  final TextEditingController timeInput = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
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
        final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          // this.donationschedule = donationschedule;
        });
      });

  Future<List<BloodTestingFacilities>> getBloodFacilities(
      String donationquery) async {
    final url = Uri.parse(
        'http://api.famcaresl.com/communityapp/index.php?route=facilities');
    final response = await http.post(
      url,
      body: jsonEncode({
        "country": 'Sierra Leone'

        // Additional data
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodTestingFacilities.fromJson(json))
          .where((donationschedule) {
        final regionLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.name!.toLowerCase();
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
                                                                // border: Border.all(
                                                                //     color:
                                                                //         kLifeBloodBlue),
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
                                                                      Text(
                                                                          'Blood Donor Request',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 10,
                                                                              letterSpacing: 0,
                                                                              color: kGreyColor)),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
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
                                                                                  text: data.name!,
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
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF205072)),
                                                                            child:
                                                                                Text(
                                                                              data.status!,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'Montserrat',
                                                                                letterSpacing: 0,
                                                                                color: kWhiteColor,
                                                                              ),
                                                                              overflow: TextOverflow.clip,
                                                                            ),
                                                                          ),
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
                                                                            () {},
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
