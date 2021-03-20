import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';

class TheTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function onSubmitted;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLength;
  final bool obscureText;
  final String errorText;
  final bool isArea;
  final List<TextInputFormatter> inputFormatters;
  final Function(bool) onTextFieldTap;
  final TextInputAction textInputAction;
  final bool enabled;

  TheTextField({
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    @required this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.onSubmitted,
    this.maxLength,
    this.isArea,
    this.inputFormatters,
    this.onTextFieldTap,
    this.textInputAction,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
          borderSide: BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        errorText: errorText,
      ),
    );
  }
}

class TheTextFieldRadius extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function onSubmitted;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLength;
  final bool obscureText;
  final String errorText;
  final bool isArea;
  final List<TextInputFormatter> inputFormatters;
  final Function(bool) onTextFieldTap;
  final TextInputAction textInputAction;
  final bool enabled;

  TheTextFieldRadius({
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    @required this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.onSubmitted,
    this.maxLength,
    this.isArea = false,
    this.inputFormatters,
    this.onTextFieldTap,
    this.textInputAction,
    this.enabled = true,
  });

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
            color: TheColors.black,
            fontSize: 14,
            fontWeight: TheFontWeight.semiBold,
          ),
        ),
        TheSizedBox.ultraSmallVertical(),
        TextField(
          key: key,
          maxLines: isArea ? 5 : 1,
          enabled: enabled,
          enableSuggestions: false,
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey),
            hintText: hintText,
            fillColor: Colors.white,
            errorText: (errorText ?? '') != '' ? errorText : null,
            errorStyle: TextStyle(color: Colors.red),

//                counter: Container(),
          ),
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
