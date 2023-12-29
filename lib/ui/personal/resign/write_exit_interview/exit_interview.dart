import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_shimmer.widget.dart';

class ExitInterview extends StatelessWidget {
  static String tag = 'exit-interview';
  const ExitInterview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ResignViewModel>(
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
                          Text(
                            "Exit Interview ! ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'All you need to do is follow the prompts to complete the process as requested by ${model.company.companyName}.',
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            "assets/images/exit.png",
                            height: 200,
                            width: MediaQuery.of(context).size.height / 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Exit Interview',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
