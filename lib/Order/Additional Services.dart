import 'dart:convert';
import 'package:crisis/model/app_state.dart';
import 'package:crisis/redux/actions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../Appbar.dart';
import '../Auth/register.dart';
import '../Fade Route.dart';
import 'Address Page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AdditionalServices extends StatefulWidget {
  final spId;
  AdditionalServices({@required this.spId});
  @override
  _AdditionalServicesState createState() => _AdditionalServicesState();
}

class _AdditionalServicesState extends State<AdditionalServices> {
  @override
  double acInstallation = 0;
  double acUninstallation = 0;
  double geyserInstallation = 0;
  double geyserUninstallation = 0;
  double washingMachineInstallation = 0;
  double washingMachineUninstallation = 0;
  List<dynamic> singleServices = [];
  List<dynamic> tempSingleServices = [];
  List<dynamic> multiServices = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFf9a825), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(SingleServices(singleServices));
              if (_auth.currentUser != null) {
                FirebaseAnalytics().logEvent(
                    name: 'Address_Screen',
                    parameters: {'Description': 'Went to Fill Address'});
                Navigator.push(context, FadeRoute(page: Address()));
              } else {
                FirebaseAnalytics().logEvent(
                    name: 'Login_Screen',
                    parameters: {'Description': 'Went to Login'});
                Navigator.push(context, FadeRoute(page: RegisterScreen()));
              }
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MyAppBar(curStep: 4)),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                onInit: (store) async {
                  var dio = Dio();
                  print(widget.spId);
                  print(store.state.shiftType);
                  var resp = await dio.get(
                    'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/serviceprovidercost?type=servicesAndServiceProviderId&tenantSet_id=PAM01&tenantUsecase=abc&serviceProviderId=${widget.spId}&toCity=Banglore&shiftType=${store.state.shiftType}',
                  );
                  print(resp);
                  Map<String, dynamic> map = json.decode(resp.toString());
                  Map<String, dynamic> tempMap = json.decode(resp.toString());
                  singleServices = map['resp']["SingleServiceOfferings"];
                  multiServices = map['resp']['MultiServiceOfferings'];
                  tempSingleServices =
                      tempMap['resp']["SingleServiceOfferings"];
                  if (resp.statusCode == 200) {
                    setState(() {
                      loading = false;
                    });
                  }

                  // if (store.state.additionalItems != null) {
                  //   for (var i = 0;
                  //       i < store.state.additionalItems.length;
                  //       i++) {
                  //     if (store.state.additionalItems[i]['itemName'] ==
                  //         "Washing Machine") {
                  //       washingMachineInstallation =
                  //           washingMachineUninstallation =
                  //               store.state.additionalItems[i]['quantity'] !=
                  //                       null
                  //                   ? double.parse(store
                  //                       .state.additionalItems[i]['quantity']
                  //                       .toString())
                  //                   : 0;
                  //     }
                  //     if (store.state.additionalItems[i]['itemName'] == "AC") {
                  //       acInstallation = acUninstallation =
                  //           store.state.additionalItems[i]['quantity'] != null
                  //               ? double.parse(store
                  //                   .state.additionalItems[i]['quantity']
                  //                   .toString())
                  //               : 0;
                  //     }
                  //     if (store.state.additionalItems[i]['itemName'] ==
                  //         "Geyser") {
                  //       geyserInstallation = geyserUninstallation =
                  //           store.state.additionalItems[i]['quantity'] != null
                  //               ? double.parse(store
                  //                   .state.additionalItems[i]['quantity']
                  //                   .toString())
                  //               : 0;
                  //     }
                  //   }
                  // }
                },
                builder: (context, state) {
                  return loading == true
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator()))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Service Offerings",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        FirebaseAnalytics().logEvent(
                                            name: 'Skipped_Service_Offerings',
                                            parameters: {
                                              'Description':
                                                  'Skipped Service Offerings'
                                            });
                                        if (_auth.currentUser != null) {
                                          FirebaseAnalytics().logEvent(
                                              name: 'Address_Screen',
                                              parameters: {
                                                'Description':
                                                    'Went to Fill Address'
                                              });
                                          Navigator.push(context,
                                              FadeRoute(page: Address()));
                                        } else {
                                          FirebaseAnalytics().logEvent(
                                              name: 'Login_Screen',
                                              parameters: {
                                                'Description': 'Went to Login'
                                              });
                                          Navigator.push(
                                              context,
                                              FadeRoute(
                                                  page: RegisterScreen()));
                                        }
                                      },
                                      child: Text(
                                        "Skip All",
                                        style:
                                            TextStyle(color: Color(0xFF3f51b5)),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: singleServices.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              if (index == 0)
                                                Image.asset(
                                                  "assets/warehouse.png",
                                                  height: 60,
                                                  width: 60,
                                                )
                                              else if (index == 1)
                                                Image.asset(
                                                  "assets/box.png",
                                                  height: 60,
                                                  width: 60,
                                                )
                                              else if (index == 2)
                                                Image.asset(
                                                  "assets/insurance (2).png",
                                                  height: 60,
                                                  width: 60,
                                                )
                                              else if (index == 3)
                                                Image.asset(
                                                  "assets/unpacking.png",
                                                  height: 60,
                                                  width: 60,
                                                ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          singleServices[index]
                                                              ['label'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      Text(
                                                          singleServices[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.grey[200],
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      singleServices[index][
                                                              'selectionDetails']
                                                          ['oldPrice'],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "₹ ${singleServices[index]['selectionDetails']['newPrice']}",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      singleServices[index][
                                                              'selectionDetails']
                                                          ['gst'],
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            singleServices[
                                                                        index][
                                                                    "selected"] =
                                                                !singleServices[
                                                                        index][
                                                                    "selected"];
                                                          });
                                                          if (singleServices[
                                                                          index]
                                                                      [
                                                                      "selected"] ==
                                                                  true &&
                                                              singleServices[index]
                                                                          [
                                                                          "afterSelectEnquiry"]
                                                                      .length !=
                                                                  0) {
                                                            showModalBottomSheet(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return Container(
                                                                          height:
                                                                              250,
                                                                          padding:
                                                                              EdgeInsets.all(20),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                singleServices[index]['afterSelectEnquiry']['enquiryHeader'],
                                                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
                                                                              ),
                                                                              Spacer(),
                                                                              Container(
                                                                                  height: 50,
                                                                                  alignment: Alignment.center,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                                                                                  child: TextField(
                                                                                    onChanged: (e) {
                                                                                      setState(() {
                                                                                        singleServices[index]['afterSelectEnquiry']['value'] = e;
                                                                                      });
                                                                                      print(singleServices[index]['afterSelectEnquiry']['value']);
                                                                                    },
                                                                                    keyboardType: TextInputType.number,
                                                                                    decoration: InputDecoration.collapsed(
                                                                                      hintText: singleServices[index]['afterSelectEnquiry']['enquiryLabel'],
                                                                                    ),
                                                                                  )),
                                                                              Spacer(),
                                                                              MaterialButton(
                                                                                color: Color(0xFF3f51b5),
                                                                                onPressed: () {
                                                                                  if (singleServices[index]["label"] == "Warehouse") {
                                                                                    print("warehouse");
                                                                                    setState(() {
                                                                                      singleServices[index]["selectionDetails"]["newPrice"] = int.parse(tempSingleServices[index]["selectionDetails"]["newPrice"].toString()) * int.parse(singleServices[index]['afterSelectEnquiry']['value'].toString());
                                                                                    });
                                                                                    print(singleServices[index]["selectionDetails"]["newPrice"]);
                                                                                    print(tempSingleServices[index]["selectionDetails"]["newPrice"]);
                                                                                  }
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text(
                                                                                  'Done',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                              Spacer()
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                    })
                                                                .then((value) =>
                                                                    setState(
                                                                        () {}));
                                                          }
                                                        },
                                                        child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              side: BorderSide(
                                                                color: Color(
                                                                    0xFF3f51b5),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: singleServices[
                                                                            index]
                                                                        [
                                                                        "selected"] ==
                                                                    false
                                                                ? (Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            10),
                                                                    child: new Text(
                                                                        "SELECT",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ))
                                                                : Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Color(
                                                                          0xFF3f51b5),
                                                                    ),
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        new Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        new Text(
                                                                            "SELECTED",
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.white)),
                                                                      ],
                                                                    ),
                                                                  )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              // box20,
                              // Text(
                              //   multiServices[0]['service'],
                              //   textAlign: TextAlign.start,
                              //   style: TextStyle(
                              //       fontSize: 15, fontWeight: FontWeight.w600),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     shrinkWrap: true,
                              //     itemCount: multiServices[0]['options'].length,
                              //     itemBuilder: (context, index) {
                              //       return Column(
                              //         children: [
                              //           Card(
                              //             elevation: 2,
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: (MediaQuery.of(context)
                              //                               .size
                              //                               .width *
                              //                           (2 / 3)) -
                              //                       20,
                              //                   child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                           multiServices[0]
                              //                                   ['options']
                              //                               [index]['label'],
                              //                           style: TextStyle(
                              //                               fontSize: 14,
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .w600)),
                              //                       SizedBox(
                              //                         height: 7,
                              //                       ),
                              //                       Text(
                              //                           multiServices[0]
                              //                                       ['options']
                              //                                   [index]
                              //                               ['description'],
                              //                           style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 11,
                              //                           )),
                              //                       GestureDetector(
                              //                         onTap: () {
                              //                           showModalBottomSheet(
                              //                               shape:
                              //                                   RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             10.0),
                              //                               ),
                              //                               context: context,
                              //                               builder:
                              //                                   (BuildContext
                              //                                       context) {
                              //                                 return Container(
                              //                                   height: 300,
                              //                                   padding:
                              //                                       EdgeInsets
                              //                                           .all(
                              //                                               30),
                              //                                   child: Column(
                              //                                     crossAxisAlignment:
                              //                                         CrossAxisAlignment
                              //                                             .start,
                              //                                     children: [
                              //                                       Text(
                              //                                         "Leave your goods in safe hands.",
                              //                                         style: TextStyle(
                              //                                             fontSize:
                              //                                                 20,
                              //                                             fontWeight: FontWeight
                              //                                                 .w600,
                              //                                             color:
                              //                                                 Color(0xFF3f51b5)),
                              //                                       ),
                              //                                       SizedBox(
                              //                                         height:
                              //                                             10,
                              //                                       ),
                              //                                       Container(
                              //                                           height:
                              //                                               5,
                              //                                           width:
                              //                                               50,
                              //                                           color: Color(
                              //                                               0xFF3f51b5)),
                              //                                       SizedBox(
                              //                                         height:
                              //                                             10,
                              //                                       ),
                              //                                       Text(
                              //                                           "Reviews this service provider almost always runs on schedule."),
                              //                                       SizedBox(
                              //                                         height:
                              //                                             10,
                              //                                       ),
                              //                                       Text(
                              //                                         "We still recommend that you check the latest reviews by tapping on the ratings.",
                              //                                         style: TextStyle(
                              //                                             fontSize:
                              //                                                 12,
                              //                                             color:
                              //                                                 Colors.grey),
                              //                                       ),
                              //                                       SizedBox(
                              //                                         height:
                              //                                             20,
                              //                                       ),
                              //                                       Align(
                              //                                         alignment:
                              //                                             Alignment
                              //                                                 .bottomRight,
                              //                                         child:
                              //                                             TextButton(
                              //                                           onPressed:
                              //                                               () {
                              //                                             Navigator.pop(
                              //                                                 context);
                              //                                           },
                              //                                           child:
                              //                                               Text(
                              //                                             'OKAY',
                              //                                             style: TextStyle(
                              //                                                 fontWeight: FontWeight.w600,
                              //                                                 color: Color(0xFF3f51b5)),
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                       Spacer()
                              //                                     ],
                              //                                   ),
                              //                                 );
                              //                               });
                              //                         },
                              //                         child: Container(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 7),
                              //                           child: Text(
                              //                             "More Info",
                              //                             style: TextStyle(
                              //                                 fontSize: 12,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w600,
                              //                                 color: Color(
                              //                                     0xFF3f51b5)),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //                 Container(
                              //                   color: Colors.grey[200],
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: (MediaQuery.of(context)
                              //                               .size
                              //                               .width *
                              //                           (1 / 3)) -
                              //                       10,
                              //                   child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.end,
                              //                     children: [
                              //                       Text(
                              //                         multiServices[0][
                              //                                         'options']
                              //                                     [index]
                              //                                 [
                              //                                 'selectionDetails']
                              //                             ['oldPrice'],
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             fontWeight:
                              //                                 FontWeight.w500,
                              //                             color: Colors.grey,
                              //                             decoration:
                              //                                 TextDecoration
                              //                                     .lineThrough),
                              //                       ),
                              //                       SizedBox(
                              //                         height: 5,
                              //                       ),
                              //                       Text(
                              //                         installationPricing ??
                              //                             multiServices[0][
                              //                                             'options']
                              //                                         [index][
                              //                                     'selectionDetails']
                              //                                 ['newPrice'],
                              //                         style: TextStyle(
                              //                           fontSize: 13,
                              //                           fontWeight:
                              //                               FontWeight.w600,
                              //                         ),
                              //                       ),
                              //                       Text(
                              //                         multiServices[0][
                              //                                         'options']
                              //                                     [index]
                              //                                 [
                              //                                 'selectionDetails']
                              //                             ['gst'],
                              //                         style: TextStyle(
                              //                           color: Colors.grey,
                              //                           fontSize: 10,
                              //                           fontWeight:
                              //                               FontWeight.w600,
                              //                         ),
                              //                       ),
                              //                       SizedBox(
                              //                         height: 10,
                              //                       ),
                              //                       Container(
                              //                         child: GestureDetector(
                              //                           onTap: () {
                              //                             for (var i = 0;
                              //                                 i <
                              //                                     multiServices[
                              //                                                 0]
                              //                                             [
                              //                                             'options']
                              //                                         .length;
                              //                                 i++) {
                              //                               setState(() {
                              //                                 multiServices[0][
                              //                                         'options'][i]
                              //                                     [
                              //                                     'installation'] = false;
                              //                               });
                              //                             }
                              //                             setState(() {
                              //                               multiServices[0][
                              //                                           'options']
                              //                                       [index][
                              //                                   'installation'] = true;
                              //                             });
                              //                             showModalBottomSheet(
                              //                                 isScrollControlled:
                              //                                     true,
                              //                                 shape:
                              //                                     RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               10.0),
                              //                                 ),
                              //                                 context: context,
                              //                                 builder:
                              //                                     (BuildContext
                              //                                         context) {
                              //                                   return StatefulBuilder(
                              //                                       builder:
                              //                                           (context,
                              //                                               setState) {
                              //                                     return Container(
                              //                                       height: MediaQuery.of(context)
                              //                                               .size
                              //                                               .height /
                              //                                           1.1,
                              //                                       padding: EdgeInsets.symmetric(
                              //                                           vertical:
                              //                                               20,
                              //                                           horizontal:
                              //                                               20),
                              //                                       child:
                              //                                           Column(
                              //                                         crossAxisAlignment:
                              //                                             CrossAxisAlignment
                              //                                                 .start,
                              //                                         children: [
                              //                                           Spacer(),
                              //                                           Text(
                              //                                             "Installation",
                              //                                             style: TextStyle(
                              //                                                 fontSize: 20,
                              //                                                 fontWeight: FontWeight.w600,
                              //                                                 color: Colors.black),
                              //                                           ),
                              //                                           SizedBox(
                              //                                             height:
                              //                                                 10,
                              //                                           ),
                              //                                           Card(
                              //                                             child:
                              //                                                 Container(
                              //                                               padding:
                              //                                                   EdgeInsets.all(10),
                              //                                               child:
                              //                                                   Row(
                              //                                                 children: [
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                   Text(
                              //                                                     "AC",
                              //                                                     style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                   ),
                              //                                                   Spacer(),
                              //                                                   Counter(
                              //                                                       initialValue: acInstallation,
                              //                                                       minValue: 0,
                              //                                                       maxValue: 10,
                              //                                                       onChanged: (e) {
                              //                                                         setState(() {
                              //                                                           acInstallation = e;
                              //                                                         });
                              //                                                       },
                              //                                                       decimalPlaces: 0),
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                 ],
                              //                                               ),
                              //                                             ),
                              //                                           ),
                              //                                           Card(
                              //                                             child:
                              //                                                 Container(
                              //                                               padding:
                              //                                                   EdgeInsets.all(10),
                              //                                               child:
                              //                                                   Row(
                              //                                                 children: [
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                   Text(
                              //                                                     "Washing Machine",
                              //                                                     style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                   ),
                              //                                                   Spacer(),
                              //                                                   Counter(
                              //                                                       initialValue: washingMachineInstallation,
                              //                                                       minValue: 0,
                              //                                                       maxValue: 10,
                              //                                                       onChanged: (e) {
                              //                                                         setState(() {
                              //                                                           washingMachineInstallation = e;
                              //                                                         });
                              //                                                       },
                              //                                                       decimalPlaces: 0),
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                 ],
                              //                                               ),
                              //                                             ),
                              //                                           ),
                              //                                           Card(
                              //                                             child:
                              //                                                 Container(
                              //                                               padding:
                              //                                                   EdgeInsets.all(10),
                              //                                               child:
                              //                                                   Row(
                              //                                                 children: [
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                   Text(
                              //                                                     "Geyser",
                              //                                                     style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                   ),
                              //                                                   Spacer(),
                              //                                                   Counter(
                              //                                                       initialValue: geyserInstallation,
                              //                                                       minValue: 0,
                              //                                                       maxValue: 10,
                              //                                                       onChanged: (e) {
                              //                                                         setState(() {
                              //                                                           geyserInstallation = e;
                              //                                                         });
                              //                                                       },
                              //                                                       decimalPlaces: 0),
                              //                                                   SizedBox(
                              //                                                     width: 50,
                              //                                                   ),
                              //                                                 ],
                              //                                               ),
                              //                                             ),
                              //                                           ),
                              //                                           Spacer(),
                              //                                           Text(
                              //                                             "Uninstallation",
                              //                                             style: TextStyle(
                              //                                                 fontSize: 20,
                              //                                                 fontWeight: FontWeight.w600,
                              //                                                 color: Colors.black),
                              //                                           ),
                              //                                           SizedBox(
                              //                                             height:
                              //                                                 5,
                              //                                           ),
                              //                                           Column(
                              //                                             children: [
                              //                                               Card(
                              //                                                 child: Container(
                              //                                                   padding: EdgeInsets.all(10),
                              //                                                   child: Row(
                              //                                                     children: [
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                       Text(
                              //                                                         "AC",
                              //                                                         style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                       ),
                              //                                                       Spacer(),
                              //                                                       Counter(
                              //                                                           initialValue: acUninstallation,
                              //                                                           minValue: 0,
                              //                                                           maxValue: 10,
                              //                                                           onChanged: (e) {
                              //                                                             setState(() {
                              //                                                               acUninstallation = e;
                              //                                                             });
                              //                                                           },
                              //                                                           decimalPlaces: 0),
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                     ],
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                               Card(
                              //                                                 child: Container(
                              //                                                   padding: EdgeInsets.all(10),
                              //                                                   child: Row(
                              //                                                     children: [
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                       Text(
                              //                                                         "Washing Machine",
                              //                                                         style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                       ),
                              //                                                       Spacer(),
                              //                                                       Counter(
                              //                                                           initialValue: washingMachineUninstallation,
                              //                                                           minValue: 0,
                              //                                                           maxValue: 10,
                              //                                                           onChanged: (e) {
                              //                                                             setState(() {
                              //                                                               washingMachineUninstallation = e;
                              //                                                             });
                              //                                                           },
                              //                                                           decimalPlaces: 0),
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                     ],
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                               Card(
                              //                                                 child: Container(
                              //                                                   padding: EdgeInsets.all(10),
                              //                                                   child: Row(
                              //                                                     children: [
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                       Text(
                              //                                                         "Geyser",
                              //                                                         style: TextStyle(fontWeight: FontWeight.w600),
                              //                                                       ),
                              //                                                       Spacer(),
                              //                                                       Counter(
                              //                                                           initialValue: geyserUninstallation,
                              //                                                           minValue: 0,
                              //                                                           maxValue: 10,
                              //                                                           onChanged: (e) {
                              //                                                             setState(() {
                              //                                                               geyserUninstallation = e;
                              //                                                             });
                              //                                                           },
                              //                                                           decimalPlaces: 0),
                              //                                                       SizedBox(
                              //                                                         width: 50,
                              //                                                       ),
                              //                                                     ],
                              //                                                   ),
                              //                                                 ),
                              //                                               )
                              //                                             ],
                              //                                           ),
                              //                                           Spacer(),
                              //                                           Align(
                              //                                             alignment:
                              //                                                 Alignment.bottomRight,
                              //                                             child:
                              //                                                 MaterialButton(
                              //                                               color:
                              //                                                   Color(0xFF3f51b5),
                              //                                               onPressed:
                              //                                                   () {
                              //                                                 Navigator.pop(context);
                              //                                               },
                              //                                               child:
                              //                                                   Text(
                              //                                                 'Done',
                              //                                                 style: TextStyle(color: Colors.white),
                              //                                               ),
                              //                                             ),
                              //                                           ),
                              //                                           Spacer()
                              //                                         ],
                              //                                       ),
                              //                                     );
                              //                                   });
                              //                                 });
                              //                           },
                              //                           child: Card(
                              //                               shape:
                              //                                   RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             5.0),
                              //                                 side: BorderSide(
                              //                                   color: Color(
                              //                                       0xFF3f51b5),
                              //                                   width: 1,
                              //                                 ),
                              //                               ),
                              //                               child: multiServices[0]['options']
                              //                                               [
                              //                                               index]
                              //                                           [
                              //                                           'installation'] ==
                              //                                       false
                              //                                   ? (Container(
                              //                                       padding: EdgeInsets.symmetric(
                              //                                           vertical:
                              //                                               5,
                              //                                           horizontal:
                              //                                               10),
                              //                                       child: new Text(
                              //                                           "SELECT",
                              //                                           style: TextStyle(
                              //                                               fontSize:
                              //                                                   13,
                              //                                               fontWeight:
                              //                                                   FontWeight.w600)),
                              //                                     ))
                              //                                   : Container(
                              //                                       decoration:
                              //                                           BoxDecoration(
                              //                                         borderRadius:
                              //                                             BorderRadius.circular(
                              //                                                 5),
                              //                                         color: Color(
                              //                                             0xFF3f51b5),
                              //                                       ),
                              //                                       padding: EdgeInsets.symmetric(
                              //                                           vertical:
                              //                                               5,
                              //                                           horizontal:
                              //                                               10),
                              //                                       child:
                              //                                           new Row(
                              //                                         crossAxisAlignment:
                              //                                             CrossAxisAlignment
                              //                                                 .center,
                              //                                         mainAxisSize:
                              //                                             MainAxisSize
                              //                                                 .min,
                              //                                         children: [
                              //                                           new Text(
                              //                                               "SELECTED",
                              //                                               style: TextStyle(
                              //                                                   fontSize: 12,
                              //                                                   fontWeight: FontWeight.w600,
                              //                                                   color: Colors.white)),
                              //                                         ],
                              //                                       ),
                              //                                     )),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     }),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                            ]);
                })),
      ),
    );
  }
}
