import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/Worker/worker.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

String getcity = "Morena";
String? temp;
String? hum;
String? air_speed;
String? Main;
String? des;
String? icon;

class _LoadingState extends State<Loading> {
  void startApp() async {
    worker instance = worker(location: getcity);
    await instance.getData();

    temp = instance.temp;
    air_speed = instance.air_speed;
    hum = instance.humidity;
    Main = instance.main;
    des = instance.description;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        '/second',
        arguments: {
          "temp_value": temp,
          "hum_value": hum,
          "main_value": Main,
          "air_speed_value": air_speed,
          "desription_value": des,
          "icon_value": icon,
        },
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map search = ModalRoute.of(context)!.settings.arguments as Map;
    
    if(search?.isNotEmpty ?? false){
      getcity = search['searchText'];
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/weather_logo.png",
                  height: 120,
                  width: 120,
                ),
                Text("Weather App",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Made by Ranshu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                ),
                SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
