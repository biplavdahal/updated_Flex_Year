import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';
import 'package:flex_year_tablet/ui/profile/profile.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      LoginView.tag: const LoginView(),
      AppAccessView.tag: const AppAccessView(),
      DashboardView.tag: const DashboardView(),
      ProfileView.tag: const ProfileView(),
    };
