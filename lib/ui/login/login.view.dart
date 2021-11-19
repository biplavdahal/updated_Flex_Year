import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/login/login.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_card.widget.dart';
import 'package:flex_year_tablet/widgets/fy_checkbox.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  static String tag = "login-view";

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<LoginModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                color: AppColor.primary,
              ),
              _logo(),
              _mainView(context, model),
            ],
          ),
        );
      },
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Image.asset(
            "assets/images/flex_year_login_image.png",
            width: 150,
          ),
        ),
      ),
    );
  }

  Widget _mainView(BuildContext context, LoginModel model) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: model.showLoginWithPin
            ? _loginWithPinView(context, model)
            : _loginWithUsernameAndPasswordView(context, model),
      ),
    );
  }

  Widget _loginWithUsernameAndPasswordView(
    BuildContext context,
    LoginModel model,
  ) {
    return FYCard(
      elevation: 10,
      child: Form(
        key: model.loginWithUsernamePasswordFormKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "Please enter your username and password",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FYInputField(
                  label: "Username",
                  controller: model.usernameController,
                ),
                const SizedBox(
                  height: 12,
                ),
                FYInputField(
                  label: "Password",
                  controller: model.passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                FYCheckbox(
                  value: model.rememberMe,
                  onChanged: (value) => model.rememberMe = value!,
                  label: "Remember me",
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FYPrimaryButton(
                        label: "Login",
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FYSecondaryButton(
                        label: "Pin Login",
                        onPressed: () {
                          model.showLoginWithPin = true;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginWithPinView(BuildContext context, LoginModel model) {
    return FYCard(
      elevation: 10,
      child: Form(
        key: model.loginWithPinFormKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Pin Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "Pin should contain atmost 6 characters",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FYInputField(
                  label: "Your Pin",
                  controller: model.pinController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FYPrimaryButton(
                        label: "Send",
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FYSecondaryButton(
                        label: "Login",
                        onPressed: () {
                          model.showLoginWithPin = false;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
