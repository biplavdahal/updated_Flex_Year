import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/material.dart';
import '../../../widgets/fy_input_field.widget.dart';
import 'change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  static String tag = "change-password-view";

  @override
  Widget build(BuildContext context) {
    return View<ChangePasswordViewModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  FYInputField(
                    title: '',
                    label: "Old Pasword",
                    controller: model.oldPasswordController,
                  ),
                  const SizedBox(height: 10),
                  FYInputField(
                    title: '',
                    label: "New Password",
                    controller: model.newPasswordController,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 10),
                  FYInputField(
                    title: '',
                    label: "Confirm Password",
                    controller: model.confirmPasswordController,
                    validator: (confirm) => Validators.validateConfirmPassword(
                        confirm, model.newPasswordController.text),
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              onChanged: model.onSetNewPasswordPressed,
            ),
          ),
        );
      },
    );
  }
}
