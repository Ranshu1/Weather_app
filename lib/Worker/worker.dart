import 'dart:convert';
import 'package:http/http.dart' as http;

class worker {
  String? location;

  //constructor
  worker({this.location}) {
    location = this.location;
  }

  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=e5b8ebf903205641ef1cd18fb0ac3a17'));
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidity
      Map temp_data = data['main'];
      String gethumidity = temp_data['humidity'].toString();
      double gettemp = temp_data['temp'] - 273.15;

      //Getting Air_speed
      Map wind = data['wind'];
      double getair_speed = wind['speed'] / 0.2777777777778;
      //Getting description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];
       
      // print(icon);

      //Assigning values
      temp = gettemp.toString();
      humidity = gethumidity;
      air_speed = getair_speed.toString();
      description = getdesc;
      main = getmain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "04d";
    }
  }
}
