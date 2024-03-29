import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class settings extends StatefulWidget {
  @override
  State createState() {
    return settingsState();
  }
}

class settingsState extends State<settings> {
  String? address;
  String? age;
  String? bloodtype;
  String? district;
  String? email;
  String? gender;
  String? password;
  String? phonenumber;
  String? prevdonation;
  String? prevdonationamt;
  String? ufname;
  String? ulname;
  String? umname;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Join Me and Save Lives',
        text:
            'Join LifeBlood and Start Saving Lives\n\nLifeBlood is a safe blood management system, made available to Government and private blood bank facilities as a Digital Public Good, to help improve their Blood bank data management and workflow processes. The public is also provided with a community mobile app for free to build a strong blood donor community to expedite regular voluntary blood donations and emergency donations. For more information kindly visit their website http://lifebloodsl.com/ or contact them at: +23279230776.\n\nLifeBlood.\nGive Blood. Save Lives',
        linkUrl: 'http://lifebloodsl.com/');
  }

launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+23279230776',
      text: "Hey, Community Support Team.",
    );
    // ignore: deprecated_member_use
    await launch('$link');
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      password = prefs.getString('password');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      age = prefs.getString('age');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      prevdonationamt = prefs.getString('prevdonationamt');
    });
  }

  _launchURL() async {
    const url =
        'https://www.canva.com/design/DAFV9y1ElPA/0MzFSefvS9NSnlG4r67SwA/view';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                  builder: (context) => HomePageScreen(pageIndex: 3),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text(
          "More Information",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.sp),
        ),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
         
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Row(children: [
                          Icon(
                            Icons.group_add_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text('Tell a Friend',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.sp, color: Colors.white)),
                        ]),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          share();
                        },
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
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFebf5f5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/info.png',
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text('About \nLifeBlood',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Color(0xff406986))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        child: Text('About',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff389e9d),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Color(0xFFebf5f5),
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
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
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
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                          fontSize:
                                                                              13.sp,
                                                                          color: Colors
                                                                              .red)),
                                                            ],
                                                          ),
                                                        ),
                                                        Text('About LifeBlood',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .teal)),
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
                                                        Text(
                                                            'LifeBlood is a system that caters to promote the availability of blood in Sierra Leone Blood banks. It is three in one system;\n\n1. The Administrator (National Safe Blood Service)\n2. The Facility  (Hospitals)\n3. The Community\n \nIt contains features for Blood Group Test; Blood Donations and Frequently asked eligibility questions as most people can donate blood, but some can\u0027t for health or lifestyle reasons. \n\nThe System will be built using both USSD and Mobile technologies to cater to each and every Sierra Leonean. Sierra Leoneans with or without smartphones can easily access LifeBlood with or without the internet. \nLifeBlood uses the same form fields as other blood bank facilities in Sierra Leone hence the integration is easy. As a donor schedules his appointment all his details will be sent to the facility immediately creating a digital health experience. \n\nLifeBlood also at the facility level will digitalise the data of all facilities making the blood donation experience trackable, easy, and safe. \n\nLifeBlood at the community level gives blood education, creates a platform for blood donation, gives live blood updates, and connects people from different blood groups (Blood community). \n\nThe connection is important as certain blood groups are very delicate (O Negative only receives from O negative). \nBlood Education is key in order to inform Sierra Leoneans about the risk factors concerning their blood type (O positive man should be advised strongly against marrying an O negative woman will lead to Erythroblastosis Type AB and B blood are at greater risk of Heart  Disease; Type A, B or AB are at higher risk for stomach cancer, pancreatic cancer;  Type AB are at higher risk of memory problems)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0xff406986))),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text('Introduction',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff406986))),
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
                                                        Text(
                                                            'Our body has billions of cells that need a regular supply of fuel and oxygen to function. Blood meets these requirements by delivering essential substances like nutrients and oxygen to the cells of the body and ensuring its proper functioning, thus, also making sure that our body keeps in good health. It might interest you that an average adult human body has about five liters of blood. \n\nHaving said that, it is anybody’s guess, we can\u0027t live without blood. Without blood, we couldn\u0027t keep warm or cool off, we couldn\u0027t fight infections, and we couldn\u0027t get rid of our own waste products. \n\nWhile the need for blood is universal, access to blood for those who need it is sadly not. For too many patients around the world whose survival depends on blood transfusion, blood transfusion is either not available or not safe. \n\nEvery two seconds of every day, someone needs blood. The reasons for transfusion vary, but the demand for blood is ever-present and growing. \n\nSince blood cannot be manufactured outside the body and has a limited shelf life, the supply must constantly be replenished by generous blood donors.',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0xff406986))),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text('Problem',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff406986))),
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
                                                        Text(
                                                            'According to the most recent UN Data, Sierra Leone has one of the world’s highest maternal mortality ratios at 1360 deaths per 100,000 babies born (UN, 2015). \nBased on these figures, it is estimated that up to 6% of women in Sierra Leone will die as a result of maternal causes during their reproductive life. \n\nHemorrhage due to blood loss is the main cause of maternal deaths worldwide, accounting for 44% of maternal death in sub-Saharan Africa. \n\nAccording to the Ministry of Health, the country faces a severe shortage of blood with potentially severe implications for a country battling an epidemic of maternal and infant mortality and high rates of death due to road accidents, among other life-threatening issues. \n\n“People lose their lives because of lack of access to blood. This is especially true for women who have difficulties in childbirth and sick children, but also for people who are in road accidents and other emergencies” Prof. Sahr Gevao (Consultant Haematologist, Department of Haematology, College of Medicine and Allied Health Sciences; Laboratory Pillar Lead, NaCOVERC) \n\nThe current stock of voluntary blood donations in Sierra Leone is just able to meet 15% of the patients’ blood needs. Yet, the UN’s health agency recommends that all countries aim for 100% blood supply coming from voluntary donors as these have been shown to be the safest and most sustainable way of ensuring patients have access to blood when they need it. \n\nIt is reported that only 20% of Sierra Leoneans are willing to donate blood of their own volition. Also, there are no free blood donations in emergency cases, all donations are paid donations if a victim doesn’t meet the requirements he/she might lose his/her life.\n\nUp to 70% of accident that results in a huge amount of blood loss leads to the death of the patients before reaching the hospital or even when in the hospital die before getting a donor due to lack of readily available blood in blood banks which is scary. \n\nPregnant women and under-five children die due to anemia as enough amount of blood is not available to sustain them during this condition.',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0xff406986))),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text('Solution',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff406986))),
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
                                                        Text(
                                                            'For many patients, blood donors are their lifeline. One unit of blood can save three lives! Sadly, we don’t have that amount when we need it. It is reported that only 20% of Sierra Leoneans are willing to donate blood of their own volition. \n\nLifeBlood is a digital public good that aims at increasing blood donors across the country by capitalizing on the role of voluntary blood donors and the role collaboration with the health facilities plays in enhancing the service. \n\nThe product operates on three platforms, all in an integrated system connected to one another with a swift flow of information and educational materials to improve user-friendliness. LifeBlood can be accessed from devices with Internet connectivity, such as personal computers, tablets, and smartphones.\n\nAfter registering, users can create a profile revealing information about themselves. Users can also communicate directly with each other and receive notifications on the activities happening at the administrative and facility level.',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0xff406986))),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text(
                                                            'Benefit to Sierra Leoneans',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff406986))),
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
                                                        Text(
                                                            'A policy will be developed wherein all regular blood donors will receive free blood transfusion for any blood transfusion emergencies. \n\nLifeBlood will drastically reduce maternal deaths due to the lack of available safe blood for transfusion. \n\nIt will help save up to 70% of road traffic accident victims who will need an emergency blood transfusion. \n\nLifeBlood will also provide Blood Education to Sierra Leoneans preventing or minimizing blood-related conditions from malnutrition, relationship, lifestyle, etc. \n\nBlood Donated will go towards the free health care for pregnant women, under-five children, and the less privileged in society.',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0xff406986))),
                                                        SizedBox(
                                                          height: 10.h,
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
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFebf5f5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/research.png',
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text('Terms of \nReference',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Color(0xff406986))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        child: Text('Read',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff389e9d),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Color(0xFFe0e9e4),
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
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
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
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                          fontSize:
                                                                              13.sp,
                                                                          color: Colors
                                                                              .red)),
                                                            ],
                                                          ),
                                                        ),
                                                        Text('Terms of Reference',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .teal)),
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
                                                        Text(
                                                            'Last updated: 2022-06-14 1. \n\nIntroduction Welcome to AutoHealth (“Company”, “we”, “our”, “us”)! \n\nThese Terms of Service (“Terms”, “Terms of Service”) govern your use of our application LifeBlood (together or individually “Service”) operated by AutoHealth. \n\nOur Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages. \n\nYour agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them. \n\nIf you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at support@lifebloodsl.com so we can try to find a solution. \n\nThese Terms apply to all visitors, users and others who wish to access or use Service. \n\n2. Communications\n\n By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at support@lifebloodsl.com.\n\n 3. Contests\n\n Sweepstakes and Promotions Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. \n\nIf the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply. \n\n4. Content\n\nContent found on or through this Service are the property of AutoHealth or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us. \n\n5. Prohibited\n\n Uses You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service: \n\n0.1. In any way that violates any applicable national or international law or regulation. \n0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise. \n0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation. \n0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity. \n0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity. \n0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability. \nAdditionally, you agree not to: \n\n0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service. \n\n0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service. \n\n0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent. \n\n0.4. Use any device, software, or routine that interferes with the proper working of Service. \n\n0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful. \n\n0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service. \n\n0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack. \n\n0.8. Take any action that may damage or falsify Company rating. \n\n0.9. Otherwise attempt to interfere with the proper working of Service. \n\n6. Analytics \nWe may use third-party Service Providers to monitor and analyze the use of our Service. \n\n7. No Use \nBy Minors Service is intended only for access and use by individuals at least eighteen (18) years old. \n\nBy accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service. \n\n8.\n\nAccounts When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service. You are responsible for maintaining the confidentiality of your account and password, including but not limited to the restriction of access to your computer and/or account. \n\nYou agree to accept responsibility for any and all activities or actions that occur under your account and/or password, whether your password is with our Service or a third-party service. \n\nYou must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account. \n\nYou may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you, without appropriate authorization. \n\nYou may not use as a username any name that is offensive, vulgar or obscene. We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion. 9. Intellectual Property Service and its original content (excluding Content provided by users), features and functionality are and will remain the exclusive property of AutoHealth and its licensors. \n\nService is protected by copyright, trademark, and other laws of and foreign countries. Our trademarks may not be used in connection with any product or service without the prior written consent of AutoHealth\n\n. 10. Copyright Policy\n We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity. If you are a copyright owner, or authorized on behalf of one, and you believe that the copyrighted work has been copied in a way that constitutes copyright infringement, please submit your claim via email to support@lifebloodsl.com, with the subject line: “Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims” You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright. \n\n11. DMCA Notice and Procedure for Copyright Infringement Claims\n\n You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA) by providing our Copyright Agent with the following information in writing (see 17 U.S.C 512(c)(3) for further detail): \n\n0.1. an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright’s interest; \n0.2. a description of the copyrighted work that you claim has been infringed, including the URL (i.e., web page address) of the location where the copyrighted work exists or a copy of the copyrighted work; \n0.3. identification of the URL or other specific location on Service where the material that you claim is infringing is located; \n0.4. your address, telephone number, and email address; \n0.5. a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; \n0.6. a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf. \n\nYou can contact our Copyright Agent via email at support@lifebloodsl.com. \n\n12. \nError Reporting and Feedback You may provide us either directly at support@lifebloodsl.com or via third party sites and tools with information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: \n\n(i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; \n(ii) Company may have development ideas similar to the Feedback; \n(iii) Feedback does not contain confidential information or proprietary information from you or any third party; and \n(iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose. \n\n13. Links To Other Web Sites \n\nOur Service may contain links to third party web sites or services that are not owned or controlled by AutoHealth. \n\nAutoHealth has no control over, and assumes no responsibility for the content, privacy policies, or practices of any third party web sites or services. We do not warrant the offerings of any of these entities/individuals or their websites. For example, the outlined Terms of Use have been created using PolicyMaker.io, a free web application for generating high-quality legal documents. \n\nPolicyMaker’s Terms and Conditions generator is an easy-to-use free tool for creating an excellent standard Terms of Service template for a website, blog, e-commerce store or app. \n\nYOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT, GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES OR SERVICES. \n\nWE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.\n\n 14. Disclaimer Of Warranty \n\nTHESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE” BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS OBTAINED FROM US IS AT YOUR SOLE RISK. NEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY, RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE, ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THE SERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS. COMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR PARTICULAR PURPOSE. THE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW. 15. Limitation Of Liability EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU. \n\n16. Termination \n\nWe may terminate or suspend your account and bar access to Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of Terms. If you wish to terminate your account, you may simply discontinue using Service. All provisions of Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability. 17. Governing Law These Terms shall be governed and construed in accordance with the laws of Sierra Leone, which governing law applies to agreement without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service and supersede and replace any prior agreements we might have had between us regarding Service.\n\n 18. Changes\n\n To Service We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users. \n\n19. Amendments\n\n To Terms We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically. Your continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you. By continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service. \n\n20. Waiver And Severability \n\nNo waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision. If any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect. \n\n21. Acknowledgement\n\n BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM. \n\n22. \n\nContact Us Please send your feedback, comments, requests for technical support by email: support@lifebloodsl.com.',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
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
                                        },
                                      ),
                                    )
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
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFebf5f5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/privacy-policy.png',
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text('Privacy \nPolicy',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Color(0xff406986))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        child: Text('Read',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff389e9d),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Color(0xFFe0e9e4),
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
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
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
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                          fontSize:
                                                                              13.sp,
                                                                          color: Colors
                                                                              .red)),
                                                            ],
                                                          ),
                                                        ),
                                                        Text('Privacy Policy',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .teal)),
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
                                                        Text(
                                                            'Effective date: 2022-05-05\n\nUpdated on: 2022-06-14\n\nThis Privacy Policy explains the policies of LifeBlood on the collection and use of the information we collect when you access https://lifeblood.sl (the “Service”). \n\nThis Privacy Policy describes your privacy rights and how you are protected under privacy laws. \n\nBy using our Service, you are consenting to the collection and use of your information in accordance with this Privacy Policy. Please do not access or use our Service if you do not consent to the collection and use of your information as outlined in this Privacy Policy. This Privacy Policy has been created with the help of CookieScript Privacy Policy Generator. LifeBlood is authorized to modify this Privacy Policy at any time. This may occur without prior notice. LifeBlood will post the revised Privacy Policy on the https://lifebloodsl.com website \n\nCOLLECTION AND USE OF YOUR PERSONAL\n\n \n\nINFORMATION INFORMATION WE COLLECT\n When using our Service, you will be prompted to provide us with personal information used to contact or identify you. https://lifebloodsl.com collects the following information: \n\n* Usage Data \n* Name \n* Email \n* Mobile Number \n* Date of Birth \n* Work Address \n* Home Address Usage Data includes the following: \n* Internet Protocol (IP) address of computers accessing the site \n* Web page requests \n* Referring web pages \n* Browser used to access site \n* Time and date of access \n\nHOW WE COLLECT INFORMATION\n https://lifebloodsl.com collects and receives information from you in the following manner: \n\n* When you fill a registration form or otherwise submit your personal information. Your information will be stored for up to 365 days after it is no longer required to provide you the services. Your information may be retained for longer periods for reporting or record- keeping in accordance with applicable laws. Information which does not identify you personally may be stored indefinitely. \n\nHOW WE USE YOUR INFORMATION\n https://lifebloodsl.com may use your information for the following purposes: \n* Providing and maintaining our Service, as well as monitoring the usage of our Service. \n* For other purposes. LifeBlood will use your information for data analysis to identify usage trends or determine the effective of our marketing campaigns when reasonable. We will use your information to evaluate and improve our Service, products, services, and marketing efforts. \n* Managing your account. Your Personal Data can enable access to multiple functions of our Service that are available to registered users. \n* For the performance of a contract. Your Personal Data will assist with the development, undertaking, and compliance of a purchase contract for products or services you have purchased through our Service. \n* To contact you. LifeBlood will contact you by email, phone, SMS, or another form of electronic communication related to the functions, products, services, or security updates when necessary or reasonable. \n* To update you with news, general information, special offers, new services, and events. \n* Administration information. Your Personal Data will be used as part of the operation of our website Administration practices. \n* User to user comments. Your information, such as your screen name, personal image, or email address, will be in public view when posting user to user comments. \n\nHOW WE SHARE YOUR INFORMATION \nLifeBlood will share your information, when applicable, in the following situations: * With your consent. LifeBlood will share your information for any purpose with your explicit consent. * Sharing with other users. Information you provide may be viewed by other users of our Service. By interacting with other users or registering through a third-party service, such as a social media service, your contacts on the third-party service may see your information and a description of your activity.\n\nTHIRD-PARTY SHARING\n\nAny third party we share your information with must disclose the purpose for which they intend to use your information. They must retain your information only for the duration disclosed when requesting or receiving said information. The third-party service provider must not further collect, sell, or use your personal information except as necessary to perform the specified purpose. \n\nYour information may be shared to a third-party for reasons including: \n* Analytics information. \nYour information might be shared with online analytics tools in order to track and analyse website traffic. If you choose to provide such information during registration or otherwise, you are giving LifeBlood permission to use, share, and store that information in a manner consistent with this Privacy Policy. Your information may be disclosed for additional reasons, including: \n* Complying with applicable laws, regulations, or court orders. \n* Responding to claims that your use of our Service violates third-party rights. \n* Enforcing agreements you make with us, including this Privacy Policy. \n\nCOOKIES \nCookies are small text files that are placed on your computer by websites that you visit. Websites use cookies to help users navigate efficiently and perform certain functions. Cookies that are required for the website to operate properly are allowed to be set without your permission. All other cookies need to be approved before they can be set in the browser. \n\n* Strictly necessary cookies.\nStrictly necessary cookies allow core website functionality such as user login and account management. The website cannot be used properly without strictly necessary cookies. \n* Performance cookies. \nPerformance cookies are used to see how visitors use the website, eg. analytics cookies. Those cookies cannot be used to directly identify a certain visitor. \n\nSECURITY\nYour information’s security is important to us. https://lifebloodsl.com utilizes a range of security measures to prevent the misuse, loss, or alteration of the information you have given us. However, because we cannot guarantee the security of the information you provide us, you must access our service at your own risk. \n\nLifeBlood is not responsible for the performance of websites operated by third parties or your interactions with them. When you leave this website, we recommend you review the privacy practices of other websites you interact with and determine the adequacy of those practices. \n\nCONTACT US For any questions, please contact us through the following methods: Name: LifeBlood Address: 8 Regent Road, Hill Cut Email: LifeBlood14@gmail.com Website: https://lifebloodsl.com Phone: +23278621647',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize: 14.sp,
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
                                                                child: Text('Close',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: Colors
                                                                            .white)),
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      Colors.white,
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xffd12624),
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(
                                                                                  10))),
                                                                ),
                                                                onPressed: () {
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
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFebf5f5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/idea.png',
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text('LifeBlood \nUser Guide',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Color(0xff406986))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        child: Text('Know More',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff389e9d),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var facebookUrl =
          "https://www.canva.com/design/DAFV9y1ElPA/0MzFSefvS9NSnlG4r67SwA/view";
      try {
        launchUrl(facebookUrl as Uri);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch Canva',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                                      ),
                                    )
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
                  height: 20.h,
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
                                  padding: EdgeInsets.all(10.r),
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
                                          Text('Need Help',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 9.sp,
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
                                          Text('Contact Community Support Team',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal)),
                                          

                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white, backgroundColor: Colors.teal,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                           onPressed: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var whatsappUrl =
          "whatsapp://send?phone=${'+23278621647'}" +
              "&text=${Uri.encodeComponent('I need help')}";
      try {
        launch(whatsappUrl);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch WhatsApp',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                            
                            
                            Icons.facebook,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text('Send Us A WhatsApp Message',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.sp, color: Colors.white)),
                        ]),
                                            
                                      
                          
                                          
                                        ),
                                      ),
                                       SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white, backgroundColor: Color(0xFF205072),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onPressed: () {
                                             launchUrl(Uri(
                                                                                scheme: 'tel',
                                                                                path: '+232 79 230776',
                                                                              ));
                                                },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text('Give Us A Call',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.sp, color: Colors.white)),
                        ]),
                                            
                                      
                          
                                          
                                        ),
                                      )
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
                 
                  
              ],
            ),
             Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Follow us on our socials.',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                                      SizedBox(
                      height: 10.h,
                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                       InkWell(
                                                         onTap: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var facebookUrl =
          "https://www.facebook.com/lifebloodsl";
      try {
        launch(facebookUrl);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch Facebook',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                                                         child: Image.asset(
                                                                                               'assets/icons/facebook.png',
                                                                                               height: 30.h,
                                                                                               width: 30.w,
                                                                                             ),
                                                       ),
                                       SizedBox(
                    width: 15.h,
                  ),
                                      InkWell(
                                        onTap: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var twitterUrl =
          "https://twitter.com/LifeBloodSL";
      try {
        launch(twitterUrl);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch Twitter',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                                        child: Image.asset(
                                          'assets/icons/twitter.png',
                                          height: 30.h,
                                          width: 30.w,
                                        ),
                                      ), SizedBox(
                    width: 15.h,
                  ),InkWell(
                    onTap: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var instaUrl =
          "https://www.instagram.com/lifeblood232/";
      try {
        launch(instaUrl);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch Instagram',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                    child: Image.asset(
                                          'assets/icons/instagram.png',
                                          height: 30.h,
                                          width: 30.w,
                                        ),
                  ), SizedBox(
                    width: 15.h,
                  ),
                                      InkWell(
                                        onTap: () async {
      //To remove the keyboard when button is pressed
      FocusManager.instance.primaryFocus?.unfocus();
      var instaUrl =
          "https://www.linkedin.com/company/lifebloodsl/about/";
      try {
        launch(instaUrl);
      } catch (e) {
        //To handle error and display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Could Not Launch LinkedIn',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      }
    },
                                        child: Image.asset(
                                          'assets/icons/linkedin.png',
                                          height: 30.h,
                                          width: 30.w,
                                        ),
                                      ), SizedBox(
                    width: 15.h,
                  ),
                                      
                                                       
                                                      ],
                                                    )
                  ],
                ),
             ),
            
               SizedBox(
                    height: 20.h,
                  ),
                  
          Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LifeBlood Version 2.0',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey)),
                ],
              ),
               SizedBox(
                    height: 20.h,
                  ),
          ],
        ),
        
      ),
    );
  }
}
