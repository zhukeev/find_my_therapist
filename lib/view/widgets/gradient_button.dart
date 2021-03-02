import 'package:find_my_therapist/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomButton({Key key, @required this.onPressed, @required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.maxFinite,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
                colors: [Palette.pictonBlue, Palette.pictonBlue2])),
        child: FlatButton(
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
      ),
    );
  }
}
