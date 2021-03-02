import 'dart:ui';

import 'package:find_my_therapist/constants.dart';
import 'package:flutter/material.dart';

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ArrowBackButton({Key key, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      child: SizedBox(
        width: 24,
        height: 24,
        child: RaisedButton(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          onPressed: onPressed,
          child: Icon(Icons.arrow_back_ios, color: Palette.blueZodiac),
        ),
      ),
    );
  }
}
