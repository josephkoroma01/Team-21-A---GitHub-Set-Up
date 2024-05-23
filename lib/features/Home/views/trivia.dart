import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebloodworld/features/Home/models/donorregistered.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:lifebloodworld/features/Home/views/bgresults.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbody.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbodyfam.dart';
import 'package:lifebloodworld/features/Home/views/famregister.dart';
import 'package:lifebloodworld/features/Home/views/managedonationpp.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/widgets/text_field_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import '../../../constants/colors.dart';
import '../../../models/bloodtestschedule.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'search.dart';

class facilitydata {
  String rbtc;
  String rbtcid;
  String name;
  String communityname;
  String district;

  facilitydata(
      {required this.rbtc,
      required this.rbtcid,
      required this.name,
      required this.communityname,
      required this.district});

  factory facilitydata.fromJson(Map<String, dynamic> json) {
    return facilitydata(
        rbtc: json['rbtc'],
        rbtcid: json['rbtcid'].toString(),
        name: json['name'],
        communityname: json['communityname'],
        district: json['district']);
  }

  Map<String, dynamic> toJson() => {
        'rbtc': rbtc,
        'rbtcid': rbtcid,
        'name': name,
        'communityname': communityname
      };
}

class trivia extends StatefulWidget {
  @override
  State createState() {
    return triviaState();
  }
}

class triviaState extends State<trivia> {
  String? address;
  String? agecategory;
  String? bloodtestfor;
  String? bloodtype;
  Timer? debouncer;
  String? district;
  String donationquery = '';
  List<BloodDonationSchAppdata> donationschedule = [];
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  String query = "";
  bool ratingappbar = false;
  TextEditingController refcode = TextEditingController();
  String? schufname;
  String? schulname;
  String? schumname;
  String? selectedRating = '';
  String? status;
  String? totalbgresult;
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

  final _formKey = GlobalKey<FormState>();
  late Timer _getBgresulttimer;
  late Timer _getTotalDonationstimer;
  bool _validate = false;
  List facilityList = [];

  final List<String> costlist = ['Free', 'Paid'];

  String? selectedFacility = '';
  String? selectedCost = '';

  Future findfacility() async {
    var response = await http
        .get(Uri.parse("https://community.lifebloodsl.com/findfacility.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        facilityList = jsonData;
      });
    }
    print(facilityList);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      phonenumber = prefs.getString('phonenumber');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      totaldonationrep = prefs.getString('totaldonationrep');
      totaldonationvol = prefs.getString('totaldonationvol');
      totaldonationvold = prefs.getString('totaldonationvold');
      totaldonationvolp = prefs.getString('totaldonationvolp');
      totaldonationvolcon = prefs.getString('totaldonationvolcon');
      totaldonationvolr = prefs.getString('totaldonationvolr');
      totaldonationvolcan = prefs.getString('totaldonationvolcan');
    });
  }

  @override
  void initState() {
    super.initState();
    getRefPref();
    getBgresult();
    _donorRegisteredFuture = findDonor("");
    _getBgresulttimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
  }

  Future<List<DonorRegisterData>> findDonor(String query) async {
    var data = {'rbtc_id': '1', 'tfs_id': '2', 'status': 'Pending'};

    var response = await http.post(
      Uri.parse(
          "https://labtech.lifebloodsl.com/labtechapi/findregisterdonor.php"),
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final List<dynamic> donorRegisterJson = json.decode(response.body);

      return donorRegisterJson
          .map((json) => DonorRegisterData.fromJson(json))
          .where((donor) {
        final donorNameLower = donor.name.toLowerCase();
        final donorPhoneNumberLower = donor.phonenumber.toLowerCase();
        final donorAgeCategoryLower = donor.agecategory.toLowerCase();
        final donorAddressLower = donor.address.toLowerCase();
        final donorEmailAddressLower = donor.email.toLowerCase();
        final donorBloodTypeLower = donor.bloodtype.toLowerCase();
        final donorGenderLower = donor.gender.toLowerCase();
        final searchLower = query.toLowerCase();

        return donorNameLower.contains(searchLower) ||
            donorAgeCategoryLower.contains(searchLower) ||
            donorAddressLower.contains(searchLower) ||
            donorEmailAddressLower.contains(searchLower) ||
            donorGenderLower.contains(searchLower) ||
            donorPhoneNumberLower.contains(searchLower) ||
            donorBloodTypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Failed to load donors');
    }
  }

  late Future<List<DonorRegisterData>> _donorRegisteredFuture;

  void getRefPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      phonenumber = prefs.getString('phonenumber');
      totalbgresult = prefs.getString('totalbgresult');
      totalsch = prefs.getString('totalsch');
      totalschmyself = prefs.getString('totalschmyself');
      totalschfriend = prefs.getString('totalschfriend');
      totalschfamily = prefs.getString('totalschfamily');
    });
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

  savetbgrPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalbgresult', totalbgresult!);
  }

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email!);
    prefs.setString('phonenumber', phonenumber!);
    prefs.setString('status', status!);
    prefs.setString('schufname', schufname!);
    prefs.setString('schumname', schumname!);
    prefs.setString('schulname', schulname!);
  }

  Future<List<BloodTestSchAppdata>> getBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/manageappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getBloodTestResultApp(String query) async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/manageappointmentsresults.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getMyBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Myself'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managemybgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getFamilyBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Family'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managebgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  Future<List<BloodTestSchAppdata>> getFriendBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Friend'};

    var response = await http.post(
        Uri.parse("http://localhost/sbims/community/managebgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

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
        final regionLower = donationschedule.region.toLowerCase();
        final facilitynameLower = donationschedule.facilityname.toLowerCase();
        final servicetypeLower = donationschedule.facilityname.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future sendrating() async {
    if (selectedRating!.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "https://community.lifebloodsl.com/blooddonationrating.php"),
          body: {
            "phonenumber": phonenumber,
            "rating": selectedRating,
            "refcode": refcode,
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
          content: Container(
            height: 20.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Rating Successfully Sent',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
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
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            ratingappbar = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => managedonationAppointments(),
            ),
          );
        });
      }
    }
  }

  final List<String> facilityItems = [
    'Western Area Rural',
    'Bo',
    'Connaught',
    'Rokupa',
  ];

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search Facility Name',
        onChanged: searchBook,
      );

  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodFacilities(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          this.donationschedule =
              donationschedule.cast<BloodDonationSchAppdata>();
        });
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => HomePageScreen(pageIndex: 0),
              ),
            );
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: kWhiteColor,
          ),
        ),
        elevation: 0,
        title: Text('LifeBlood Trivia',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 15, color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xFFF6F6F6),
          child: Expanded(
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
                  Form(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: kWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
