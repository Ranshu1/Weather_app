import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weatherapp_starter_project/controller/global_controller.dart';

import '../widgets/currentWeatherWidget.dart';

class HomeScreen extends StatelessWidget {
   final String location;
   const HomeScreen(
    {
      required this.location,
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);
    return Scaffold(
      body: Obx(() => globalController.checkLoading().isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade200,
            ],)),
            child: 
              ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 25),
                CurrentWeatherWidget(
                  loc: location,
                )
              ],
            )
            ,
          )),
    );
  }
}
