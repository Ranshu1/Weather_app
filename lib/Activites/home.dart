import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/Activites/loading.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Morena",
      "Gwalior",
      "Indore",
      "Agra",
      "Bhind",
      "Bhopal",
      "Jaipur"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    // String temp = ((info['temp_value']).toString()).substring(0, 4);
    String tempp = ((info['temp_value']).toString());
    String air_speedd = ((info['air_speed']).toString());
    if (tempp == "NA") {
      print("NA");
    } else {
      tempp = ((info['temp_value']).toString()).substring(0, 4);
      air_speedd = ((info['air_speed_value']).toString()).substring(0, 4);
    }
    // print(icon);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Colors.red,
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: NewGradientAppBar(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 41, 77, 141), Colors.blue]))),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blueAccent,
                Colors.blue,
              ],
            )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.pushReplacementNamed(context, '/loading',
                                  arguments: {
                                    "searchText": searchController.text,
                                  });
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          )),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Any City Name"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Image.network(
                                "http://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$tempp", style: TextStyle(fontSize: 90.0)),
                                  Text("C", style: TextStyle(fontSize: 30.0)),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(WeatherIcons.day_windy),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("$air_speedd",
                              style: TextStyle(
                                  fontSize: 40.0, fontWeight: FontWeight.bold)),
                          Text("Km/hr")
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(WeatherIcons.humidity),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("$hum",
                              style: TextStyle(
                                  fontSize: 40.0, fontWeight: FontWeight.bold)),
                          Text(
                            "%",
                            style: TextStyle(fontSize: 30.0),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Ranshu"),
                      Text("Data Provided By Openweathermap.org")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
