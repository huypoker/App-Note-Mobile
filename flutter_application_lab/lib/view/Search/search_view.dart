import 'package:flutter/material.dart';
import 'package:flutter_application_lab/Controller/search_controller.dart';
import 'package:get/get.dart';
import 'search_info.dart';

class SearchView extends GetView<SeachController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchInfo(),
    );
  }
}