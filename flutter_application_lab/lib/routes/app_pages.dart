import 'package:flutter_application_lab/Controller/dashboard_bling.dart';
import 'package:get/get.dart';


import '../view/Dashboard/dashboard_view.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}