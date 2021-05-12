// import 'dart:async';

// import 'package:crisis/data/Payment%20Modes%20List.dart';
// import 'package:crisis/model/app_state.dart';
// import 'package:crisis/model/place_search.dart';
// import 'package:crisis/redux/actions.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert' as convert;
// import '../Appbar.dart';
// import '../Constants.dart';
// import '../Fade Route.dart';
// import 'Order Summary.dart';

// class Address extends StatefulWidget {
//   @override
//   _AddressState createState() => _AddressState();
// }

// class _AddressState extends State<Address> {
//   final _formKey = GlobalKey<FormState>();
//   bool insurance = false;
//   var pickupArea = new TextEditingController();
//   var dropArea = new TextEditingController();
//   var pickupStreetAddress = new TextEditingController();
//   var dropStreetAddress = new TextEditingController();
//   int apiCalls = 0;
//   List<PlaceSearch> pickupSearchResults;
//   List<PlaceSearch> dropSearchResults;
//   String lat;
//   String lng;
//   String pickupPlaceId;
//   String dropPlaceId;
//   Timer _dropdebounce;
//   Timer _pickupdebounce;
//   var pickupAddress = new TextEditingController();
//   var dropAddress = new TextEditingController();
//   var dio = Dio();

//   List<PaymentMode> paymentModes;
//   PaymentMode selectedPaymentMode;
//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//     paymentModes = PaymentMode.getPaymentModes();
//   }

//   @override
//   void dispose() {
//     _pickupdebounce?.cancel();
//     _dropdebounce.cancel();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     List<Widget> radioListPaymentModes() {
//       List<Widget> widgets = [];
//       for (PaymentMode mode in paymentModes) {
//         widgets.add(Column(children: [
//           RadioListTile(
//             dense: true,
//             value: mode,
//             groupValue: selectedPaymentMode,
//             title: Text(mode.name),
//             subtitle: Text(mode.description),
//             onChanged: (currentPaymentMode) {
//               setState(() {});
//               print("Current PaymentMode ${currentPaymentMode.name}");
//               setPaymentMode(currentPaymentMode);
//             },
//             selected: selectedPaymentMode == mode,
//             activeColor: Color(0xFF3f51b5),
//           ),
//           Divider(),
//         ]));
//       }
//       return widgets;
//     }

//     return Scaffold(
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
//             onPressed: () async {
//               if (_formKey.currentState.validate()) {
//                 FirebaseAnalytics().logEvent(
//                     name: 'Order Summary Screen',
//                     parameters: {'Description': 'Went to Order Summary'});
//                 await StoreProvider.of<AppState>(context)
//                     .dispatch(PickupStreetAddress(pickupStreetAddress.text));
//                 await StoreProvider.of<AppState>(context)
//                     .dispatch(PickupAddress(pickupAddress.text));
//                 await StoreProvider.of<AppState>(context)
//                     .dispatch(DropAddress(dropAddress.text));
//                 await StoreProvider.of<AppState>(context)
//                     .dispatch(DropStreetAddress(dropStreetAddress.text));
//                 Navigator.push(
//                   context,
//                   FadeRoute(page: OrderSummary()),
//                 );
//               }
//             },
//             child: Text(
//               "Next",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),
//       ),
//       appBar: PreferredSize(
//           preferredSize: Size(double.infinity, 60),
//           child: MyAppBar(curStep: 5)),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: SafeArea(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               child: StoreConnector<AppState, AppState>(
//                   converter: (store) => store.state,
//                   onInit: (store) {
//                     print(store.state.additionalItems);
//                     pickupArea.text = store.state.pickupAddress ?? "";
//                     dropArea.text = store.state.dropAddress ?? "";
//                   },
//                   builder: (context, state) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         box20,
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Address Details",
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ),
//                               Divider(),
//                               Card(
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: double.infinity,
//                                         color: Colors.grey[300],
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 15),
//                                         child: Text(
//                                           "Pickup Address",
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.all(10),
//                                         child: Column(
//                                           children: [
//                                             C.box10,
//                                             TextFormField(
//                                               validator: (val) {
//                                                 if (val.isEmpty) {
//                                                   return "Required";
//                                                 }
//                                                 return null;
//                                               },
//                                               textInputAction:
//                                                   TextInputAction.next,
//                                               controller: pickupAddress,
//                                               onChanged: (value) {
//                                                 searchPickup(value);
//                                               },
//                                               decoration: new InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     EdgeInsets.all(15),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(4)),
//                                                   borderSide: BorderSide(
//                                                     width: 1,
//                                                     color: Color(0xFF2821B5),
//                                                   ),
//                                                 ),
//                                                 border: new OutlineInputBorder(
//                                                     borderSide: new BorderSide(
//                                                         color: Colors.grey)),
//                                                 labelText: 'Pickup location',
//                                               ),
//                                             ),
//                                             if (pickupSearchResults != null &&
//                                                 pickupSearchResults.length != 0)
//                                               Container(
//                                                 height: 200,
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount:
//                                                         pickupSearchResults
//                                                             .length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       return Container(
//                                                         decoration: new BoxDecoration(
//                                                             border: new Border(
//                                                                 bottom: new BorderSide(
//                                                                     color: Colors
//                                                                             .grey[
//                                                                         100]))),
//                                                         child: ListTile(
//                                                           dense: true,
//                                                           title: Text(
//                                                             pickupSearchResults[
//                                                                     index]
//                                                                 .description,
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black),
//                                                           ),
//                                                           onTap: () {
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .unfocus();
//                                                             setState(() {
//                                                               pickupAddress
//                                                                       .text =
//                                                                   pickupSearchResults[
//                                                                           index]
//                                                                       .description;

