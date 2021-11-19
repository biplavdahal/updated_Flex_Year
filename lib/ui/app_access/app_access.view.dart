import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AppAccessView extends StatelessWidget {
  static String tag = 'app-access-view';

  const AppAccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AppAccessModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 64 + 50,
                  left: 64,
                  right: 64,
                  bottom: 64,
                ),
                color: AppColor.primary,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/flex_year_login_image.png',
                  width: 150,
                ),
              ),
              if (model.isLoading) const FYLinearLoader(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: model.appAccessFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Enter the assigned access key",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FYInputField(
                            label: "Enter app access",
                            controller: model.appAccessController,
                          ),
                          const SizedBox(height: 20),
                          FYPrimaryButton(
                            label: "Verify Key",
                            onPressed: model.isLoading
                                ? null
                                : model.onVerifyKeyPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
