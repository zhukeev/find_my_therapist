import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_therapist/constants.dart';
import 'package:find_my_therapist/view/widgets/back_button.dart';
import 'package:find_my_therapist/view/widgets/gradient_button.dart';
import 'package:find_my_therapist/viewmodel/find_my_therapist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecomendedTherapyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ArrowBackButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            Text('Recomended therapy',
                style: textTheme.subtitle1.copyWith(
                    color: Palette.downriver, fontWeight: FontWeight.w500)),
            SizedBox(width: 24)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<FindMyTherapistProvider>(
            builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFF3353C4).withOpacity(0.08),
                      offset: Offset(0, 4)),
                ]),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 18, left: 18),
                child: Text(
                  'Based on your answers we recommend you the following therapy: ',
                  textAlign: TextAlign.center,
                  style:
                      textTheme.bodyText2.copyWith(color: Palette.blueZodiac),
                ),
              ),
              provider.recomendedTherapy == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            provider.recomendedTherapy.data.title,
                            style: textTheme.headline5.copyWith(
                                color: Palette.blueZodiac,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      CircularProgressIndicator(
                                          value: progress.progress),
                              imageUrl:
                                  'https://i2.wp.com/www.sarahlisterpsychology.com.au/wp-content/uploads/Sarah-lister-psychology-supervision.jpg?w=1000&ssl=1'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            provider.recomendedTherapy.data.description,
                            style: textTheme.bodyText2
                                .copyWith(color: Palette.blueZodiac),
                          ),
                        ),
                      ],
                    ),
            ]),
          );
        }),
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0XFF3353C4).withOpacity(0.08),
                  offset: Offset(0, 4)),
            ],
          ),
          child: CustomButton(onPressed: () {}, label: 'Next Step'),
        )
      ],
    );
  }
}
