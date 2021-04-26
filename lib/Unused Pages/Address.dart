// import 'dart:convert';
// import 'dart:js';

// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dropdown/flutter_dropdown.dart';
// // import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_webservice/places.dart';

// import 'package:packers/Order/Service%20Provider%20List.dart';
// import 'package:packers/Unused%20Pages/loc.dart';
// import 'package:packers/model/app_state.dart';
// import 'package:packers/order/Additional Services.dart';
// import 'package:http/http.dart' as http;

// import '../redux/actions.dart';

// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }

// class Address extends StatefulWidget {
//   @override
//   _AddressState createState() => _AddressState();
// }

// class _AddressState extends State<Address> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
//         child: SizedBox(
//           height: 50,
//           width: double.infinity,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color(0xFFf9a825), // background
//               onPrimary: Colors.white, // foreground
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ServiceProviderList()),
//               );
//             },
//             child: Text(
//               "Next",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "Packers & Movers",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SingleChildScrollView(child: AddressWidget()),
//     );
//   }
// }

// class AddressWidget extends StatefulWidget {
//   @override
//   _AddressWidgetState createState() => _AddressWidgetState();
// }

// class _AddressWidgetState extends State<AddressWidget> {
//   @override

//   var pickupData;
//   List<String> pickupOptions = [];
//   var dropData;
//   List<String> dropOptions = [];

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       child: StoreConnector<AppState, AppState>(
//           converter: (store) => store.state,
//           builder: (context, state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//               ],
//             );
//           }),
//     );
//   }

//   void _getUserLocation() async {
//     if (kIsWeb == true) {
//       await getCurrentPosition(allowInterop((pos) {
//         setState(() {
//           // _initialPosition = LatLng(pos.coords.latitude, pos.coords.longitude);
//         });
//         getAddress() async {
//           var url = Uri.https('maps.googleapis.com', "/maps/api/geocode/json", {
//             "latlng": "${pos.coords.latitude},${pos.coords.longitude}",
//             "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//           });
//           var response = await http.get(url);
//           print(url);
//           // print("$lat,$lng");
//           Map values = jsonDecode(response.body);
//           List tempAdd = [];
//           for (var i = 0;
//               i < values["results"][0]["address_components"].length;
//               i++) {
//             tempAdd.add(
//                 values["results"][0]["address_components"][i]['long_name']);
//           }
//           String address = tempAdd.join(',');
//           print(address);
//           pickupAddress.text = address;
//         }

//         getAddress();
//       }));
//     } else {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemark =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       setState(() {
//         // _initialPosition = LatLng(position.latitude, position.longitude);
//         dropAddress.text =
//             "${placemark[0].name}, ${placemark[0].subAdministrativeArea}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}";
//       });
//       print(placemark[0]);
//     }
//   }
// }

//  // SizedBox(
//                 //   height: 10,
//                 // ),
//                 // Row(
//                 //   children: [
//                 //     Expanded(
//                 //         child: TextFormField(
//                 //       keyboardType: TextInputType.number,
//                 //       maxLength: 6,
//                 //       textInputAction: TextInputAction.next,
//                 //       controller: pickupAddress,
//                 //       onChanged: (pin) async {
//                 //         var pickupPin = int.tryParse(pin);
//                 //         var count = 0, temp = pickupPin;
//                 //         while (temp > 0) {
//                 //           count++;
//                 //           temp = (temp / 10).floor();
//                 //         }
//                 //         print(count);
//                 //         setState(() {
//                 //           pickupOptions = [];
//                 //         });
//                 //         if (count == 6) {
//                 //           StoreProvider.of<AppState>(context)
//                 //               .dispatch(PickupPin(pin));
//                 //           getPinData() async {
//                 //             var response = await http.get(Uri.https(
//                 //                 "api.postalpincode.in", "/pincode/$pin"));
//                 //             var data = json.decode(response.body);
//                 //             setState(() {
//                 //               pickupOptions = [];
//                 //             });
//                 //             for (int i = 0;
//                 //                 i < data[0]["PostOffice"].length;
//                 //                 i++) {
//                 //               pickupOptions
//                 //                   .add(data[0]["PostOffice"][i]["Name"]);
//                 //             }

//                 //             setState(() {
//                 //               pickupData = data[0]["PostOffice"];
//                 //               pickupOptions = pickupOptions;
//                 //             });
//                 //             print(pickupOptions);
//                 //             print(pickupData);
//                 //             StoreProvider.of<AppState>(context).dispatch(
//                 //                 PickupArea(data[0]["PostOffice"][0]));
//                 //           }

//                 //           getPinData();
//                 //         }
//                 //       },
//                 //       decoration: new InputDecoration(
//                 //         counterText: "",
//                 //         helperText: pickupData != null
//                 //             ? "${pickupData[0]["District"]}, ${pickupData[0]["State"]}"
//                 //             : "",
//                 //         isDense: true, // Added this
//                 //         contentPadding: EdgeInsets.all(15),
//                 //         focusedBorder: OutlineInputBorder(
//                 //           borderRadius:
//                 //               BorderRadius.all(Radius.circular(4)),
//                 //           borderSide: BorderSide(
//                 //             width: 1,
//                 //             color: Color(0xFF2821B5),
//                 //           ),
//                 //         ),
//                 //         border: new OutlineInputBorder(
//                 //             borderSide: new BorderSide(color: Colors.grey)),
//                 //         labelText: 'Zip Code',
//                 //       ),
//                 //     )),
//                 //     SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     if (pickupOptions.length != 0)
//                 //       Column(
//                 //         children: [
//                 //           Container(
//                 //             padding: EdgeInsets.only(left: 5),
//                 //             decoration: BoxDecoration(
//                 //               borderRadius: BorderRadius.circular(5.0),
//                 //               border: Border.all(
//                 //                   color: Colors.grey,
//                 //                   style: BorderStyle.solid,
//                 //                   width: 0.80),
//                 //             ),
//                 //             child: DropDown(
//                 //               showUnderline: false,
//                 //               items: pickupOptions,
//                 //               hint: Text("Select Pickup Area"),
//                 //               onChanged: print,
//                 //             ),
//                 //           ),
//                 //           SizedBox(
//                 //             height: 22,
//                 //           )
//                 //         ],
//                 //       )
//                 //   ],
//                 // ),
//                 // SizedBox(height: 30),
//                 // Text(
//                 //   "Drop Address",
//                 //   style:
//                 //       TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 // ),
//                 // SizedBox(
//                 //   height: 15,
//                 // ),
