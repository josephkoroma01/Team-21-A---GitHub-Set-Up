import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.name,
    this.prefix,
    this.suffix,
    this.fill,
    this.fillColor,
    this.maxLines,
    this.controller,
  });

  final String name;
  final dynamic prefix;
  final dynamic suffix;
  final bool? fill;
  final Color? fillColor;
  final int? maxLines;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return
     FormBuilderTextField(
      style: TextStyle(color: Colors.black, fontFamily: 'Montserrat',fontSize: 14),
      name: name,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        
        labelText: name,
        prefixText: prefix,
        prefixStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
        suffixText: suffix,
        suffixStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
        labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
        filled: fill ?? false,
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5
          ),
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
        hintText: name,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.800000011920929),
          fontSize: 15,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          height: 0.07,
          letterSpacing: -0.27,
        ),
      ),
    );
  }
}
