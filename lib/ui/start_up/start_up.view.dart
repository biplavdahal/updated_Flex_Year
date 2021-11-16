import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  static String tag = "start-up-view";

  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<StartUpModel>(
      builder: (ctx, model, child) {
        return const Scaffold(
          body: Center(
            child: Text("StartUpView"),
          ),
        );
      },
    );
  }
}
