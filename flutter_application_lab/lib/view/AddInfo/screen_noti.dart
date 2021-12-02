import 'package:flutter/material.dart';
import 'package:flutter_application_lab/view/Dashboard/dashboard_view.dart';
import 'package:get/get.dart';

class ScreenNoti extends GetMaterialApp  {
  const ScreenNoti({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
            child: Column(
              children: <Widget> [
               Row(
                    children: const <Widget> [
                      Text('Happy for your post. Thanks you!'),
                    ],
                ),  
                 Row(
                    children:  <Widget> [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context)
    .pushNamedAndRemoveUntil('/DashboardPage', (Route<dynamic> route) => false), 
                        child: const Text('Back Home Page')
                        )
                    ],
                ),  
              ]
                
              ),
            ),
          ),

    );
  }
}