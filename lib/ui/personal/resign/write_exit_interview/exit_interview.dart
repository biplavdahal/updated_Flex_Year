import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/resign/write_exit_interview/survey.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_shimmer.widget.dart';

class ExitInterview extends StatelessWidget {
  static String tag = 'exit-interview';
  const ExitInterview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<ResignViewModel>(
        enableTouchRepeal: true,
        builder: (ctx, model, child) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(''),
                bottom: PreferredSize(
                  child: Container(
                      color: AppColor.primary,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                        child: auBaseURL + model.logo.logoPath == null
                            ? Image.network(
                                auBaseURL + model.logo.logoPath,
                                width: 150,
                                height: MediaQuery.of(context).size.height,
                              )
                            : Image.asset(
                                "assets/images/flex_year_login_image.png",
                                width: 150,
                              ),
                      )),
                  preferredSize: const Size(double.infinity, 90),
                ),
              ),
              body: Scaffold(
                backgroundColor: AppColor.primary,
                body: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Exit Interview ! ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'All you need to do is follow the prompts to complete the process as requested by ${model.company.companyName}.',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            "assets/images/exit.png",
                            height: 200,
                            width: MediaQuery.of(context).size.height / 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            ' To do',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Exit Interview',
                                    style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  FYPrimaryButton(
                                    label: '  Start -->',
                                    backgroundColor: AppColor.primary,
                                    onPressed: () async {
                                      model.goto(SurveyView.tag);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Have a question?',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You are welcome to reach out  to ${model.company.email} or contact directly at ${model.company.phone}. ',
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
