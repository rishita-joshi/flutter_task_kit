import 'package:flutter/material.dart';

import '../extensions/colors.dart';

class EventTextBoxWidget extends StatelessWidget {
  const EventTextBoxWidget(
      {Key? key,
      required this.hintText,
      this.isSufix = false,
      this.isPassword = false,
      this.callback,
      this.icon,
      this.prefixWidget,
      required this.controller})
      : super(key: key);

  final String hintText;
  final bool? isSufix;
  final Function? callback;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;
  final Widget? prefixWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: ThemeClass.greyColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixWidget,
          suffixIcon: isSufix!
              ? IconButton(
                  icon: Icon(
                    icon,
                    color: ThemeClass.greenColor,
                  ),
                  onPressed: () {
                    callback!();
                    // _selectTime();
                  },
                )
              : null,
          focusColor: ThemeClass.greenColor,
          hintText: hintText,
          prefixStyle: TextStyle(color: ThemeClass.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
