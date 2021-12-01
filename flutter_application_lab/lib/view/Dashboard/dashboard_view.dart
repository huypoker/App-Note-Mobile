import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lab/view/Homepage/home_page.dart';
import 'package:flutter_application_lab/view/Search/search_view.dart';
import 'package:get/get.dart';
import '../../Controller/dashboard_controller.dart';
import '../AddInfo/add_info.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller){
      return Scaffold(
      body: SafeArea(
         child: IndexedStack(
           index: controller.tabIndex,
           children:[
            HomeView(),
            const AddInfomation(),
            const SearchView(),
           ]
         ),
      ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.ChangeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.create,
                label: 'Create'
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.search,
                label: 'Search'
              ),
            ],
          ),
        );
      }
    );
  }
  _bottomNavigationBarItem({IconData? icon, String? label}){
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      );
      
  }
}
