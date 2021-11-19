import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      LoginView.tag: const LoginView(),
      AppAccessView.tag: const AppAccessView(),
    };
