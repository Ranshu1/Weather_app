import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxBool _isLoading = true.obs;
  RxDouble _latitue = 0.0.obs;
  RxDouble _longitute = 0.0.obs;

  //intance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitue() => _latitue;
  RxDouble getLongitute() => _longitute;


  @override
  void onInit() {
    // TODO: implement onInit
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location is not enabled");
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      //request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Future.error("Permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update our longitude and latitude
      _longitute.value = value.longitude;
      _latitue.value = value.latitude;

      _isLoading.value = false;
    });
  }
}
