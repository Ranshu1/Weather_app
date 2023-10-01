import 'dart:convert';
import 'package:http/http.dart' as http;

class worker {
  String? location;
  worker({this.location}) {
    location = this.location;
  }
  int? temp;
  String? humidity;
  String? wind_speed;
  String? icon;
  String? description;
  String? main;
  int? sunrise;
  int? sunset;
  String? cloud;
  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=e5b8ebf903205641ef1cd18fb0ac3a17&units=metric&exclude=minutely'));
      Map data = jsonDecode(response.body);

      //getting temp and humidity
      Map temp_data = data['main'];
      String gethumidity = temp_data['humidity'].toString();
      double gettemp = temp_data['temp'];

      //getting wind speed
      Map wind = data['wind'];
      double getair_speed = wind['speed'];

      //getting clouds percentage
      Map clouds = data['clouds'];
      num getCloud = clouds['all'];
      //getting description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];

      //getting sunrise and set
      Map sys = data['sys'];
      num getsunrise = sys['sunrise'];
      num getsunset = sys['sunset'];

      //Assigning values
      temp = gettemp.toInt().round();
      humidity = gethumidity;
      wind_speed = getair_speed.toString();
      description = getdesc;
      main = getmain_des;
      icon = weather_main_data["icon"].toString();
      cloud = getCloud.toString();
      sunrise = getsunrise.toInt();
      sunset = getsunset.toInt();
      print(sunset);
    } catch (e) {
      temp = 0;
      humidity = "NA";
      wind_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "04d";
      cloud = "0";
      sunrise = 0;
      sunset = 0;
    }
    // print(cloud);
  }
}
