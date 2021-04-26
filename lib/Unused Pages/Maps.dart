// import 'dart:convert';
// // import 'dart:js';
// // import 'package:google_maps_webservice/places.dart' as MapsWebservice;
// // import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../Order/Address.dart';
// import '../Order/Service Provider List.dart';
// import '../model/app_state.dart';
// import '../Requests/Google Maps requests.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class FlutterMap extends StatefulWidget {
//   @override
//   _FlutterMapState createState() => _FlutterMapState();
// }

// class _FlutterMapState extends State<FlutterMap> {
//   GoogleMapController mapController;
//   GoogleMapsServices _googleMapsServices = GoogleMapsServices();
//   TextEditingController pickupLocationController = TextEditingController();
//   TextEditingController dropLocationController = TextEditingController();
//   static LatLng _initialPosition = LatLng(20.5937, 78.9629);
//   LatLng _lastPosition = _initialPosition;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polyLines = {};
//   var webLocation;
//   bool route = false;
//   double lat = 0;
//   double lng = 0;

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   // static Future<void> pop({bool animated}) async {
//   //   await SystemChannels.platform
//   //       .invokeMethod<void>('SystemNavigator.pop', animated);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     FocusScopeNode currentFocus = FocusScope.of(context);
//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }
//     return Scaffold(
//         // floatingActionButton:  Positioned(
//         //         child: FloatingActionButton(
//         //       onPressed: _onAddMarkerPressed,
//         //       child: Icon(Icons.gps_fixed_rounded),
//         //       tooltip: "Add Marker",
//         //     )),

//         body: SafeArea(
//       child: _initialPosition == null
//           ? Container(
//               child: Center(child: CircularProgressIndicator()),
//             )
//           : Stack(children: [
//               Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: GoogleMap(
//                         initialCameraPosition:
//                             CameraPosition(target: _initialPosition, zoom: 5),
//                         onMapCreated: onCreated,
//                         myLocationEnabled: true,
//                         myLocationButtonEnabled: true,
//                         zoomControlsEnabled: false,
//                         compassEnabled: true,
//                         markers: _markers,
//                         onCameraMove: _onCameraMove,
//                         polylines: _polyLines,
//                       ),
//                     ),
//                   ),
//                   Container(
//                       color: Colors.transparent,
//                       padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
//                       child: SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: Color(0xFFf9a825), // background
//                             onPrimary: Colors.white, // foreground
//                           ),
//                           onPressed: pickupLocationController.text.isEmpty &&
//                                   dropLocationController.text.isEmpty
//                               ? null
//                               : () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ServiceProviderList()),
//                                   );
//                                 },
//                           child: Text(
//                             "Next",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//               Positioned(
//                 top: 60.0,
//                 right: 15.0,
//                 left: 15.0,
//                 child: Card(
//                   elevation: 5,
//                   color: Colors.white,
//                   child: new TextFormField(
//                     // focusNode: new AlwaysDisabledFocusNode(),
//                     textInputAction: TextInputAction.go,
//                     onFieldSubmitted: (value) {
//                       sendPickupRequest(value);
//                     },
//                     controller: pickupLocationController,
//                     // onTap: () async {
//                     //   MapsWebservice.Prediction p =
//                     //       await PlacesAutocomplete.show(
//                     //           mode: Mode.overlay,
//                     //           context: context,
//                     //           apiKey: "AIzaSyDlJrWqrlvEDlvXw9cFtvoxR3oKqS55M6k",
//                     //           language: "en",
//                     //           components: [
//                     //         MapsWebservice.Component(
//                     //             MapsWebservice.Component.country, "in")
//                     //       ]);
//                     //   if (p != null) {
//                     //     setState(() {
//                     //       pickupLocationController.text = p.description;
//                     //       print(p.placeId);
//                     //     });
//                     //   }
//                     // },
//                     keyboardType: TextInputType.text,
//                     decoration: new InputDecoration(
//                       isDense: true, // Added this
//                       contentPadding: EdgeInsets.all(15),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: Color(0xFF2821B5),
//                         ),
//                       ),

