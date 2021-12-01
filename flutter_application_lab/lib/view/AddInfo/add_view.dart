import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/add_controller.dart';
import 'add_info.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddInfomation(),
    );
  }
}