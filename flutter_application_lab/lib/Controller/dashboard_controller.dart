import 'package:get/get.dart';

class DashboardController extends GetxController {
    var tabIndex = 0;
    // ignore: non_constant_identifier_names
    void ChangeTabIndex(int index) {
      tabIndex = index;
      update();
    }
}