//                                                               pickupPlaceId =
//                                                                   pickupSearchResults[
//                                                                           index]
//                                                                       .placeId;
//                                                             });
//                                                             print(
//                                                                 pickupSearchResults[
//                                                                     index]);

//                                                             setState(() {
//                                                               pickupSearchResults =
//                                                                   null;
//                                                             });
//                                                           },
//                                                         ),
//                                                       );
//                                                     }),
//                                               ),
//                                             if (pickupAddress.text.isNotEmpty)
//                                               Column(
//                                                 children: [
//                                                   box20,
//                                                   TextFormField(
//                                                     controller:
//                                                         pickupStreetAddress,
//                                                     decoration:
//                                                         new InputDecoration(
//                                                       isDense: true,
//                                                       contentPadding:
//                                                           EdgeInsets.all(15),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     4)),
//                                                         borderSide: BorderSide(
//                                                           width: 1,
//                                                           color:
//                                                               Color(0xFF2821B5),
//                                                         ),
//                                                       ),
//                                                       border: new OutlineInputBorder(
//                                                           borderSide:
//                                                               new BorderSide(
//                                                                   color: Colors
//                                                                       .grey)),
//                                                       labelText:
//                                                           "Enter Street Address",
//                                                       hintText:
//                                                           'Flat, House No., Building, Company, Apartment',
//                                                     ),
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                     validator: (val) {
//                                                       if (val.isEmpty) {
//                                                         return "Required";
//                                                       }
//                                                       return null;
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             box10,
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),

//                               Divider(),
//                               Card(
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: double.infinity,
//                                         color: Colors.grey[300],
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 15),
//                                         child: Text(
//                                           "Drop Address",
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.all(10),
//                                         child: Column(
//                                           children: [
//                                             box10,
//                                             TextFormField(
//                                               controller: dropAddress,
//                                               onChanged: (value) async {
//                                                 searchdrop(value);
//                                               },
//                                               decoration: new InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     EdgeInsets.all(15),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(4)),
//                                                   borderSide: BorderSide(
//                                                     width: 1,
//                                                     color: Color(0xFF2821B5),
//                                                   ),
//                                                 ),
//                                                 border: new OutlineInputBorder(
//                                                     borderSide: new BorderSide(
//                                                         color: Colors.grey)),
//                                                 labelText: 'Drop location',
//                                               ),
//                                               textInputAction:
//                                                   TextInputAction.next,
//                                             ),
//                                             if (dropSearchResults != null &&
//                                                 dropSearchResults.length != 0)
//                                               Container(
//                                                 height: 200,
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount: dropSearchResults
//                                                         .length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       return Container(
//                                                         decoration: new BoxDecoration(
//                                                             border: new Border(
//                                                                 bottom: new BorderSide(
//                                                                     color: Colors
//                                                                             .grey[
//                                                                         100]))),
//                                                         child: ListTile(
//                                                           dense: true,
//                                                           title: Text(
//                                                             dropSearchResults[
//                                                                     index]
//                                                                 .description,
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black),
//                                                           ),
//                                                           onTap: () {
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .unfocus();
//                                                             setState(() {
//                                                               dropAddress.text =
//                                                                   dropSearchResults[
//                                                                           index]
//                                                                       .description;

//                                                               dropPlaceId =
//                                                                   dropSearchResults[
//                                                                           index]
//                                                                       .placeId;
//                                                             });
//                                                             print(
//                                                                 dropSearchResults[
//                                                                     index]);

