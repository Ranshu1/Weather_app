// import 'dart:js'; 

import 'package:flutter/material.dart';
import 'package:weather/Activites/home.dart';
import 'package:weather/Activites/loading.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
    initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) =>  Loading(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/second': (context) =>  Home(),
    '/loading' : (context) => Loading()
  },
  ));
}
