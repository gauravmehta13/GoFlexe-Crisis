// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class GoogleMapsServices {
//   Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
//     var url = Uri.https('maps.googleapis.com', "/maps/api/directions/json", {
//       "origin": "${l1.latitude},${l1.longitude}",
//       "destination": "${l2.latitude},${l2.longitude}",
//       "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//     });
//     var response = await http.get(url, headers: {
//       "Accept": "application/json",
//       "Access-Control-Allow-Origin": "*",
//       "Access-Control-Allow-Methods": 'GET',
//     });
//     print(response);
//     Map values = jsonDecode(response.body);
//     return values["routes"][0]["overview_polyline"]["points"];
//   }
// }
