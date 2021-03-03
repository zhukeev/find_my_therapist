import 'package:find_my_therapist/constants.dart';
import 'package:find_my_therapist/model/problem.dart';
import 'package:find_my_therapist/view/widgets/back_button.dart';
import 'package:find_my_therapist/view/widgets/gradient_button.dart';
import 'package:find_my_therapist/view/widgets/sliding_segmented_control.dart';
import 'package:find_my_therapist/viewmodel/find_my_therapist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recomended_therapy_page.dart';

class FindMyTherapistPage extends StatelessWidget {
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("I need assistance"),
    1: Text("I know")
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ArrowBackButton(onPressed: () {}),
            Text('Find my therapist',
                style: textTheme.subtitle1.copyWith(
                    color: Palette.downriver, fontWeight: FontWeight.w500)),
            SizedBox(width: 24)
          ],
        ),
      ),
      body: Consumer<FindMyTherapistProvider>(
          builder: (context, provider, child) {
        return provider.isRequesting
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 24),
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
                            style: textTheme.subtitle1
                                .copyWith(color: Palette.eastBay),
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
                                groupValue: provider.segmentedControlGroupValue,
                                onValueChanged:
                                    provider.changeSegmentedControl),
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
                    buildMostRelatedProblems(textTheme, provider),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        'Who is the appointment for?',
                        style: textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.blueZodiac),
                      ),
                    ),
                    buildAppointments(textTheme, provider),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        'How long have you had your difficulty for?',
                        style: textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.blueZodiac),
                      ),
                    ),
                    buildDiffcultyPeriod(textTheme, provider),
                    if (provider.difficultyPeriod
                            .indexOf(provider.difficultyPeriod.last) ==
                        provider.chosenDifficultyPeriod)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, bottom: 8, top: 25),
                            child: Text(
                              'Are your parents highly empathetic, good at communicating, talking about and understanding your emotions?',
                              style: textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.blueZodiac),
                            ),
                          ),
                          buildQuestionsToParents(textTheme, provider)
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
                      child: CustomButton(
                        label: 'Next step',
                        onPressed: () {
                          provider.getRecomendation();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => RecomendedTherapyPage()));
                        },
                      ),
                    )
                  ],
                ));
      }),
    );
  }

  Column buildAppointments(
      TextTheme textTheme, FindMyTherapistProvider provider) {
    return Column(
      children: provider.category.data
          .map(
            (item) => Row(
              children: [
                Radio(
                  value: item.clientCategoryId,
                  activeColor: Palette.blueZodiac,
                  groupValue: provider.chosenClientCategory,
                  onChanged: provider.changeCategory,
                ),
                Text(item.title,
                    style: textTheme.subtitle1
                        .copyWith(color: Palette.blueZodiac)),
              ],
            ),
          )
          .toList(),
    );
  }

  Column buildDiffcultyPeriod(
      TextTheme textTheme, FindMyTherapistProvider provider) {
    return Column(
      children: provider.difficultyPeriod
          .map(
            (item) => Row(
              children: [
                Radio(
                  value: provider.difficultyPeriod.indexOf(item),
                  activeColor: Palette.blueZodiac,
                  groupValue: provider.chosenDifficultyPeriod,
                  onChanged: provider.changeDifficultyPeriod,
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

  Column buildQuestionsToParents(
      TextTheme textTheme, FindMyTherapistProvider provider) {
    return Column(
      children: provider.parentsAnwers
          .map(
            (item) => Row(
              children: [
                Radio(
                  value: provider.parentsAnwers.indexOf(item),
                  activeColor: Palette.blueZodiac,
                  groupValue: provider.chosenParentsAnswer,
                  onChanged: provider.changeParentsAnwer,
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

  SingleChildScrollView buildIssuesToDiscuss(TextTheme textTheme,
      List<Issue> issues, FindMyTherapistProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: issues
              .map((issue) => GestureDetector(
                    onTap: () {
                      provider.changeIssue(issues.indexOf(issue));
                    },
                    child: SizedBox(
                      height: 116,
                      child: Card(
                        color: provider.chosenIssue == issues.indexOf(issue)
                            ? Colors.white
                            : Palette.athensGray,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        shadowColor:
                            provider.chosenIssue == issues.indexOf(issue)
                                ? Palette.pictonBlue.withOpacity(.15)
                                : Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: provider.chosenIssue ==
                                        issues.indexOf(issue)
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
                                  issue.title,
                                  style: textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Palette.blueZodiac),
                                ),
                                Text(
                                  issue.description,
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

  Column buildMostRelatedProblems(
      TextTheme textTheme, FindMyTherapistProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            children: provider?.problem?.data
                ?.map(
                  (item) => Row(
                    children: [
                      Radio(
                          value: item.id,
                          activeColor: Palette.blueZodiac,
                          groupValue: provider.chosenProblem,
                          onChanged: provider.changeProblem),
                      Text(item.title,
                          style: textTheme.subtitle1
                              .copyWith(color: Palette.blueZodiac)),
                    ],
                  ),
                )
                ?.toList()),
        SizedBox(height: 25),
        if (provider?.problem?.data
                ?.firstWhere((e) => e.id == provider.chosenProblem)
                ?.issues !=
            null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Choose issues you want to discuss:',
              style: textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.w600, color: Palette.blueZodiac),
            ),
          ),
          buildIssuesToDiscuss(
              textTheme,
              provider?.problem?.data
                  ?.firstWhere((e) => e.id == provider.chosenProblem)
                  ?.issues,
              provider),
        ]
      ],
    );
  }
}
