import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';


class NSBSFaq extends StatefulWidget {
  const NSBSFaq({Key? key}) : super(key: key);

  @override
  State<NSBSFaq> createState() => _NSBSFaqState();
}

class _NSBSFaqState extends State<NSBSFaq> {
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
                  builder: (context) => HomePageScreen(pageIndex: 1,),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text('National Safe Blood Service',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: size.width * 0.045, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height:20.h),
          Card1(),
          Card2(),
          Card3(),
          Card4(),
          Card5(),
          Card6(),
          Card7(),
          Card8(),
          Card9(),
          Card10(),
          Card11(),
          Card12(),
          Card13(),
          Card14(),
          Card15(),
          Card16(),



        ],
      ),
    );
  }
}

const faq1 = "Because you can make a difference! The human body is the only manufacturer of blood.\n\nTherefore, you can help save the life of a patient requiring blood. There is no substitute and still only one source of blood for transfusion Volunteer Blood Donors. \n\nEmergency happen at all hours of the day or night such as:\n\n> Motor accidents\n>Women with complicated pregnancy or child birth\n> Disasters or emergency situations\n> Surgical operations, trauma victims, Cancer, dialysis, people with sickle cell disease, industrial accident and other blood disorders\n> Gastrointestinal bleeding due to blood loss\n";

class Card1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Why I should give blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq1,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq1,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq2 = "NO. You will be given something to drink and eat after giving blood. As a regular donor, if your children, wife and mother/father require transfusion a fee is wave off. The greatest payment can have is knowing that you have helped a fellow human being\u0027s life.";

class Card2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Will I receive payment for giving blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq2,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq2,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq3 = "Be sure to eat well at your regular mealtimes and drink plenty of fluids before and after donation.";
class Card3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Is there anything I should do before donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq3,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq3,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq4 = "Yes, provided they are: \n\n> Healthy Between the ages of 18 - 60 years (first time donor) and 19- 65 years for regular donor.\n> Weighed 50kg or more\n> Free from cold, flu, sore throat, cold sore stomach bug or any other infection. \n> With a haemoglobin level of 12.0 - 15.5g/dl for female and 13.0 - 17.5g/dl for male";

class Card4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Can anybody donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq4,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq5 = "Donate blood today, tell relatives about donation. Get them to become regular donor.";
class Card5 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "How can I help?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq5,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq5,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq6 = "The average adult has four-and-a-half liters of blood. A single donation is about 387ml. Male donors can give blood safely four times a year and three/two times a year for female donors";
class Card6 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Do I have enough blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq6,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq6,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq7 = "Approximately 10 - 15 minutes";
class Card7 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "How long does it take to donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq7,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq7,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq8 = "Blood is screened in order to determine the HIV, Hepatitis B & C, Syphilis status, ABO and Rh. group of the donor, Normally only blood of the same type as that of the patient is given to the recipient of the blood";
class Card8 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "What checks are done on my blood:",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq8,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq8,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq9 = "Blood groups are inherited from your father and mother. They do not change, for the rest of Your life\n\nHuman beings have the following blood groups\n> A Rh Positive (A+)\n> B Rh Positive (B+)\n> O Rh Positive (O+)\n> AB Rh Positive (AB+)\n> A Rh Negative (A-)\n> B Rh Negative (B-)\n> O Rh Negative (O-)\n> AB Rh Negative (AB-)\n\nBlood groups inciuding the Rh factor have nothing to do with AiDS or HIV or any other disease, for example; if you are group O\u0027s Rh. Positive, this means Rhesus positive NOT HIV positive";

class Card9 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "What are blood groups?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq9,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq9,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq10 = "Blood is screen for Hepatitis B, Hepatitis C, HIV (AIDS virus) and Syphilis. The health of the person who received your blood is of paramount importance. That why all donated blood require screening. \n\nThe National Safe Blood Services is not a centre for screening for diseases in the population. If you are worried about your health, contact your nearest clinic/doctor. All laboratory tests are done in stil-brontence by our laboratory Staff";
class Card10 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "What other checks are done on my blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq10,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq10,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq11 = "Blood is not sold. A service charge is levied to cover cost incurred in taking blood from the donor to the patient i.e. in\n> Collecting\n> Processing\n> Storage and distribution\n> Equipment maintenance\n> Laboratory testing\n> Staff expenses\n> Transport\n\nBlood is precious nobody can put a price on it";
class Card11 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Why do hospitals and blood banks charge for blood when it is donated free?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq11,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq11,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq12 = "Only your doctor or your next of kin or both, if you have requested that your test result should be discussed with them No one else will be informed without your consent.";
class Card12 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Who else will be told if there is something wrong with my blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq13 = "Normally No. A healthy blood donor who has given a true medical history should not faint during or after donating blood. No medicine is injected into you, Only professionally trained staff will attend to you. However, one might feel lightheaded, di or nauseous. You may develop, arm pain, that will last for short time.";
class Card13 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Are there any side effects to donating blood",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq13,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq13,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq14 = "No. All equipment used in taking blood are used only once on each donor. Used needles, lancets etc, are disposed of by burning after a single dose.";
class Card14 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Will I catch AIDS from donating blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq14,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq14,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq15 = "No. You should be able to perform your duties normally after giving blood just need to rest for few hours. However, DO NOT DONATE IF YOU have EVER taken money, drugs, or other payment for sex.";
class Card15 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Is my sex life or daily work routine, affected by donating blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq15,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq15,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq16 = "National Safe Blood Services Centre:\nConnaught Hospital\n\nRegional Blood Transfusion Centre:\nPrincess Christian Maternity Hospital\n\n34 Military Hospital\n\nRokupa Government Hospital";
class Card16 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Where can I donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq16,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq16,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
