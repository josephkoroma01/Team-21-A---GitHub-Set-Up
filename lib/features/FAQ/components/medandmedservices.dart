import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';


class MedCondition extends StatefulWidget {
  const MedCondition({Key? key}) : super(key: key);

  @override
  State<MedCondition> createState() => _MedConditionState();
}

class _MedConditionState extends State<MedCondition> {
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
        title: Text('Medication and Medical Devices',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: size.width * 0.045, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
         SizedBox(
           height: 20.h,
         ),
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



        ],
      ),
    );
  }
}

const faq1 = "If your medication was prescribed by a doctor registered in Sierra Leone, you can donate. In some cases, testosterone may cause your haemoglobin levels (a protein in your blood that transports oxygen) to increase to above the acceptable range for donation. Don’t worry, though — we test your haemoglobin level before each donation and if it’s within the acceptable range on the day, you can donate.";

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
                          "I’m using testosterone patches or receiving testosterone injections. Can I donate?",
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


const faq2 = "Yes, providing your blood pressure is adequately controlled, stable, and you don’t have any side effects related to your medication.";

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
                          "I take blood pressure medicine. Can I donate?",
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

const faq3 = "Maybe. It depends on why you’re taking the antibiotics.\n\nRecent infection: The infection must have resolved at least one week ago and you need to have completed the full course of antibiotics five days before you donate.\n\nPreventative antibiotics for mild acne or rosacea (minocycline, doxycycline or erythromycin): You’re eligible to donate.\n\nOther preventative antibiotics used when you don’t have a current infection are okay in some cases. \n\nContact us to double check if you can donate.";
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
                          "I’m taking antibiotics. Can I donate?",
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


const faq4 = "It depends on the type of vaccine. \nThese vaccines don't include any live material and you can donate straight away after having one.\n\nDiphtheria\nInfluenza (both seasonal flu and H1N1 or 'swine' flu)\nHepatitis A\nMeningococcus\nPertussis (whooping cough)\nPneumococcus\nQ fever\nTetanus\nHuman papillomavirus (Gardasil)\nShingrix for shingles.\n\nOther vaccines are made from live material, meaning you can give plasma right away but need to wait four weeks before donating blood or platelets. These include:\nMeasles\nMumps\nRubella\nPolio (Sabin)\nChicken pox/shingles\nTuberculosis (BCG)\n\nWait 3 days before donating anything\nCOVID-19 vaccine.\n\nWait 2 weeks before donating anything\nHepatitis B\n\nWait 8 weeks before donating anything\nSmallpox\nTrial vaccines for anything other than HIV or hepatitis C\n\nWait 12 months or more before donating anything\nTrial vaccines for HIV or hepatitis C\nIf you're unsure what type of vaccine you received, wait 2 weeks before donating anything, and then only donate plasma for 12 months.\n\nRemember, if you aren’t sure about whether, or when, you can give blood after having a vaccination, just contact us.  ";

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
                          "How long after I've had a vaccination can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
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
                              faq4,
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

const faq5 = "Yes, but when you can give blood depends on the type of hepatitis vaccination you've had. Hepatitis B vaccine: You’ll need to wait two weeks before you donate. This also applies for combined hepatitis A and B vaccines. Hepatitis A vaccine: It’s okay to give blood straight away";
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
                          "I've had a hepatitis vaccination. Can I give blood?",
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

const faq6 = "Usually, yes, but you’ll need to wait six months after getting your pacemaker. Please contact us to double check if you can donate.";
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
                          "I have a pacemaker. Can I give blood?",
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

const faq7 = "Most prescribed medicines don’t prevent you from donating, but the medical condition they are prescribed for might. \nYou can’t donate while you’re taking any of the following medications and for a period of time after you’ve finished:\n\nIsotretinoin (Roaccutane, Oratane): used for acne\nAcitretin (Neotigason): used for acne and psoriasis\nEtretinate (Tigason): used for acne\nDutasteride (Avodart, Duodart): used for benign prostatic hypertrophy (enlarged prostate)\nFinasteride (Finasta, Finnacar, Finpro, Propecia, Proscar): used for benign prostatic hypertrophy and hair loss\nLeflunomide (Arava, Arabloc, Lunava): used for arthritis and sarcoidosis\nMisoprostol (Cytotec): used for peptic ulcers\nDenosumab (Prolia) or Raloxifene (Evista): used for osteoporosis\n\nEven low doses of these medications could affect the vulnerable people receiving your blood (e.g. pregnant women and newborn babies).\n\nIf you take any of the medications listed above, wait until you’ve completed treatment and then contact us to see when you will become eligible to donate. If you’re on other prescribed medications, please note their names and give us a call to see if any of them will affect your eligibility to donate.\n\nFor your own health, please don’t stop taking any medication to donate.";
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
                          "What prescribed medications will prevent me from donating?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq7,
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

const faq8 = "Yes, you can donate. Taking hormone replacement therapy doesn’t affect your ability to donate blood.";
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
                          "I am taking hormone replacement therapy (HRT). Am I eligible to donate?",
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

const faq9 = "Yes. Having an injection (e.g. DepoProvera®) or implant (e.g. Implanon®, IUD) inserted for birth control doesn’t affect whether you can donate, as long as there are no complications from the procedure.";

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
                          "I've had a contraceptive injection or implant. Can I donate?",
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

const faq10 = "Yes. Taking birth control pills (oral contraceptives or ‘the pill’) doesn’t affect your ability to donate blood at all.";
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
                          "I am on the pill. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq10,
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

const faq11 = "Usually, yes. If you take cholesterol-lowering medication prescribed to prevent coronary artery disease, you can still give blood. But, if you have existing coronary artery disease, you won’t be able to donate blood for your own safety.";
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
                          "I take medication for cholesterol reduction. Can I donate?",
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

const faq12 = "Usually yes, as long as you’re well and have no side effects from the medication. To confirm if you can donate, please contact us.";
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
                          "I take an antidepressant. Can I donate?",
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