//                       // border: new OutlineInputBorder(
//                       //     borderSide: new BorderSide(color: Colors.grey)),
//                       prefixIcon: Icon(
//                         Icons.location_on,
//                         color: Colors.black,
//                       ),
//                       hintText: "pickup location",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 120.0,
//                 right: 15.0,
//                 left: 15.0,
//                 child: Card(
//                   elevation: 5,
//                   color: Colors.white,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: new TextFormField(
//                           controller: dropLocationController,
//                           // onTap: () async {
//                           //   MapsWebservice.Prediction p =
//                           //       await PlacesAutocomplete.show(
//                           //           mode: Mode.overlay,
//                           //           context: context,
//                           //           apiKey:
//                           //               "AIzaSyDlJrWqrlvEDlvXw9cFtvoxR3oKqS55M6k",
//                           //           language: "en",
//                           //           components: [
//                           //         MapsWebservice.Component(
//                           //             MapsWebservice.Component.country, "in")
//                           //       ]);
//                           //   if (p != null) {
//                           //     setState(() {
//                           //       dropLocationController.text = p.description;
//                           //     });
//                           //   }
//                           // },
//                           // focusNode: new AlwaysDisabledFocusNode(),
//                           textInputAction: TextInputAction.go,
//                           onFieldSubmitted: (value) {},
//                           keyboardType: TextInputType.text,
//                           decoration: new InputDecoration(
//                             isDense: true, // Added this
//                             contentPadding: EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4)),
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color(0xFF2821B5),
//                               ),
//                             ),

//                             prefixIcon: Icon(
//                               Icons.local_taxi,
//                               color: Colors.black,
//                             ),
//                             hintText: "drop location",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 60,
//                         child: MaterialButton(
//                             onPressed: () {
//                               if (!currentFocus.hasPrimaryFocus) {
//                                 currentFocus.unfocus();
//                               }
//                               sendPickupRequest(pickupLocationController.text);
//                               sendDropRequest(dropLocationController.text);
//                             },
//                             child: Icon(Icons.search)),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               route == true
//                   ? Positioned(
//                       bottom: 100,
//                       right: 20,
//                       child: FloatingActionButton(
//                         onPressed: () {
//                           setState(() {
//                             route = false;
//                           });
//                           clearMap();
//                         },
//                         child: Icon(Icons.clear),
//                       ),
//                     )
//                   : Container()
//             ]),
//     ));
//   }

//   void onCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     setState(() {
//       _lastPosition = position.target;
//     });
//   }

//   void _addMarker(LatLng location, String address) {
//     setState(() {
//       _markers.add(Marker(
//           markerId: MarkerId(_lastPosition.toString()),
//           position: location,
//           infoWindow: InfoWindow(title: address, snippet: "Drop Location"),
//           icon: BitmapDescriptor.defaultMarker));
//     });
//   }

//   void createRoute(String encodedPoly) {
//     setState(() {
//       route = true;
//       _polyLines.add(Polyline(
//           polylineId: PolylineId(_lastPosition.toString()),
//           width: 2,
//           color: Color(0xFF3f51b5),
//           points: convertToLatLng(decodePoly(encodedPoly))));
//     });
//   }

// // will convert list of double into LatLng
//   List<LatLng> convertToLatLng(List points) {
//     List<LatLng> result = <LatLng>[];
//     for (int i = 0; i < points.length; i++) {
//       if (i % 2 != 0) {
//         result.add(LatLng(points[i - 1], points[i]));
//       }
//     }
//     return result;
//   }

//   List decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = [];
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
//     // repeating until all attributes are decoded
//     do {
//       var shift = 0;
//       int result = 0;

//       // for decoding value of one attribute
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//       /* if value is negetive then bitwise not the value */
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);

// /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

//     print(lList.toString());

//     return lList;
//   }

//   void clearMap() {
//     setState(() {
//       _markers = {};
//       _polyLines = {};
//     });
//   }

