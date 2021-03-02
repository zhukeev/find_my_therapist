import 'package:find_my_therapist/constants.dart';
import 'package:find_my_therapist/view/widgets/back_button.dart';
import 'package:find_my_therapist/view/widgets/gradient_button.dart';
import 'package:find_my_therapist/view/widgets/sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recomended_therapy_page.dart';

class FindMyTherapistPage extends StatefulWidget {
  @override
  _FindMyTherapistPageState createState() => _FindMyTherapistPageState();
}

class _FindMyTherapistPageState extends State<FindMyTherapistPage> {
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("I need assistance"),
    1: Text("I know")
  };

  final Map<String, String> issues = const <String, String>{
    'Abuse': 'Emotional, phisycal, sexual abuse or etc.',
    'Addiction': 'Alcohol, drug, gambling, love or etc.',
  };

  final mostRelatedProblems = [
    'Individual difficulties',
    'Problems in my relationship',
    'A traumatic event',
    'I want to discuss medication'
  ];

  final appointments = ['A child (under 18)', 'An adult'];
  final difficultyPeriod = ['More than 5 years', 'Less than 5 years'];
  final parentsAnwers = ['No', 'Somewhat', 'Yes'];

  String chosenProblem = 'Individual difficulties';
  String chosenIssue = 'Abuse';
  String chosenAppointment = 'An adult';
  String chosenDifficultyPeriod = 'More than 5 years';
  String chosenParentAnswer = 'No';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find my therapist',
          style: textTheme.subtitle1
              .copyWith(color: Palette.downriver, fontWeight: FontWeight.w500),
        ),
        leading: ArrowBackButton(
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find my therapist',
                      style: textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.blueZodiac),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Choose the needed parameters and find your therapist.',
                      style:
                          textTheme.subtitle1.copyWith(color: Palette.eastBay),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Do you know what type of therapist \ndo you need?',
                      style: textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.blueZodiac),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      child: SlidingSegmentedControl(
                          children: myTabs,
                          cornerRadius: 28.0 * 2,
                          groupValue: segmentedControlGroupValue,
                          onValueChanged: (val) => setState(() {
                                segmentedControlGroupValue = val;
                              })),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'What does the problem most relate to?',
                      style: textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.blueZodiac),
                    ),
                  ],
                ),
              ),
              buildMostRelatedProblems(textTheme),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Text(
                  'Choose issues you want to discuss:',
                  style: textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w600, color: Palette.blueZodiac),
                ),
              ),
              buildIssuesToDiscuss(textTheme),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Text(
                  'Who is the appointment for?',
                  style: textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w600, color: Palette.blueZodiac),
                ),
              ),
              buildAppointments(textTheme),
              if (appointments.last == chosenAppointment)
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 8, top: 25),
                      child: Text(
                        'Are your parents highly empathetic, good at communicating, talking about and understanding your emotions?',
                        style: textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.blueZodiac),
                      ),
                    ),
                    buildQuestionsToParents(textTheme)
                  ],
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
                child: CustomButton(
                  label: 'Next step',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RecomendedTherapyPage()));
                  },
                ),
              )
            ],
          )),
    );
  }

  Column buildAppointments(TextTheme textTheme) {
    return Column(
      children: appointments
          .map(
            (item) => Row(
              children: [
                Radio(
                  value: item,
                  activeColor: Palette.blueZodiac,
                  groupValue: chosenAppointment,
                  onChanged: (v) {
                    setState(() {
                      chosenAppointment = v;
                    });
                  },
                ),
                Text(item,
                    style: textTheme.subtitle1
                        .copyWith(color: Palette.blueZodiac)),
              ],
            ),
          )
          .toList(),
    );
  }

  Column buildQuestionsToParents(TextTheme textTheme) {
    return Column(
      children: parentsAnwers
          .map(
            (item) => Row(
              children: [
                Radio(
                  value: item,
                  activeColor: Palette.blueZodiac,
                  groupValue: chosenParentAnswer,
                  onChanged: (v) {
                    setState(() {
                      chosenParentAnswer = v;
                    });
                  },
                ),
                Text(item,
                    style: textTheme.subtitle1
                        .copyWith(color: Palette.blueZodiac)),
              ],
            ),
          )
          .toList(),
    );
  }

  SingleChildScrollView buildIssuesToDiscuss(TextTheme textTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: issues.entries
              .map((issue) => GestureDetector(
                    onTap: () {
                      setState(() {
                        chosenIssue = issue.key;
                      });
                    },
                    child: SizedBox(
                      height: 116,
                      child: Card(
                        color: chosenIssue == issue.key
                            ? Colors.white
                            : Palette.athensGray,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        shadowColor: chosenIssue == issue.key
                            ? Palette.pictonBlue.withOpacity(.15)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: chosenIssue == issue.key
                                    ? Palette.pictonBlue
                                    : Palette.mischka),
                            borderRadius: BorderRadius.circular(16)),
                        child: AspectRatio(
                          aspectRatio: 1.96,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  issue.key,
                                  style: textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Palette.blueZodiac),
                                ),
                                Text(
                                  issue.value,
                                  style: textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Palette.blueZodiac),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }

  Column buildMostRelatedProblems(TextTheme textTheme) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: mostRelatedProblems
            .map(
              (item) => Row(
                children: [
                  Radio(
                    value: item,
                    activeColor: Palette.blueZodiac,
                    groupValue: chosenProblem,
                    onChanged: (v) {
                      setState(() {
                        chosenProblem = v;
                      });
                    },
                  ),
                  Text(item,
                      style: textTheme.subtitle1
                          .copyWith(color: Palette.blueZodiac)),
                ],
              ),
            )
            .toList());
  }
}
