import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.model.dart';
import 'package:flutter/material.dart';

class EnterPinView extends StatelessWidget {
  static String tag = 'enter-pin-view';

  const EnterPinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<EnterPinModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold();
      },
    );
  }
}
