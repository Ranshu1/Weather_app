import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/screens/homeScreen.dart';
import 'package:weatherapp_starter_project/utils/colors.dart';

class CurrentWeatherWidget extends StatefulWidget {
  // final WeatherDataCurrent weatherDataCurrent;
  final String loc;
  const CurrentWeatherWidget({
    Key? key,
    required this.loc,
  }) : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

String City = "";
int temp = 0;
String hum = "";

String wind_speed = "";
String Main = "";
String des = "";
String icon = "04d";
String date = DateFormat("yMMMMd").format(DateTime.now());
String clouds = "";
int sunrise = 0;
int sunset = 0;

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    startApp(globalController.getLatitue().value,
        globalController.getLongitute().value);
    super.initState();
  }

  void startApp(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      City = widget.loc == "" ? place.locality! : widget.loc;
    });
    worker instance = worker(location: City);
    await instance.getData();
    setState(() {});

    temp = instance.temp as int;
    wind_speed = instance.wind_speed as String;
    hum = instance.humidity as String;
    Main = instance.main as String;
    des = instance.description as String;
    icon = instance.icon as String;
    clouds = instance.cloud as String;
    sunrise = instance.sunrise as int;
    sunset = instance.sunset as int;
  }

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp*1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          height: 55,
          child: TextField(
            // cursorHeight: 10,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(location: searchController.text.trim())));
            },
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                hintText: 'Enter City',
                hintStyle: const TextStyle(color: CustomColors.textColorsBlack),
                prefixIcon: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(location: searchController.text)));
                    },
                    child: const Icon(Icons.search))),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        headerWidget(),
        const SizedBox(
          height: 110,
        ),
        temperatureWidget(),
        const SizedBox(
          height: 20,
        ),
        showSunriseSunset(),
        const SizedBox(height: 30,),
        currentWeatherMoreInformationWidget(),
        const SizedBox(height : 150 ),
        const Text("This app is made by Ranshu. Thank you for using this", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blue)),
        const SizedBox(height: 30,)
      ],
    );
  }

  Widget currentWeatherMoreInformationWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/humidity.png"),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${wind_speed}km/h',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '$clouds%',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${hum}km/h',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget temperatureWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/$icon.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '$temp°',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 68,
                      color: CustomColors.textColorsBlack)),
              TextSpan(
                  text: des,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey))
            ],
          ),
        )
      ],
    );
  }

  Widget headerWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            City,
            style: const TextStyle(fontSize: 35, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
          ),
        )
      ],
    );
  }

  Widget showSunriseSunset() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              const Text("sunrise = ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              Text(getTime(sunrise), style:const  TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            ],
          )),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              const Text("sunset = ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              Text(getTime(sunset), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            ],
          )),
      ],
    );
  }
}
