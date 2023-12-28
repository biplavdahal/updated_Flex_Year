import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flutter/material.dart';

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
              title: const Text('Exit Survey'),
            ),
            body: Container(
              
            ),
          );
        });
  }
}
