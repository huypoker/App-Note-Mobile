import 'package:flutter_application_lab/Controller/add_controller.dart';
import 'package:flutter_application_lab/Controller/home_controller.dart';
import 'package:flutter_application_lab/Controller/search_controller.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddController>(() => AddController());
    Get.lazyPut<SeachController>(() => SeachController());
  }
}