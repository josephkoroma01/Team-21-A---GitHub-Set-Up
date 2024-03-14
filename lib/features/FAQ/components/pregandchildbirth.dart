import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';


class PregandChildBirth extends StatefulWidget {
  const PregandChildBirth({Key? key}) : super(key: key);

  @override
  State<PregandChildBirth> createState() => _PregandChildBirthState();
}

class _PregandChildBirthState extends State<PregandChildBirth> {
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
        title: Text('Pregnancy and Child Birth',
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
        ],
      ),
    );
  }
}

const faq1 = "Not right now, no. This is to protect your health and avoid causing stress to you and your baby’s circulation.  \n\nAfter you give birth, you’ll need to wait another nine months from delivery date to allow your body enough time to replenish its iron. There are also donation restrictions related to breastfeeding. But, even if you can’t donate blood temporarily, you may be able to donate breast milk instead.\n\nIf you’re a blood donor currently trying to become pregnant, we recommend you take a break from donation to help build and maintain healthy iron levels to support the increased iron requirements of a pregnancy.  ";
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
                          "I am pregnant. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq1,
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


const faq2 = "You’ll need to wait a little while before donating to allow time for your body to replenish its iron. If the pregnancy was lost during the first or second trimester, you’ll need to wait six months. For a third-trimester pregnancy loss, you’ll need to wait nine months. \n\nPlease be aware that one of the questions we ask new donors relates to whether you have ever been pregnant, and for existing donors whether you have had any pregnancies since the last donation, including early pregnancy losses. We understand that this question can be painful for many people. Lifeblood will always treat your answer sensitively and with complete confidentiality.\n\nIf you would like more information about why we need to ask this question, please contact us.  ";
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
                          "I have had a pregnancy loss. Can I donate?",
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

const faq3 = "At least nine months and when your baby is significantly weaned (that is, getting most of his/her nutrition from solids). But you may still be able to help in a different, and very special, way. If you have excess breast milk you may be able to donate it to help premature babies. ";
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
                          "How long after the birth of my baby can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq3,
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


const faq4 = "Not right away. For your health, following childbirth you need to wait at least nine months and until your baby is significantly weaned (that is, getting most of his/her nutrition from solids) before you donate blood.   But you may still be able to help in a different, and very special, way. If you have excess breast milk you may be able to donate it to help premature babies. ";
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
                          "I’m breastfeeding. Can I donate?",
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
