
import 'package:flutter/material.dart';
import 'package:flutter_application_lab/routes/app_pages.dart';
import 'package:flutter_application_lab/routes/app_routes.dart';
import 'package:get/get.dart';
import 'Controller/auth_controller.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.DASHBOARD,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      
    );
  }
}