//   void sendPickupRequest(String intededLocation) async {
//     if (kIsWeb == true) {
//       // await getCurrentPosition(allowInterop((pos) {
//       //   getAddress() async {
//       //     var url = Uri.https('maps.googleapis.com', "/maps/api/geocode/json", {
//       //       "address": "$intededLocation",
//       //       "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//       //     });
//       //     var response = await http.get(url);
//       //     print(url);
//       //     Map values = jsonDecode(response.body);
//       //     double lat = values["results"][0]["geometry"]["location"]["lat"];
//       //     double lng = values["results"][0]["geometry"]["location"]["lng"];
//       //     LatLng destination = LatLng(lat, lng);
//       //     setState(() {
//       //       _initialPosition = destination;
//       //     });
//       //     try {
//       //       _addMarker(destination, intededLocation);
//       //     } catch (e) {
//       //       print("errror marking");
//       //     }
//       //   }

//       //   getAddress();
//       // }));
//     } else {
//       List<Location> location = await locationFromAddress(intededLocation);
//       double latitude = location[0].latitude;
//       double longitude = location[0].longitude;
//       print("location is ${location[0].latitude}");
//       LatLng pickup = LatLng(latitude, longitude);
//       setState(() {
//         _initialPosition = LatLng(latitude, longitude);
//       });
//       _addMarker(pickup, intededLocation);
//     }
//   }

//   void sendDropRequest(String intededLocation) async {
//     if (kIsWeb == true) {
//       // await getCurrentPosition(allowInterop((pos) {
//       //   getAddress() async {
//       //     var url = Uri.https('maps.googleapis.com', "/maps/api/geocode/json", {
//       //       "address": "$intededLocation",
//       //       "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//       //     });
//       //     var response = await http.get(url);
//       //     print(url);

//       //     Map values = jsonDecode(response.body);
//       //     double lat = values["results"][0]["geometry"]["location"]["lat"];
//       //     double lng = values["results"][0]["geometry"]["location"]["lng"];
//       //     LatLng destination = LatLng(lat, lng);
//       //     try {
//       //       _addMarker(destination, intededLocation);
//       //     } catch (e) {
//       //       print("errror marking");
//       //     }
//       //     print(_initialPosition);
//       //     String route = await _googleMapsServices.getRouteCoordinates(
//       //         _initialPosition, destination);
//       //     print("object1");
//       //     createRoute(route);
//       //     print(lat);
//       //     print(route);
//       //   }

//       //   getAddress();
//       // }));
//     } else {
//       List<Location> location = await locationFromAddress(intededLocation);
//       double latitude = location[0].latitude;
//       double longitude = location[0].longitude;
//       print("location is ${location[0].latitude}");
//       LatLng destination = LatLng(latitude, longitude);
//       _addMarker(destination, intededLocation);
//       String route = await _googleMapsServices.getRouteCoordinates(
//           _initialPosition, destination);
//       print(route);
//       print(location);
//       createRoute(route);
//     }
//   }

//   void _getUserLocation() async {
//     if (kIsWeb == true) {
//       // await getCurrentPosition(allowInterop((pos) {
//       //   setState(() {
//       //     _initialPosition = LatLng(pos.coords.latitude, pos.coords.longitude);
//       //   });
//       //   getAddress() async {
//       //     var url = Uri.https('maps.googleapis.com', "/maps/api/geocode/json", {
//       //       "latlng": "${pos.coords.latitude},${pos.coords.longitude}",
//       //       "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//       //     });
//       //     var response = await http.get(url);
//       //     print(url);
//       //     print("$lat,$lng");
//       //     Map values = jsonDecode(response.body);
//       //     List tempAdd = [];
//       //     for (var i = 0;
//       //         i < values["results"][0]["address_components"].length;
//       //         i++) {
//       //       tempAdd.add(
//       //           values["results"][0]["address_components"][i]['long_name']);
//       //     }
//       //     String address = tempAdd.join(',');
//       //     print(address);
//       //     pickupLocationController.text = address;
//       //   }
//       //   getAddress();
//       // }));
//     } else {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemark =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       setState(() {
//         _initialPosition = LatLng(position.latitude, position.longitude);
//         pickupLocationController.text =
//             "${placemark[0].name}, ${placemark[0].subAdministrativeArea}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}";
//       });
//       print(placemark[0]);
//     }
//   }
// }
