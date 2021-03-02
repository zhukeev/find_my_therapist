import 'package:find_my_therapist/constants.dart';
import 'package:find_my_therapist/view/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecomendedTherapyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recomended therapy',
            style: textTheme.subtitle1.copyWith(
                color: Palette.downriver, fontWeight: FontWeight.w500),
          ),
          leading: ArrowBackButton(
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(child: Column()));
  }
}
