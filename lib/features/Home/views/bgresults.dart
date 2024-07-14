import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/models/bloodtestschedule.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants/colors.dart';
import '../../../models/bhloodtestschedule_model.dart';

class BloodGroupTestScreen extends StatelessWidget {
  const BloodGroupTestScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const BloodGroupResults(),
    );
  }
}

class BloodGroupResults extends StatefulWidget {
  const BloodGroupResults({Key? key}) : super(key: key);

  @override
  State<BloodGroupResults> createState() => _BloodGroupResultsState();
}

class _BloodGroupResultsState extends State<BloodGroupResults> {
  String? address;
  String? agecategory;
  String? bloodtype;
  String? district;
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  String query = '';
  List<BloodTestSchAppdata> schedule = [];
  String? ufname;
  String? ulname;
  String? name;
  String? totalbgresult;
  String? avartar;
  String? userId;

  @override
  void initState() {
    super.initState();
    getPref();
    Future.delayed(Duration(seconds: 0), () {
      return loadResults().then((value) {
        setState(() {
          bloodGroupResults = value;
        });
      });
    });
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      phonenumber = prefs.getString('phonenumber');
      name = prefs.getString('name');
      userId = prefs.getString('id');
      avartar = prefs.getString('avatar');
      totalbgresult = prefs.getString('totalbgresult');
    });
  }

  // Future<List<TestSchedule>> getBloodTestResults(String query) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   try {
  //     var response = await http.get(
  //       Uri.parse(
  //           "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloostestschedule/28"),
  //     );
  //     if (response.statusCode == 200) {
  //       final results = json.decode(response.body);
  //       List<TestSchedule> result = results['schedule']
  //           .where((json) =>
  //               json['result'] ==
  //               'Null') // filter the JSON objects where 'result' is 'yes'
  //           .map((json) => TestSchedule.fromJson(
  //               json)) // map the filtered JSON objects to TestSchedule objects
  //           .toList();
  //       // List<String> requests =
  //       //     result.map((e) => jsonEncode(e.toJson())).toList();
  //       // // await prefs.setStringList('bloodGrpResult', requests);

  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     SnackBar(content: Text(results['schedule'].toString())));

  //       return result;

  //       // return result
  //       //     .map((json) => TestSchedule.fromJson(json))
  //       //     .where((results) {
  //       //   final facilityLower = results.facility!.toLowerCase();
  //       //   final refcodeLower = results.refcode!.toLowerCase();
  //       //   final dateLower = results.date!.toLowerCase();
  //       //   final statusLower = results.status!.toLowerCase();
  //       //   final middlenameLower = results.name!.toLowerCase();
  //       //   final phonenumberLower = results.phone!.toLowerCase();
  //       //   final searchLower = query.toLowerCase();

  //       //   return facilityLower.contains(searchLower) ||
  //       //       dateLower.contains(searchLower) ||
  //       //       statusLower.contains(searchLower) ||
  //       //       middlenameLower.contains(searchLower) ||
  //       //       phonenumberLower.contains(searchLower) ||
  //       //       refcodeLower.contains(searchLower);
  //       // }).toList();
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //     return [];
  //   }
  // }

  Future<List<TestSchedule>> getBloodTestResults(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloostestschedule/$userId"),
      );
      if (response.statusCode == 200) {
        final results = json.decode(response.body);
        List<TestSchedule> result = results['schedule']
            .where((json) => json['result'] == 'Yes')
            .map<TestSchedule>((json) => TestSchedule.fromJson(json))
            .toList();
        List<String> requests =
            result.map((e) => jsonEncode(e.toJson())).toList();
        await prefs.setStringList('bloodGroupResult', requests);

        return result;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle the exception and show a SnackBar or other UI element to indicate error

      return [];
    }
  }

  List<TestSchedule> bloodGroupResults = [];

  Future<List<TestSchedule>> loadResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonString = prefs.getStringList('bloodGroupResult');
    if (jsonString != null) {
      // List<dynamic> jsonResponse = jsonDecode(jsonString);
      List<TestSchedule> requests =
          jsonString.map((e) => TestSchedule.fromJson(json.decode(e))).toList();
      return requests;
    }
    return [];
  }

  Timer? debouncer;

  List<TestSchedule> results = [];

  final _formKey = GlobalKey<FormState>();
  String? selectedRating = '';
  String? refcode = '';

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  Future psendrating() async {
    if (selectedRating!.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/bloodtestrating.php"),
          body: {
            "rating": selectedRating,
            "refcode": refcode,
          });
      var data = json.decode(response.body);
      if (data == "Error") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                Text(
                  'Rating Successful Sent',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 5),
        ));
        // scheduleAlarm();
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BloodGroupTestScreen(),
            ),
          );
        });
      }
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

  Widget buildbloodtestallSearch() => SearchWidget(
        text: query,
        hintText: 'Search for a schedule..',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final results = await getBloodTestResults(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.results = results;
        });
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFFe0e9e4),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.teal,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => scheduletypebody(),
                  ),
                );
                // Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: kWhiteColor,
              ),
            ),
            title: Text(
              'Blood Group Test Result, ${bloodGroupResults.length} ',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(children: <Widget>[
            buildbloodtestallSearch(),
            bloodGroupResults.isNotEmpty
                ? Expanded(
                    child: ListView(
                      children: bloodGroupResults
                          .map((data) => Column(
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        .0, 5.0, 5.0, 5.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            15.r),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.teal),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundImage:
                                                                              AssetImage(avartar.toString()),
                                                                          radius:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2.h,
                                                                        ),
                                                                        Text(
                                                                            data.gender
                                                                                .toString(),
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFF205072))),
                                                                        SizedBox(
                                                                          height:
                                                                              3.h,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              data.bloodtestfor.toString(),
                                                                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 12.sp, color: Colors.green),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: Colors.teal,
                                                                                backgroundColor: const Color(0xFFe0e9e4),
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              ),
                                                                              onPressed: () {},
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(data.date.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                            data.facility
                                                                                .toString(),
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize: 13.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFF205072))),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Text(
                                                                            data.name
                                                                                .toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.montserrat(
                                                                              fontSize: 13.sp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFF205072),
                                                                            ))
                                                                        // : (Text(data.name.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072)))),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            SizedBox(
                                                              child: Container(
                                                                color: Color(
                                                                    0xFFe0e9e4),
                                                                height: 0.5.h,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15.w),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF205072),
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'ABO: ',
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d),
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: data.bgroup,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFF205072),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF205072),
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'Rh: ',
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xff389e9d),
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: data.rh,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFF205072),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF205072),
                                                                            fontSize:
                                                                                11.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'Blood Group: ',
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: const Color(0xff389e9d),
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: data.bgrouprh,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: const Color(0xFF205072),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            SizedBox(
                                                              child: Container(
                                                                color: const Color(
                                                                    0xFFe0e9e4),
                                                                height: 0.5.h,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                (data.review ==
                                                                        "Yes")
                                                                    ? SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            TextButton(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                Colors.red,
                                                                            backgroundColor:
                                                                                Colors.grey[100],
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 5.w),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text('Your Experience: ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                                (data.rating == "Highly Dissatisfied")
                                                                                    ? Row(
                                                                                        children: [
                                                                                          Image.asset(
                                                                                            'assets/icons/hdis.png',
                                                                                            height: 20.h,
                                                                                            width: 20.w,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 3.w,
                                                                                          ),
                                                                                          Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                        ],
                                                                                      )
                                                                                    : (data.rating == "Dissatisfied")
                                                                                        ? Row(
                                                                                            children: [
                                                                                              Image.asset(
                                                                                                'assets/icons/dis.png',
                                                                                                height: 20.h,
                                                                                                width: 20.w,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 3.w,
                                                                                              ),
                                                                                              Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                            ],
                                                                                          )
                                                                                        : (data.rating == "Neutral")
                                                                                            ? Row(
                                                                                                children: [
                                                                                                  Image.asset(
                                                                                                    'assets/icons/neutral.png',
                                                                                                    height: 20.h,
                                                                                                    width: 20.w,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 3.w,
                                                                                                  ),
                                                                                                  Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber)),
                                                                                                ],
                                                                                              )
                                                                                            : (data.rating == "Satisified")
                                                                                                ? Row(
                                                                                                    children: [
                                                                                                      Image.asset(
                                                                                                        'assets/icons/sat.png',
                                                                                                        height: 20.h,
                                                                                                        width: 20.w,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: 3.w,
                                                                                                      ),
                                                                                                      Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green[300])),
                                                                                                    ],
                                                                                                  )
                                                                                                : Row(
                                                                                                    children: [
                                                                                                      Image.asset(
                                                                                                        'assets/icons/hsat.png',
                                                                                                        height: 20.h,
                                                                                                        width: 20.w,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: 3.w,
                                                                                                      ),
                                                                                                      Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                                                                                                    ],
                                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            TextButton(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                Colors.white,
                                                                            backgroundColor:
                                                                                Colors.teal,
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            showModalBottomSheet(
                                                                                isScrollControlled: true,
                                                                                backgroundColor: const Color(0xFFebf5f5),
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return SingleChildScrollView(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                          SizedBox(
                                                                                            height: 3.h,
                                                                                          ),
                                                                                          Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Text('Let us know how we can improve.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: double.infinity,
                                                                                            child: SizedBox(
                                                                                              height: 5.h,
                                                                                              child: const Divider(
                                                                                                color: Colors.teal,
                                                                                                thickness: 1,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5.h,
                                                                                          ),
                                                                                          Form(
                                                                                            key: _formKey,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                FormBuilderRadioGroup(
                                                                                                  decoration: InputDecoration(border: InputBorder.none, labelText: 'Rate Your Experience', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                                                                                                  name: '$selectedRating',
                                                                                                  onChanged: (String? value) {
                                                                                                    setState(() {
                                                                                                      selectedRating = value;
                                                                                                      refcode = data.refcode;
                                                                                                    });
                                                                                                  },
                                                                                                  initialValue: selectedRating,
                                                                                                  orientation: OptionsOrientation.vertical,
                                                                                                  validator: FormBuilderValidators.required(
                                                                                                    errorText: 'Kindly Select an option',
                                                                                                  ),
                                                                                                  options: [
                                                                                                    'Highly Dissatisfied',
                                                                                                    'Dissatisfied',
                                                                                                    'Neutral',
                                                                                                    'Satisified',
                                                                                                    'Highly Satisfied'
                                                                                                  ].map((selectedRating) => FormBuilderFieldOption(value: selectedRating)).toList(growable: false),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: double.infinity,
                                                                                                  child: ElevatedButton(
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      if (_formKey.currentState!.validate()) {
                                                                                                        if (await getInternetUsingInternetConnectivity()) {
                                                                                                          // Future.delayed(Duration(seconds: 5));
                                                                                                          Navigator.pop(context);

                                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                                            SnackBar(
                                                                                                              backgroundColor: Colors.teal,
                                                                                                              content: SingleChildScrollView(
                                                                                                                child: Container(
                                                                                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                  child: Padding(
                                                                                                                    padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                                      const SizedBox(
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
                                                                                                                      Text('Sending rating: $selectedRating',
                                                                                                                          textAlign: TextAlign.center,
                                                                                                                          style: GoogleFonts.montserrat(
                                                                                                                            fontSize: 14.sp,
                                                                                                                            fontWeight: FontWeight.normal,
                                                                                                                          ))
                                                                                                                    ]),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                          Future.delayed(Duration(seconds: 5), () async {
                                                                                                            // sendrating();
                                                                                                          });
                                                                                                        } else {
                                                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                            content: Text('You are offline, Turn On Data or Wifi', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                            backgroundColor: Color(0xFFE02020),
                                                                                                            behavior: SnackBarBehavior.fixed,
                                                                                                            duration: const Duration(seconds: 5),
                                                                                                            // duration: Duration(seconds: 3),
                                                                                                          ));
                                                                                                        }
                                                                                                      }
                                                                                                    },
                                                                                                    child: const Text(
                                                                                                      'Rate Experience',
                                                                                                      style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(height: 20.h),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ]),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                });
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      TextButton(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            'Share Result',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                      ],
                                                                    ),
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFF205072),
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10))),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await FlutterShare.share(
                                                                          title:
                                                                              'Blood Group Test with LifeBlood.',
                                                                          text: 'Look at my blood group results.\nABO: ' +
                                                                              data.bgroup.toString() +
                                                                              '\nRh: ' +
                                                                              data.rh.toString() +
                                                                              'Blood Group:' +
                                                                              data.bgrouprh.toString() +
                                                                              '\n\nLifeBlood.\nGive Blood. Save Lives.',
                                                                          linkUrl: 'http://lifebloodsl.com/');
                                                                    },
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
                                          height: 10.h,
                                        )
                                      ])
                                ],
                              ))
                          .toList(),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder<List<TestSchedule>>(
                        future: getBloodTestResults(query),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.teal,
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
                                    Image.asset(
                                      "assets/icons/sad.png",
                                      height: 60.h,
                                      width: 60.w,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "No Blood Group Test Result found..",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15.sp,
                                          color: Color(0xFFE02020)),
                                    ),
                                    (totalbgresult == "0")
                                        ? Text(
                                            "No Blood Group Test Result found..",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15.sp,
                                                color: Color(0xFFE02020)),
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                "No Blood Group Test Result found..\nKindly check your internet and try again.",
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15.sp,
                                                    color: Color(0xFFE02020)),
                                              ),
                                              SizedBox(height: 5.h),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              super.widget),
                                                    );
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      const Icon(
                                                        Icons.refresh,
                                                        color: Colors.teal,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text('Refresh',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .teal)),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 10.h,
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
                                            text: 'Hi, ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xFF205072),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "$name",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF205072),
                                            ),
                                          ),
                                        ],
                                      ),
                                      textHeightBehavior:
                                          const TextHeightBehavior(
                                              applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Do you want to know your blood group? \nKindly schedule a Blood Group Test.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13.sp,
                                          color: Color(0xFF205072)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.teal,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    scheduletypebody(),
                                              ),
                                            );
                                          },
                                          child: Text('Schedule Now',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      ],
                                    )
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
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom),
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
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(15.r),
                                                                        width: double
                                                                            .infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          border:
                                                                              Border.all(color: Colors.teal),
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Column(
                                                                              children: [
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        CircleAvatar(
                                                                                          backgroundImage: AssetImage(avartar.toString()),
                                                                                          radius: 30,
                                                                                        ),
                                                                                        // Image.asset(
                                                                                        //   avartar.toString(),
                                                                                        //   height: 40.h,
                                                                                        //   width: 40.w,
                                                                                        // ),
                                                                                        SizedBox(
                                                                                          height: 2.h,
                                                                                        ),
                                                                                        Text(data.gender.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                                        SizedBox(
                                                                                          height: 3.h,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              data.bloodtestfor.toString(),
                                                                                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 12.sp, color: Colors.green),
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            TextButton(
                                                                                              style: TextButton.styleFrom(
                                                                                                foregroundColor: Colors.teal,
                                                                                                backgroundColor: Color(0xFFe0e9e4),
                                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                              ),
                                                                                              onPressed: () {},
                                                                                              child: Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Text(data.date.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Text(data.facility.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                                        SizedBox(
                                                                                          height: 5.h,
                                                                                        ),
                                                                                        (data.phone == phonenumber) ? Text(data.name.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))) : (Text(data.name.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072)))),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            SizedBox(
                                                                              child: Container(
                                                                                color: Color(0xFFe0e9e4),
                                                                                height: 0.5.h,
                                                                                width: double.infinity,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                              text: 'ABO: ',
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                color: Color(0xff389e9d),
                                                                                              ),
                                                                                            ),
                                                                                            TextSpan(
                                                                                              text: data.bgroup,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Color(0xFF205072),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
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
                                                                                              text: 'Rh: ',
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                color: Color(0xff389e9d),
                                                                                              ),
                                                                                            ),
                                                                                            TextSpan(
                                                                                              text: data.rh,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Color(0xFF205072),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Text.rich(
                                                                                        TextSpan(
                                                                                          style: TextStyle(
                                                                                            color: Color(0xFF205072),
                                                                                            fontSize: 11.sp,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: 'Blood Group: ',
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                color: Color(0xff389e9d),
                                                                                              ),
                                                                                            ),
                                                                                            TextSpan(
                                                                                              text: data.bgrouprh,
                                                                                              style: GoogleFonts.montserrat(
                                                                                                fontSize: 11.sp,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Color(0xFF205072),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            SizedBox(
                                                                              child: Container(
                                                                                color: Color(0xFFe0e9e4),
                                                                                height: 0.5.h,
                                                                                width: double.infinity,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                (data.review == "Yes")
                                                                                    ? SizedBox(
                                                                                        width: double.infinity,
                                                                                        child: TextButton(
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.red,
                                                                                            backgroundColor: Colors.grey[100],
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                          ),
                                                                                          onPressed: () {},
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                                                            child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Text('Your Experience: ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                                                (data.rating == "Highly Dissatisfied")
                                                                                                    ? Row(
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/icons/hdis.png',
                                                                                                            height: 20.h,
                                                                                                            width: 20.w,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: 3.w,
                                                                                                          ),
                                                                                                          Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                                        ],
                                                                                                      )
                                                                                                    : (data.rating == "Dissatisfied")
                                                                                                        ? Row(
                                                                                                            children: [
                                                                                                              Image.asset(
                                                                                                                'assets/icons/dis.png',
                                                                                                                height: 20.h,
                                                                                                                width: 20.w,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                width: 3.w,
                                                                                                              ),
                                                                                                              Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                                            ],
                                                                                                          )
                                                                                                        : (data.rating == "Neutral")
                                                                                                            ? Row(
                                                                                                                children: [
                                                                                                                  Image.asset(
                                                                                                                    'assets/icons/neutral.png',
                                                                                                                    height: 20.h,
                                                                                                                    width: 20.w,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    width: 3.w,
                                                                                                                  ),
                                                                                                                  Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber)),
                                                                                                                ],
                                                                                                              )
                                                                                                            : (data.rating == "Satisified")
                                                                                                                ? Row(
                                                                                                                    children: [
                                                                                                                      Image.asset(
                                                                                                                        'assets/icons/sat.png',
                                                                                                                        height: 20.h,
                                                                                                                        width: 20.w,
                                                                                                                      ),
                                                                                                                      SizedBox(
                                                                                                                        width: 3.w,
                                                                                                                      ),
                                                                                                                      Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green[300])),
                                                                                                                    ],
                                                                                                                  )
                                                                                                                : Row(
                                                                                                                    children: [
                                                                                                                      Image.asset(
                                                                                                                        'assets/icons/hsat.png',
                                                                                                                        height: 20.h,
                                                                                                                        width: 20.w,
                                                                                                                      ),
                                                                                                                      SizedBox(
                                                                                                                        width: 3.w,
                                                                                                                      ),
                                                                                                                      Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                                                                                                                    ],
                                                                                                                  ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : SizedBox(
                                                                                        width: double.infinity,
                                                                                        child: TextButton(
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.white,
                                                                                            backgroundColor: Colors.teal,
                                                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            showModalBottomSheet(
                                                                                                isScrollControlled: true,
                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                context: context,
                                                                                                builder: (context) {
                                                                                                  return SingleChildScrollView(
                                                                                                    child: Container(
                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                                          SizedBox(
                                                                                                            height: 3.h,
                                                                                                          ),
                                                                                                          Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                                                                                          SizedBox(
                                                                                                            height: 5.h,
                                                                                                          ),
                                                                                                          Text('Let us know how we can improve.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 5.h,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            width: double.infinity,
                                                                                                            child: SizedBox(
                                                                                                              child: Divider(
                                                                                                                color: Colors.teal,
                                                                                                                thickness: 1,
                                                                                                              ),
                                                                                                              height: 5.h,
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 5.h,
                                                                                                          ),
                                                                                                          Form(
                                                                                                            key: _formKey,
                                                                                                            child: Column(
                                                                                                              children: [
                                                                                                                FormBuilderRadioGroup(
                                                                                                                  decoration: InputDecoration(border: InputBorder.none, labelText: 'Rate Your Experience', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                                                                                                                  name: '$selectedRating',
                                                                                                                  onChanged: (String? value) {
                                                                                                                    setState(() {
                                                                                                                      selectedRating = value;
                                                                                                                      refcode = data.refcode;
                                                                                                                    });
                                                                                                                  },
                                                                                                                  initialValue: selectedRating,
                                                                                                                  orientation: OptionsOrientation.vertical,
                                                                                                                  validator: FormBuilderValidators.required(
                                                                                                                    errorText: 'Kindly Select an option',
                                                                                                                  ),
                                                                                                                  options: [
                                                                                                                    'Highly Dissatisfied',
                                                                                                                    'Dissatisfied',
                                                                                                                    'Neutral',
                                                                                                                    'Satisified',
                                                                                                                    'Highly Satisfied'
                                                                                                                  ].map((selectedRating) => FormBuilderFieldOption(value: selectedRating)).toList(growable: false),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: double.infinity,
                                                                                                                  child: ElevatedButton(
                                                                                                                    style: ButtonStyle(
                                                                                                                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                                                                                                                    ),
                                                                                                                    onPressed: () async {
                                                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                        SnackBar(
                                                                                                                            backgroundColor: Colors.teal,
                                                                                                                            content: SingleChildScrollView(
                                                                                                                                child: Container(
                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                              child: Padding(
                                                                                                                                padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                                                  const SizedBox(
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
                                                                                                                                  Text('Sending rating: $selectedRating',
                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                      style: GoogleFonts.montserrat(
                                                                                                                                        fontSize: 14.sp,
                                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                                      ))
                                                                                                                                ]),
                                                                                                                              ),
                                                                                                                            ))),
                                                                                                                      );
                                                                                                                      if (_formKey.currentState!.validate()) {
                                                                                                                        if (await getInternetUsingInternetConnectivity()) {
                                                                                                                          Navigator.pop(context);

                                                                                                                          Future.delayed(Duration(seconds: 5), () async {
                                                                                                                            // sendrating();
                                                                                                                          });
                                                                                                                        } else {
                                                                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                            content: Text('You are offline, Turn On Data or Wifi', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                                            backgroundColor: Color(0xFFE02020),
                                                                                                                            behavior: SnackBarBehavior.fixed,
                                                                                                                            duration: const Duration(seconds: 5),
                                                                                                                            // duration: Duration(seconds: 3),
                                                                                                                          ));
                                                                                                                        }
                                                                                                                      }
                                                                                                                    },
                                                                                                                    child: const Text(
                                                                                                                      'Rate Experience',
                                                                                                                      style: TextStyle(fontFamily: 'Montserrat'),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: 20.h),
                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        ]),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                });
                                                                                          },
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                SizedBox(
                                                                                  width: double.infinity,
                                                                                  child: TextButton(
                                                                                    style: TextButton.styleFrom(
                                                                                      foregroundColor: Colors.white,
                                                                                      backgroundColor: Color(0xFF205072),
                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      await FlutterShare.share(title: 'Blood Group Test with LifeBlood.', text: 'Look at my blood group results.\nABO: ' + data.bgroup.toString() + '\nRh: ' + data.rh.toString() + 'Blood Group:' + data.bgrouprh.toString() + '\n\nLifeBlood.\nGive Blood. Save Lives.', linkUrl: 'http://lifebloodsl.com/');
                                                                                    },
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text('Share Result', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                      ],
                                                                                    ),
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
                                                          height: 10.h,
                                                        )
                                                      ])
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ]);
                          }
                        }),
                  ),
          ]),
        ));
  }
}
