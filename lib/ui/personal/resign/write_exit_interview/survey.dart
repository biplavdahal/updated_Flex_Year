import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/resign/widget/survey.widget.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_shimmer.widget.dart';

class SurveyView extends StatelessWidget {
  static String tag = 'survey-view';
  const SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ResignViewModel>(
      enableTouchRepeal: true,
      onModelReady: (model) {
        model.ExitSurveyinit();
      },
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Survey'),
          ),
          body: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Your Details',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                if (model.isLoading)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => getShimmerLoading(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 30,
                      ),
                      itemCount: 5,
                    ),
                  ),
                if (!model.isLoading)
                  if (model.exitSurveyData.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SurveyItem(
                            index: index,
                            survey: model.exitSurveyData[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: model.exitSurveyData.length,
                      ),
                    ),
                FYPrimaryButton(
                  label: 'Submit answer',
                  onPressed: () {},
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
