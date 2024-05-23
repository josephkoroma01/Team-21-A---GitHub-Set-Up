import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.name,
    this.hinttext,
    this.prefix,
    this.suffix,
    this.fill,
    this.fillColor,
    this.maxLines,
    this.enabled,
    this.controller,
  });

  final String name;
  final String? hinttext;
  final dynamic prefix;
  final dynamic suffix;
  final bool? fill;
  final Color? fillColor;
  final int? maxLines;
  final bool? enabled;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      enabled: enabled?? true,
      style: TextStyle(
          color: Colors.black, fontFamily: 'Montserrat', fontSize: 14),
      name: name,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: name,
        prefixText: prefix,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixStyle: TextStyle(
            fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
        suffixText: suffix,
        suffixStyle: TextStyle(
            fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
        labelStyle: TextStyle(
            fontFamily: 'Montserrat', fontSize: 14, color: Colors.black, letterSpacing: 0),
            
        filled: fill ?? false,
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
       
        border: const OutlineInputBorder(
          
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        // contentPadding: const EdgeInsets.symmetric(
        //   horizontal: 20,
        //   vertical: 30,
        // ),
        hintText: enabled?? true?name:hinttext,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.800000011920929),
          fontSize: 15,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.clip,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
