import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      this.alignment,
      required this.color,
      this.onPressed,
      this.icon,
      this.horizontalPadding,
      this.verticalPadding,
      this.fontSize,
      this.width,
      this.textColor});

  final String title;
  final IconData? icon;
  final Alignment? alignment;
  final Color color;
  final VoidCallback? onPressed;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? fontSize;
  final double? width;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 0,
              side: BorderSide(
                color: Color(0x19A2A1A8),
                width: 1.0,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding ?? 5,
                  vertical: verticalPadding ?? 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          onPressed: onPressed,
          child: icon ==null?
          Text(
            title,
            style: TextStyle(
              color: textColor ?? kWhiteColor,
              fontSize: fontSize ?? 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.26,
            ),
          ):IntrinsicWidth(
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                5.horizontalSpace,
                Text(
                  title,
              style: TextStyle(
                color: textColor ?? kWhiteColor,
                fontSize: fontSize ?? 13,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.26,
              ),
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
