// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:countdown_flutter/countdown_flutter.dart';
// import '../../Constants.dart';
// import 'package:dotted_line/dotted_line.dart';

// class Notifications extends StatefulWidget {
//   @override
//   _NotificationsState createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   int notAvailable = 0;
//   int problemInPricing = 1;
//   int state = 2;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "GoFlexe",
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.notifications),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Notifications",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                     ),
//                     Spacer(),
//                     TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Mark as Read",
//                           style: TextStyle(color: C.primaryColor),
//                         ))
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//                 padding: EdgeInsets.only(top: 0),
//                 itemCount: 1,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.grey,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       elevation: 1.5,
//                       child: Container(
//                           height: 250,
//                           padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.truck,
//                                     size: 15,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'New Order Request',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.w600),
//                                   ),
//                                   Spacer(),
//                                   // CircularCountDownTimer(
//                                   //   duration: 300,
//                                   //   initialDuration: 0,
//                                   //   controller: CountDownController(),
//                                   //   width: 40,
//                                   //   height: 40,
//                                   //   ringColor: Colors.grey[300],
//                                   //   ringGradient: null,
//                                   //   fillColor: Colors.purpleAccent[100],
//                                   //   fillGradient: null,
//                                   //   backgroundColor: C.primaryColor,
//                                   //   backgroundGradient: null,
//                                   //   strokeWidth: 1,
//                                   //   strokeCap: StrokeCap.round,
//                                   //   textStyle: TextStyle(
//                                   //       fontSize: 10,
//                                   //       color: Colors.white,
//                                   //       fontWeight: FontWeight.bold),
//                                   //   textFormat: CountdownTextFormat.MM_SS,
//                                   //   isReverse: true,
//                                   //   isReverseAnimation: true,
//                                   //   isTimerTextShown: true,
//                                   //   autoStart: true,
//                                   //   onStart: () {
//                                   //     print('Countdown Started');
//                                   //   },
//                                   //   onComplete: () {
//                                   //     print('Countdown Ended');
//                                   //   },
//                                   // ),
//                                   Container(
//                                     color: C.primaryColor,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 5, vertical: 2),
//                                     child: CountdownFormatted(
//                                       onFinish: () {},
//                                       duration: Duration(minutes: 5),
//                                       builder:
//                                           (BuildContext ctx, String remaining) {
//                                         return Text(remaining,
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white,
//                                             )); // 01:00:00
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Shift Type :  ',
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.grey[700]),
//                                   ),
//                                   Text(
//                                     "1 BHK",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Icon(
//                                     Icons.info,
//                                     color: Colors.grey,
//                                     size: 12,
//                                   ),
//                                   Spacer(),
//                                   GestureDetector(
//                                       onTap: () {
//                                         showModalBottomSheet(
//                                             isScrollControlled: true,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                             ),
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return StatefulBuilder(
//                                                   builder: (context, setState) {
//                                                 return Container(
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height -
//                                                       200,
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child: ListView(
//                                                     children: [
//                                                       SizedBox(
//                                                         height: 20,
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text("Order Details",
//                                                               style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize: 20,
//                                                               )),
//                                                           Spacer(),
//                                                           GestureDetector(
//                                                               onTap: () {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: Icon(
//                                                                   Icons.close))
//                                                         ],
//                                                       ),
//                                                       Divider(
//                                                         color: Colors.grey,
//                                                       ),
//                                                       Container(
//                                                         child: Row(
//                                                           children: <Widget>[
//                                                             Column(
//                                                               children: [
//                                                                 CircleAvatar(
//                                                                   radius: 14,
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .location_city,
//                                                                     size: 15,
//                                                                   ),
//                                                                 ),
//                                                                 ConstrainedBox(
//                                                                   constraints:
//                                                                       BoxConstraints(
//                                                                           maxHeight:
//                                                                               30),
//                                                                   child:
//                                                                       DottedLine(
//                                                                     direction: Axis
//                                                                         .vertical,
//                                                                     lineLength:
//                                                                         double
//                                                                             .infinity,
//                                                                     lineThickness:
//                                                                         1.0,
//                                                                     dashLength:
//                                                                         4.0,
//                                                                     dashColor:
//                                                                         Colors
//                                                                             .black,
//                                                                     dashRadius:
//                                                                         0.0,
//                                                                     dashGapLength:
//                                                                         4.0,
//                                                                     dashGapColor:
//                                                                         Colors
//                                                                             .transparent,
//                                                                     dashGapRadius:
//                                                                         0.0,
//                                                                   ),
//                                                                 ),
//                                                                 CircleAvatar(
//                                                                   radius: 14,
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .home_filled,
//                                                                     size: 15,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               width: 20.0,
//                                                             ),
//                                                             Expanded(
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: <
//                                                                     Widget>[
//                                                                   Text(
//                                                                       "Pickup Address",
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .grey,
//                                                                           fontSize:
//                                                                               12)),
//                                                                   Text(
//                                                                       "Hyderabad",
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                       )),
//                                                                   SizedBox(
//                                                                     height: 20,
//                                                                   ),
//                                                                   Text(
//                                                                       "Drop Address",
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .grey,
//                                                                           fontSize:
//                                                                               12)),
//                                                                   Text(
//                                                                       "chennai",
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                       )),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 20.0,
//                                                       ),
//                                                       Container(
//                                                         width: double.infinity,
//                                                         padding:
//                                                             EdgeInsets.all(10),
//                                                         child: Text(
//                                                             "Customer Details"),
//                                                         color: Colors.grey[300],
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 5),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Name",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "Rahul Yadav",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Contact No.",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "+91 7073152328",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 20,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: double.infinity,
//                                                         padding:
//                                                             EdgeInsets.all(10),
//                                                         child: Text(
//                                                             "Order Details"),
//                                                         color: Colors.grey[300],
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 5),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Apartment Size",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "2 BHK",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Shift Date",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "21 Apr 2021",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Drop Date",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "23 Apr 2021",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 20,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: double.infinity,
//                                                         padding:
//                                                             EdgeInsets.all(10),
//                                                         child: Text(
//                                                             "Pricing Details"),
//                                                         color: Colors.grey[300],
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 5),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Basic Charges",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                                 Spacer(),
//                                                                 Text(
//                                                                   "₹ 23122",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             ListView.builder(
//                                                                 shrinkWrap:
//                                                                     true,
//                                                                 itemCount: 1,
//                                                                 itemBuilder:
//                                                                     (BuildContext
//                                                                             context,
//                                                                         int index) {
//                                                                   return 0 == 0
//                                                                       ? Column(
//                                                                           children: [
//                                                                             Row(
//                                                                               children: [
//                                                                                 Text(
//                                                                                   "Warehouse",
//                                                                                   style: TextStyle(fontSize: 12),
//                                                                                 ),
//                                                                                 Spacer(),
//                                                                                 Text(
//                                                                                   "₹ 2321",
//                                                                                   style: TextStyle(fontSize: 12),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                             SizedBox(
//                                                                               height: 5,
//                                                                             ),
//                                                                           ],
//                                                                         )
//                                                                       : Container();
//                                                                 }),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 vertical: 10),
//                                                         child: DottedLine(
//                                                           direction:
//                                                               Axis.horizontal,
//                                                           lineLength:
//                                                               double.infinity,
//                                                           lineThickness: 1.0,
//                                                           dashLength: 4.0,
//                                                           dashColor:
//                                                               Colors.black,
//                                                           dashRadius: 0.0,
//                                                           dashGapLength: 4.0,
//                                                           dashGapColor: Colors
//                                                               .transparent,
//                                                           dashGapRadius: 0.0,
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 horizontal: 5),
//                                                         child: Row(
//                                                           children: [
//                                                             Text(
//                                                               "Pay on Delivery",
//                                                               style: TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                             Spacer(),
//                                                             Text(
//                                                               "Order Total",
//                                                               style: TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                             SizedBox(
//                                                               width: 20,
//                                                             ),
//                                                             Text(
//                                                               "₹ 21312",
//                                                               style: TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 20,
//                                                       ),
//                                                       C.box10,
//                                                       ListTileTheme(
//                                                         dense: true,
//                                                         child: ExpansionTile(
//                                                             collapsedBackgroundColor:
//                                                                 Colors
//                                                                     .grey[300],
//                                                             backgroundColor:
//                                                                 Colors
//                                                                     .grey[300],
//                                                             tilePadding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         10),
//                                                             title: Text(
//                                                                 "Item List")),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               });
//                                             });
//                                       },
//                                       child: Text(
//                                         "More Info",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             color: C.primaryColor),
//                                       ))
//                                 ],
//                               ),
//                               Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'From :  ',
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.grey[700]),
//                                   ),
//                                   Text(
//                                     "Chennai",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     'To : ',
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.grey[700]),
//                                   ),
//                                   Text(
//                                     "Hyderabad",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                               Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Pickup Date :  ',
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.grey[700]),
//                                   ),
//                                   Text(
//                                     "21 Apr 2021",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     'Amount : ',
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.grey[700]),
//                                   ),
//                                   Text(
//                                     "₹ 37200",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                               Spacer(),
//                               Row(children: [
//                                 Text(
//                                   'Additional Services :  ',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.grey[700]),
//                                 ),
//                                 Text(
//                                   "Warehouse, Insurance",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14),
//                                 ),
//                               ]),
//                               Spacer(),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: MaterialButton(
//                                       color: Colors.green,
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           side:
//                                               BorderSide(color: Colors.green)),
//                                       onPressed: () {
//                                         return showDialog(
//                                             barrierDismissible: false,
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return StatefulBuilder(
//                                                   builder: (context, setState) {
//                                                 return Dialog(
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20),
//                                                     ),
//                                                     elevation: 0,
//                                                     backgroundColor:
//                                                         Colors.transparent,
//                                                     child: Stack(
//                                                       children: <Widget>[
//                                                         Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   left: 20,
//                                                                   top: 65,
//                                                                   right: 20,
//                                                                   bottom: 20),
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   top: 45),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             shape: BoxShape
//                                                                 .rectangle,
//                                                             color: Colors.white,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: Container(
//                                                             width: double
//                                                                 .maxFinite,
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               mainAxisSize:
//                                                                   MainAxisSize
//                                                                       .min,
//                                                               children: [
//                                                                 Text(
//                                                                   "Order Accepted Successfully",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           17,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 10,
//                                                                 ),
//                                                                 Text(
//                                                                   "You Can view the order details under My Orders",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           13,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 10,
//                                                                 ),
//                                                                 MaterialButton(
//                                                                     color: C
//                                                                         .primaryColor,
//                                                                     textColor:
//                                                                         Colors
//                                                                             .white,
//                                                                     materialTapTargetSize:
//                                                                         MaterialTapTargetSize
//                                                                             .shrinkWrap,
//                                                                     child: Text(
//                                                                         "OK"),
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     })
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           left: 20,
//                                                           right: 20,
//                                                           child: CircleAvatar(
//                                                             backgroundColor:
//                                                                 Colors
//                                                                     .transparent,
//                                                             radius: 45,
//                                                             child: ClipRRect(
//                                                                 child:
//                                                                     Image.asset(
//                                                               "assets/approved.png",
//                                                               fit: BoxFit
//                                                                   .fitHeight,
//                                                             )),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ));
//                                               });
//                                             });
//                                       },
//                                       child: Text("Accept",
//                                           style: TextStyle(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white)),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   Expanded(
//                                     child: MaterialButton(
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           side: BorderSide(
//                                               color: Colors.orange[300])),
//                                       onPressed: () {
//                                         return showDialog(
//                                             barrierDismissible: false,
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return StatefulBuilder(
//                                                   builder: (context, setState) {
//                                                 return Dialog(
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20),
//                                                     ),
//                                                     elevation: 0,
//                                                     backgroundColor:
//                                                         Colors.transparent,
//                                                     child: Stack(
//                                                       children: <Widget>[
//                                                         Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   left: 20,
//                                                                   top: 65,
//                                                                   right: 20,
//                                                                   bottom: 20),
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   top: 45),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             shape: BoxShape
//                                                                 .rectangle,
//                                                             color: Colors.white,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: Container(
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               mainAxisSize:
//                                                                   MainAxisSize
//                                                                       .min,
//                                                               children: [
//                                                                 Text(
//                                                                   "Why are you rejecting it?",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           17,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600),
//                                                                 ),
//                                                                 Divider(),
//                                                                 RadioListTile(
//                                                                   dense: true,
//                                                                   value:
//                                                                       notAvailable,
//                                                                   groupValue:
//                                                                       state,
//                                                                   onChanged:
//                                                                       (e) {
//                                                                     setState(
//                                                                         () {
//                                                                       state = 0;
//                                                                     });
//                                                                   },
//                                                                   title: Text(
//                                                                     "Not Available",
//                                                                   ),
//                                                                   subtitle: Text(
//                                                                       "If your unavailable in this date, Please update your calendar"),
//                                                                 ),
//                                                                 Divider(),
//                                                                 RadioListTile(
//                                                                   dense: true,
//                                                                   value:
//                                                                       problemInPricing,
//                                                                   groupValue:
//                                                                       state,
//                                                                   onChanged:
//                                                                       (e) {
//                                                                     setState(
//                                                                         () {
//                                                                       state = 1;
//                                                                     });
//                                                                   },
//                                                                   title: Text(
//                                                                       "Change in Price"),
//                                                                   subtitle: Text(
//                                                                       "It is advisable to keep update price under pricing details."),
//                                                                 ),
//                                                                 if (state == 1)
//                                                                   Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             20,
//                                                                         vertical:
//                                                                             10),
//                                                                     child:
//                                                                         new TextFormField(
//                                                                       keyboardType:
//                                                                           TextInputType
//                                                                               .number,
//                                                                       decoration: new InputDecoration(
//                                                                           isDense: true, // Added this
//                                                                           contentPadding: EdgeInsets.all(15),
//                                                                           focusedBorder: OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.all(Radius.circular(4)),
//                                                                             borderSide:
//                                                                                 BorderSide(
//                                                                               width: 1,
//                                                                               color: Color(0xFF2821B5),
//                                                                             ),
//                                                                           ),
//                                                                           labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                                                                           labelText: "Update Price"),
//                                                                     ),
//                                                                   ),
//                                                                 Divider(),
//                                                                 SizedBox(
//                                                                   height: 10,
//                                                                 ),
//                                                                 state != 1
//                                                                     ? MaterialButton(
//                                                                         materialTapTargetSize:
//                                                                             MaterialTapTargetSize
//                                                                                 .shrinkWrap,
//                                                                         child: Text(
//                                                                             "Ok"),
//                                                                         onPressed:
//                                                                             () {
//                                                                           Navigator.pop(
//                                                                               context);
//                                                                         })
//                                                                     : Row(
//                                                                         children: [
//                                                                           Expanded(
//                                                                             child:
//                                                                                 MaterialButton(
//                                                                               color: Colors.green,
//                                                                               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.green)),
//                                                                               onPressed: () {
//                                                                                 Navigator.pop(context);
//                                                                               },
//                                                                               child: Text("Accept with New Price", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       )
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           left: 20,
//                                                           right: 20,
//                                                           child: CircleAvatar(
//                                                             backgroundColor:
//                                                                 Colors
//                                                                     .transparent,
//                                                             radius: 45,
//                                                             child: ClipRRect(
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             45)),
//                                                                 child:
//                                                                     Image.asset(
//                                                                   "assets/reject.png",
//                                                                   fit: BoxFit
//                                                                       .fitHeight,
//                                                                 )),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ));
//                                               });
//                                             });
//                                       },
//                                       color: Colors.orange[300],
//                                       textColor: Colors.black,
//                                       child: Text("Reject",
//                                           style: TextStyle(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.black)),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           )),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
