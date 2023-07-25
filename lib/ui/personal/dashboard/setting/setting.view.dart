import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/setting/setting.model.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  static String tag = 'setting-view';

  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<SettingModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    model.changeDate(const Locale('en')); // Change date to English
                  },
                  child: const Text('English Date'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    model.changeDate(const Locale('ne')); // Change date to Nepali
                  },
                  child: const Text('Nepali Date'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
