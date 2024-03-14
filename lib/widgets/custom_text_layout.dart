import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextLayout extends StatelessWidget {
  const CustomTextLayout({
    super.key,
    required this.title,
    required this.patientInfo,
  });

  final String title;
  final String patientInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black.withOpacity(0.800000011920929),
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.27,
          ),
        ),
        Text(
          patientInfo,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            letterSpacing: -0.36,
          ),
        )
      ],
    );
  }
}

class CustomOverTextLayout extends StatelessWidget {
  const CustomOverTextLayout({
    super.key,
    required this.title,
    required this.patientInfo,
  });

  final String title;
  final String patientInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black.withOpacity(0.800000011920929),
            fontSize: 15,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.27,
          ),
        ),
        10.horizontalSpace,
        Text(
          patientInfo,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            letterSpacing: -0.36,
          ),
        )
      ],
    );
  }
}
