import 'package:flutter/material.dart';

import '../extensions/colors.dart';

Widget buttonWidget(
  String buttonTitle,
  Function onClick,
  BuildContext context,
) =>
    Center(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              //fontWeight: FontWeight.medium
            ),
          ),
        ),
        color: Colors.blue,
        onPressed: () {
          onClick();
        },
      ),
    );

Widget titleLoginRegisterWidget(String text) => Container(
      child: Text(
        text,
        style: ThemeClass.titleTextStyleGreen,
      ),
    );

Widget subTitleLoginRegisteWidget(String text) => Container(
      child: Text(
        text,
        style: ThemeClass.smallSubTitleStyleGray,
      ),
    );
