import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/resign/widget/survey.widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_shimmer.widget.dart';

class SurveyView extends StatelessWidget {
  static String tag = 'survey-view';
  const SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<ResignViewModel>(
      enableTouchRepeal: true,
      onModelReady: (model) {
        model.ExitSurveyinit();
      },
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Your Details'),
          ),
          body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
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
                    CustomSurveyDialog(
                      surveyQuestions: model.exitSurveyData,
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
