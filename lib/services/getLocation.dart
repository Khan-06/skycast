import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  double? longitude;
  double? latitude;
 static const LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.low, distanceFilter: 100);

 Future<void> getLocation() async {
   try{
     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if(!serviceEnabled){
       return Future.error("Location services are disabled!");
     }

     LocationPermission permission = await Geolocator.checkPermission();
     if(permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if(permission == LocationPermission.denied){
         return Future.error("Permission Denied!");
       }
     }

     if(permission == LocationPermission.deniedForever){
       return Future.error("Permission Denied Forever!");
     }
     Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
     latitude = position.latitude;
     longitude = position.longitude;
   } catch (e){
     print("Error in GetLocation $e");
   }
 }
}