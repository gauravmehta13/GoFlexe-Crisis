// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:grouped_list/grouped_list.dart';
// import '../Appbar.dart';
// import '../Fade Route.dart';
// import '../model/app_state.dart';
// import 'package:intl/intl.dart';

// import 'Order Successful.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

// class OrderSummary extends StatefulWidget {
//   @override
//   _OrderSummaryState createState() => _OrderSummaryState();
// }

// class _OrderSummaryState extends State<OrderSummary> {
//   List<dynamic> items = [];

//   var dio = Dio();
//   bool loading = false;
//   int totalAmount = 0;
//   DateTime now = new DateTime.now();
//   TimeOfDay time = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AppState>(
//         converter: (store) => store.state,
//         onInit: (store) {
//           print(store.state.spId);
//           items = store.state.additionalItems;
//           totalAmount = int.parse(store.state.price);
//           if (store.state.singleServices != null) {
//             for (var i = 0; i < store.state.singleServices.length; i++) {
//               if (store.state.singleServices[i]["selected"] == true) {
//                 totalAmount = totalAmount +
//                     int.parse(store
//                         .state.singleServices[i]["selectionDetails"]["newPrice"]
//                         .toString());
//               }
//             }
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//               bottomNavigationBar: Container(
//                 padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Color(0xFFf9a825), // background
//                       onPrimary: Colors.white, // foreground
//                     ),
//                     onPressed: () async {
//                       setState(() {
//                         loading = true;
//                       });
//                       try {
//                         print(items);
//                         final response = await dio.post(
//                             'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=PAM01&usecase=customerOrder',
//                             data: {
//                               'order': {
//                                 "pickupCity": state.pickupCity,
//                                 "basicCharges": state.price,
//                                 "spId": state.spId,
//                                 "dropCity": state.dropCity,
//                                 "shiftType": state.shiftType,
//                                 "movementType":
//                                     state.movementType ?? 'Within City',
//                                 'customerEmail':
//                                     _auth.currentUser.uid.toString(),
//                                 'contactNo':
//                                     _auth.currentUser.phoneNumber.toString(),
//                                 "orderDate": now.toString(),
//                                 "orderTime": time.toString(),
//                                 'items': state.additionalItems,
//                                 "pickupAddress": state.pickupStreetAddress,
//                                 "pickupArea": state.pickupAddress,
//                                 "dropAddress": state.dropStreetAddress,
//                                 "dropArea": state.dropAddress,
//                                 "totalAmount": totalAmount,
//                                 "shiftDate": state.pickupDate,
//                                 "dropDate": state.dropDate,
//                                 "dropFloor": state.dropFloor,
//                                 "pickupFloor": state.pickupFloor,
//                                 "dropLift": state.dropLift,
//                                 "pickupLift": state.pickupLift,
//                                 'vehicles': state.vehicles,
//                                 "singleServices": state.singleServices
//                               }
//                             });
//                         print(response);
//                         if (response.statusCode == 200) {
//                           FirebaseAnalytics().logEvent(
//                               name: 'Placed_Order_Successfully',
//                               parameters: {'Description': 'Placed order'});
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             FadeRoute(page: OrderSuccessful()),
//                             (route) => false,
//                           );
//                         }
//                         setState(() {
//                           loading = false;
//                         });
//                       } catch (e) {
//                         print(e);
//                         setState(() {
//                           loading = false;
//                         });
//                       }
//                     },
//                     child: loading == true
//                         ? Center(
//                             child: LinearProgressIndicator(
//                               backgroundColor: Color(0xFF3f51b5),
//                               valueColor: AlwaysStoppedAnimation(
//                                 Color(0xFFf9a825),
//                               ),
//                             ),
//                           )
//                         : Row(
//                             children: [
//                               Text(
//                                 "₹ $totalAmount",
//                                 style: Theme.of(context).textTheme.subtitle2,
//                               ),
//                               Spacer(),
//                               Text(
//                                 "Place Order",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                   ),
//                 ),
//               ),
//               appBar: PreferredSize(
//                   preferredSize: Size(double.infinity, 60),
//                   child: MyAppBar(curStep: 6)),
//               body: SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Order Summary",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         child: Row(
//                           children: <Widget>[
//                             Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 14,
//                                   child: Icon(
//                                     Icons.location_city,
//                                     size: 15,
//                                   ),
//                                 ),
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(maxHeight: 30),
//                                   child: DottedLine(
//                                     direction: Axis.vertical,
//                                     lineLength: double.infinity,
//                                     lineThickness: 1.0,
//                                     dashLength: 4.0,
//                                     dashColor: Colors.black,
//                                     dashRadius: 0.0,
//                                     dashGapLength: 4.0,
//                                     dashGapColor: Colors.transparent,
//                                     dashGapRadius: 0.0,
//                                   ),
//                                 ),
//                                 CircleAvatar(
//                                   radius: 14,
//                                   child: Icon(
//                                     Icons.home_filled,
//                                     size: 15,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text("Pickup Address",
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 12)),
//                                   Text(
//                                       "${state.pickupStreetAddress ?? ""}, ${state.pickupAddress ?? ""}",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                       )),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Text("Drop Address",
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 12)),
//                                   Text(
//                                       state.dropAddress.isNotEmpty
//                                           ? "${state.dropStreetAddress ?? ""}, ${state.dropAddress ?? ""}"
//                                           : "Not Avaialable",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(10),
//                         child: Text("Order Details"),
//                         color: Colors.grey[300],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "Apartment Size",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   state.shiftType ?? "",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Shift Date",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   state.pickupDate != null
//                                       ? new DateFormat("EEE, d MMMM")
//                                               .format(DateTime.parse(
//                                                   state.pickupDate))
//                                               .toString() ??
//                                           "NA"
//                                       : "NA",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Drop Date",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   state.dropDate != null
//                                       ? new DateFormat("EEE, d MMMM")
//                                               .format(DateTime.parse(
//                                                   state.dropDate))
//                                               .toString() ??
//                                           "NA"
//                                       : "NA",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Service Provider",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   state.selectedServiceProvider ?? "",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(10),
//                         child: Text("Pricing Details"),
//                         color: Colors.grey[300],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "Basic Charges",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "₹ ${state.price}",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             if (state.singleServices != null)
//                               ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: state.singleServices.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return state.singleServices[index]
//                                                 ["selected"] ==
//                                             true
//                                         ? Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     state.singleServices[index]
//                                                         ["label"],
//                                                     style:
//                                                         TextStyle(fontSize: 12),
//                                                   ),
//                                                   Spacer(),
//                                                   Text(
//                                                     "₹ ${state.singleServices[index]["selectionDetails"]["newPrice"].toString()}",
//                                                     style:
//                                                         TextStyle(fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                             ],
//                                           )
//                                         : Container();
//                                   }),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: DottedLine(
//                           direction: Axis.horizontal,
//                           lineLength: double.infinity,
//                           lineThickness: 1.0,
//                           dashLength: 4.0,
//                           dashColor: Colors.black,
//                           dashRadius: 0.0,
//                           dashGapLength: 4.0,
//                           dashGapColor: Colors.transparent,
//                           dashGapRadius: 0.0,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Row(
//                           children: [
//                             Text(
//                               "Pay on Delivery",
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w600),
//                             ),
//                             Spacer(),
//                             Text(
//                               "Order Total",
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               "₹ $totalAmount",
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "*Order Acceptance may take upto 5 mins.",
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ListTileTheme(
//                         dense: true,
//                         child: ExpansionTile(
//                           collapsedBackgroundColor: Colors.grey[300],
//                           backgroundColor: Colors.grey[300],
//                           title: Text("Item List"),
//                           tilePadding: EdgeInsets.symmetric(horizontal: 10),
//                           children: [
//                             GroupedListView<dynamic, String>(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 elements: state.additionalItems,
//                                 groupBy: (element) => element['categoryName'],
//                                 groupComparator: (value1, value2) =>
//                                     value2.compareTo(value1),
//                                 // itemComparator: (item1, item2) =>
//                                 //     item2.name.compareTo(item1.name),
//                                 // optional
//                                 // useStickyGroupSeparators: true, // optional
//                                 // floatingHeader: true, // optional
//                                 order: GroupedListOrder.DESC,
//                                 groupSeparatorBuilder: (String value) => Card(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 5),
//                                         child: Text(
//                                           value,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                 itemBuilder: (c, element) {
//                                   return Container(
//                                     color: Colors.white,
//                                     margin: EdgeInsets.symmetric(
//                                       horizontal: 5,
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 5),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${element['itemName'] ?? ""} ( ${element['total'].toString() ?? ""} )",
//                                               style: TextStyle(
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ],
//                                         ),
//                                         // if (element['custom'].length != 0)
//                                         //   GridView.builder(
//                                         //       shrinkWrap: true,
//                                         //       gridDelegate:
//                                         //           new SliverGridDelegateWithFixedCrossAxisCount(
//                                         //         crossAxisCount: 4,
//                                         //         childAspectRatio: 6 / 1,
//                                         //       ),
//                                         //       itemCount:
//                                         //           element['custom'].length,
//                                         //       itemBuilder:
//                                         //           (BuildContext ctx, index) {
//                                         //         return Container(
//                                         //           alignment: Alignment.center,
//                                         //           child: Text(
//                                         //             "${element['custom'][index]['itemName'] ?? ""} ( ${element['custom'][index]['quantity'] ?? 0} )",
//                                         //             style: TextStyle(
//                                         //               fontSize: 10,
//                                         //             ),
//                                         //           ),
//                                         //         );
//                                         //       }),
//                                       ],
//                                     ),
//                                   );
//                                 })
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ));
//         });
//   }
// }