//                                                             setState(() {
//                                                               dropSearchResults =
//                                                                   null;
//                                                             });
//                                                           },
//                                                         ),
//                                                       );
//                                                     }),
//                                               ),
//                                             if (dropAddress.text.isNotEmpty)
//                                               Column(
//                                                 children: [
//                                                   box20,
//                                                   TextFormField(
//                                                     controller:
//                                                         dropStreetAddress,
//                                                     decoration:
//                                                         new InputDecoration(
//                                                       isDense: true,
//                                                       contentPadding:
//                                                           EdgeInsets.all(15),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     4)),
//                                                         borderSide: BorderSide(
//                                                           width: 1,
//                                                           color:
//                                                               Color(0xFF2821B5),
//                                                         ),
//                                                       ),
//                                                       border: new OutlineInputBorder(
//                                                           borderSide:
//                                                               new BorderSide(
//                                                                   color: Colors
//                                                                       .grey)),
//                                                       labelText:
//                                                           "Enter Street Address",
//                                                       hintText:
//                                                           'Flat, House No., Building, Company, Apartment',
//                                                     ),
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                   ),
//                                                 ],
//                                               ),
//                                             box10,
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),

//                               // Text(
//                               //   "Select Payment Method",
//                               //   style: TextStyle(
//                               //       fontSize: 15, fontWeight: FontWeight.w600),
//                               // ),
//                               // Divider(),
//                               // Column(children: radioListPaymentModes()),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _getUserLocation() async {
//     if (kIsWeb == true) {
//       // await getCurrentPosition(allowInterop((pos) {
//       //   setState(() {
//       //     lat = pos.coords.latitude.toString();
//       //     lng = pos.coords.longitude.toString();
//       //     // _initialPosition = LatLng(pos.coords.latitude, pos.coords.longitude);
//       //   });
//       //   getAddress() async {
//       //     var url = Uri.https('maps.googleapis.com', "/maps/api/geocode/json", {
//       //       "latlng": "${pos.coords.latitude},${pos.coords.longitude}",
//       //       "key": "AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U"
//       //     });
//       //     var response = await http.get(url);
//       //     print(url);
//       //     // print("$lat,$lng");
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
//       //     setState(() {
//       //       pickupAddress.text = address;
//       //     });
//       //   }

//       //   getAddress();
//       // }));
//     } else {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemark =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       setState(() {
//         // _initialPosition = LatLng(position.latitude, position.longitude);
//         lat = position.latitude.toString();
//         lng = position.longitude.toString();
//         pickupAddress.text =
//             "${placemark[0].name}, ${placemark[0].subAdministrativeArea}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}";
//       });
//       print(placemark[0]);
//     }
//   }

//   setPaymentMode(PaymentMode paymentMode) {
//     setState(() {
//       selectedPaymentMode = paymentMode;
//     });
//   }

//   postLocation() async {
//     print(dropPlaceId);
//     print(pickupPlaceId);
//     print(lat);
//     final response = await dio.post(
//         'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/distance',
//         data: {
//           "pickupLocation": {
//             "type": pickupPlaceId == null ? "latlng" : "placeId",
//             "placeId": pickupPlaceId,
//             "lat": lat,
//             "lng": lng
//           },
//           "dropLocation": {"placeId": dropPlaceId}
//         });
//     print(response);
//   }

//   Future<List<PlaceSearch>> getAutocomplete(String search) async {
//     if (kIsWeb == true) {
//       final response = await dio.get(
//         'https://safe-ravine-62753.herokuapp.com/https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U',
//       );
//       print(response);
//       var json = convert.jsonDecode(response.toString());
//       var jsonResults = json['predictions'] as List;
//       return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
//     } else {
//       setState(() {
//         apiCalls = apiCalls + 1;
//       });
//       final response = await dio.get(
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=AIzaSyD28o_G3q1njuEc-LF3KT7dCMOT3Dj_Y7U',
//         options: Options(
//           headers: {
//             "Access-Control-Allow-Origin": "*",
//           },
//         ),
//       );
//       print(response);
//       var json = convert.jsonDecode(response.toString());
//       var jsonResults = json['predictions'] as List;
//       return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
//     }
//   }

//   searchPickup(String searchTerm) async {
//     if (_pickupdebounce?.isActive ?? false) _pickupdebounce.cancel();
//     _pickupdebounce = Timer(const Duration(milliseconds: 500), () async {
//       pickupSearchResults = await getAutocomplete(searchTerm);
//       setState(() {
//         pickupSearchResults = pickupSearchResults;
//       });
//       print(pickupSearchResults);
//     });
//   }

//   searchdrop(String searchTerm) async {
//     if (_dropdebounce?.isActive ?? false) _dropdebounce.cancel();
//     _dropdebounce = Timer(const Duration(milliseconds: 500), () async {
//       dropSearchResults = await getAutocomplete(searchTerm);
//       setState(() {
//         dropSearchResults = dropSearchResults;
//       });
//       print(dropSearchResults);
//     });
//   }
// }
