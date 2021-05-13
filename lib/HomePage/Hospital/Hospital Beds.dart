import 'dart:convert';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/model/app_state.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../Appbar.dart';
import '../../Constants.dart';
import '../../redux/actions.dart';

import 'package:url_launcher/url_launcher.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

class HospitalBedList extends StatefulWidget {
  @override
  _HospitalBedListState createState() => _HospitalBedListState();
}

class _HospitalBedListState extends State<HospitalBedList> {
  List<dynamic> filteredSp = [];
  // _launchCaller() async {
  //   const url = "tel:1234567";
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  // bo
  String spId;
  bool spSelected = false;
  bool sortby = false;
  bool priceSort = false;
  bool ratingSort = false;
  List city = ["wareouse", "sp", "de"];
  bool warehouseFilter = false;
  bool premiumFilter = false;
  bool insuranceFilter = false;
  bool installationFilter = false;
  bool unpackingFilter = false;
  bool loading = true;
  bool offeringsAvailable = true;
  List<dynamic> spList = [];
  List<dynamic> tempList = [];
  var dio = Dio();

  getSP(items) async {
    print(items);
    var resp = await dio.post(
        'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
        data: {
          'tenantSet_id': 'CRISIS01',
          'tenantUsecase': 'CRISIS01',
          'useCase': items['usecase'] != null ? items['usecase'] : 'Hospital',
          'state': items['stateName'],
          'district': items['districtName']
        });
    print(resp);
    Map<String, dynamic> map = json.decode(resp.toString());
    spList = map['resp']['allPrices'];
    tempList = map['resp']["allPrices"];
    for (var i = 0; i < spList.length; i++) {
      spList[i]['selected'] = false;
      tempList[i]['selected'] = false;
      spList[i]['rating'] = 4;
      tempList[i]['rating'] = 4;
    }
    setState(() {
      spList = spList;
      tempList = tempList;
      filteredSp = spList;
      loading = false;
    });
  }

  filter(String item) {
    filteredSp = [];
    for (var i = 0; i < spList.length; i++) {
      spList[i]["offerings"].forEach((v) {
        if (v.toLowerCase().contains(item)) {
          filteredSp.add(spList[i]);
        }
      });
    }
    setState(() {
      filteredSp = filteredSp;
    });
  }

  sort(bool sort, List<dynamic> list, String basis) {
    if (sort) {
      list.sort((a, b) => a[basis].compareTo(b[basis]));
      setState(() {
        list = list;
      });
    } else {
      list.sort((a, b) => b[basis].compareTo(a[basis]));
      setState(() {
        list = list;
      });
    }
  }

  clearAllFilters() {
    setState(() {
      warehouseFilter = false;
      premiumFilter = false;
      insuranceFilter = false;
      installationFilter = false;
      unpackingFilter = false;
      filteredSp = tempList;
    });
    Navigator.pop(context);
  }

  clearAllSort() {
    setState(() {
      priceSort = false;
      ratingSort = false;
      filteredSp = tempList;
    });
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    print('started');
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: MyAppBar(curStep: 0)),
        // bottomNavigationBar: Container(
        //   padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        //   child: SizedBox(
        //     height: 50,
        //     width: double.infinity,
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         primary: Color(0xFFf9a825), // background
        //         onPrimary: Colors.white, // foreground
        //       ),
        //       onPressed: spSelected == false
        //           ? null
        //           : () {
        //               if (offeringsAvailable == true) {
        //                 print(spId);
        //                 FirebaseAnalytics().logEvent(
        //                     name: 'Service_Offerings_Screen',
        //                     parameters: {
        //                       'Description': 'Went to Service Offerings Screen'
        //                     });
        //                 Navigator.push(
        //                     context,
        //                     FadeRoute(
        //                         page: AdditionalServices(
        //                       spId: spId,
        //                     )));
        //               } else {
        //                 if (_auth.currentUser != null) {
        //                   FirebaseAnalytics().logEvent(
        //                       name: 'Address_Screen',
        //                       parameters: {
        //                         'Description': 'Went to Fill Address'
        //                       });
        //                   Navigator.push(context, FadeRoute(page: Address()));
        //                 } else {
        //                   FirebaseAnalytics().logEvent(
        //                       name: 'Login_Screen',
        //                       parameters: {'Description': 'Went to Login'});
        //                   Navigator.push(
        //                       context, FadeRoute(page: RegisterScreen()));
        //                 }
        //               }
        //             },
        // child: Text(
        //   "Next",
        //   style: TextStyle(color: Colors.black),
        // ),
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: StoreConnector<AppState, AppState>(
                    onInit: (store) {
                      Map city = {
                        "toCity": "Hyderabad",
                        "fromCity": "Banglore",
                        "shiftType": store.state.shiftType,
                        "items": store.state.additionalItems,
                        "dropFloor": store.state.dropFloor,
                        "pickupFloor": store.state.pickupFloor,
                        "dropLift": store.state.dropLift,
                        "pickupLift": store.state.pickupLift,
                        'vehicles': store.state.vehicles,
                        "stateName": store.state.stateName,
                        "districtName": store.state.districtName,
                        "usecase": store.state.usecase
                      };
                      //print(store.state);
                      getSP(city);
                    },
                    converter: (store) => store.state,
                    builder: (context, state) {
                      return loading == true
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Center(child: Loading()),
                            )
                          : filteredSp.length == 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                      ),
                                      SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                              "assets/anxiety.png")),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        "Sorry!",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "No Hospitals Available at the moment",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 18),
                                      ),
                                    ],
                                  )),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "List of Hospitals",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: new TextFormField(
                                          textInputAction: TextInputAction.go,
                                          onChanged: (string) {
                                            setState(() {
                                              filteredSp = (spList)
                                                  .where((u) => (u['name']
                                                          .toLowerCase()
                                                          .contains(string
                                                              .toLowerCase()) ||
                                                      u['address']
                                                          .toLowerCase()
                                                          .contains(string
                                                              .toLowerCase())))
                                                  .toList();
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF2821B5),
                                              ),
                                            ),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.grey)),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                            ),
                                            hintText: "Search..",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     setState(() {
                                          //       sortby = false;
                                          //     });
                                          //     showModalBottomSheet(
                                          //         context: context,
                                          //         builder: (BuildContext context) {
                                          //           return StatefulBuilder(builder:
                                          //               (context, setState) {
                                          //             return Container(
                                          //               child: Column(
                                          //                 crossAxisAlignment:
                                          //                     CrossAxisAlignment
                                          //                         .start,
                                          //                 children: [
                                          //                   Card(
                                          //                     child: Container(
                                          //                       child: Row(
                                          //                         children: [
                                          //                           IconButton(
                                          //                               icon: Icon(Icons
                                          //                                   .close),
                                          //                               onPressed:
                                          //                                   () {
                                          //                                 Navigator.pop(
                                          //                                     context);
                                          //                               }),
                                          //                           Text(
                                          //                             "Filter",
                                          //                             style:
                                          //                                 TextStyle(
                                          //                               fontSize:
                                          //                                   13,
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .w600,
                                          //                             ),
                                          //                           ),
                                          //                           Spacer(),
                                          //                           TextButton(
                                          //                               onPressed:
                                          //                                   () {
                                          //                                 clearAllFilters();
                                          //                               },
                                          //                               child: Text(
                                          //                                 "Clear All",
                                          //                                 style: TextStyle(
                                          //                                     color:
                                          //                                         primaryColor),
                                          //                               ))
                                          //                         ],
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                   SizedBox(
                                          //                     height: 20,
                                          //                   ),
                                          //                   Container(
                                          //                     padding: EdgeInsets
                                          //                         .symmetric(
                                          //                       horizontal: 40,
                                          //                     ),
                                          //                     child: Column(
                                          //                       children: [
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           //font change
                                          //                           title: new Text(
                                          //                             "Warehouse",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await filter(
                                          //                                 "warehouse");
                                          //                             setState(() {
                                          //                               warehouseFilter =
                                          //                                   val;
                                          //                               filteredSp =
                                          //                                   filteredSp;
                                          //                             });
                                          //                           },
                                          //                           value:
                                          //                               warehouseFilter,
                                          //                         ),
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           //font change
                                          //                           title: new Text(
                                          //                             "Installation",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await filter(
                                          //                                 "installation");
                                          //                             setState(() {
                                          //                               installationFilter =
                                          //                                   val;
                                          //                               filteredSp =
                                          //                                   filteredSp;
                                          //                             });
                                          //                           },
                                          //                           value:
                                          //                               installationFilter,
                                          //                         ),
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           //font change
                                          //                           title: new Text(
                                          //                             "Unpacking",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await filter(
                                          //                                 "unpacking");
                                          //                             setState(() {
                                          //                               unpackingFilter =
                                          //                                   val;
                                          //                               filteredSp =
                                          //                                   filteredSp;
                                          //                             });
                                          //                           },
                                          //                           value:
                                          //                               unpackingFilter,
                                          //                         ),
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           //font change
                                          //                           title: new Text(
                                          //                             "Insurance",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await filter(
                                          //                                 "insurance");
                                          //                             setState(() {
                                          //                               insuranceFilter =
                                          //                                   val;
                                          //                               filteredSp =
                                          //                                   filteredSp;
                                          //                             });
                                          //                           },
                                          //                           value:
                                          //                               insuranceFilter,
                                          //                         ),
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           //font change
                                          //                           title: new Text(
                                          //                             "Premium Packaging",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await filter(
                                          //                                 "premium");
                                          //                             setState(() {
                                          //                               premiumFilter =
                                          //                                   val;
                                          //                               filteredSp =
                                          //                                   filteredSp;
                                          //                             });
                                          //                           },
                                          //                           value:
                                          //                               premiumFilter,
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                   Spacer()
                                          //                 ],
                                          //               ),
                                          //             );
                                          //           });
                                          //         });
                                          //   },
                                          //   child: Container(
                                          //     padding:
                                          //         EdgeInsets.fromLTRB(10, 6, 10, 6),
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.grey[100],
                                          //         border: Border.all(
                                          //           color: C.primaryColor,
                                          //         ),
                                          //         borderRadius: BorderRadius.all(
                                          //             Radius.circular(20))),
                                          //     child: Text(
                                          //       "Filter",
                                          //       style: TextStyle(
                                          //           fontSize: 13,
                                          //           color: Colors.grey),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     showModalBottomSheet(
                                          //         context: context,
                                          //         builder: (BuildContext context) {
                                          //           return StatefulBuilder(builder:
                                          //               (context, setState) {
                                          //             return Container(
                                          //               child: Column(
                                          //                 crossAxisAlignment:
                                          //                     CrossAxisAlignment
                                          //                         .start,
                                          //                 children: [
                                          //                   Card(
                                          //                     child: Container(
                                          //                       child: Row(
                                          //                         children: [
                                          //                           IconButton(
                                          //                               icon: Icon(Icons
                                          //                                   .close),
                                          //                               onPressed:
                                          //                                   () {
                                          //                                 Navigator.pop(
                                          //                                     context);
                                          //                               }),
                                          //                           Text(
                                          //                             "Sort By",
                                          //                             style:
                                          //                                 TextStyle(
                                          //                               fontSize:
                                          //                                   13,
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .w600,
                                          //                             ),
                                          //                           ),
                                          //                           Spacer(),
                                          //                           TextButton(
                                          //                               onPressed:
                                          //                                   () {
                                          //                                 clearAllSort();
                                          //                               },
                                          //                               child: Text(
                                          //                                 "Clear All",
                                          //                                 style: TextStyle(
                                          //                                     color:
                                          //                                         primaryColor),
                                          //                               ))
                                          //                         ],
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                   SizedBox(
                                          //                     height: 20,
                                          //                   ),
                                          //                   Container(
                                          //                     padding: EdgeInsets
                                          //                         .symmetric(
                                          //                             horizontal:
                                          //                                 40),
                                          //                     child: Column(
                                          //                       children: [
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           title: new Text(
                                          //                             "Price",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await sort(
                                          //                                 priceSort,
                                          //                                 filteredSp,
                                          //                                 'price');
                                          //                             setState(() {
                                          //                               priceSort =
                                          //                                   val;
                                          //                             });
                                          //                             Navigator.pop(
                                          //                                 context);
                                          //                           },
                                          //                           value:
                                          //                               priceSort,
                                          //                         ),
                                          //                         CheckboxListTile(
                                          //                           dense: true,
                                          //                           title: new Text(
                                          //                             "Ratings",
                                          //                             style: TextStyle(
                                          //                                 fontSize:
                                          //                                     14,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 letterSpacing:
                                          //                                     0.5),
                                          //                           ),
                                          //                           onChanged:
                                          //                               (val) async {
                                          //                             await sort(
                                          //                                 ratingSort,
                                          //                                 filteredSp,
                                          //                                 'rating');
                                          //                             setState(() {
                                          //                               ratingSort =
                                          //                                   val;
                                          //                             });
                                          //                             Navigator.pop(
                                          //                                 context);
                                          //                           },
                                          //                           value:
                                          //                               ratingSort,
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                   Spacer()
                                          //                 ],
                                          //               ),
                                          //             );
                                          //           });
                                          //         });
                                          //   },
                                          //   child: Container(
                                          //     padding:
                                          //         EdgeInsets.fromLTRB(10, 6, 10, 6),
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.grey[100],
                                          //         border: Border.all(
                                          //           color: C.primaryColor,
                                          //         ),
                                          //         borderRadius: BorderRadius.all(
                                          //             Radius.circular(20))),
                                          //     child: Row(
                                          //       children: [
                                          //         Text(
                                          //           "Sort By",
                                          //           style: TextStyle(
                                          //               fontSize: 13,
                                          //               color: Colors.grey),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 5,
                                          //         ),
                                          //         Icon(
                                          //           Icons.arrow_downward_rounded,
                                          //           size: 10,
                                          //           color: Colors.grey,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: filteredSp.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                for (var i = 0;
                                                    i < filteredSp.length;
                                                    i++) {
                                                  setState(() {
                                                    filteredSp[i]['selected'] =
                                                        false;
                                                  });
                                                }
                                                setState(() {
                                                  filteredSp[index]
                                                      ['selected'] = true;
                                                  spSelected = true;
                                                  spId = filteredSp[index]
                                                      ["serviceProviderId"];
                                                });
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .dispatch(Price(
                                                        filteredSp[index]
                                                                ["price"]
                                                            .toString()));
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .dispatch(SpId(filteredSp[
                                                                index][
                                                            "serviceProviderId"]
                                                        .toString()));
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .dispatch(
                                                        SelectedServiceProvider(
                                                            filteredSp[index]
                                                                    ['name']
                                                                .trim()));

                                                print(
                                                    filteredSp[index]['name']);
                                                print(
                                                    filteredSp[index]['price']);
                                                if (filteredSp[index]
                                                            ["offerings"]
                                                        .length ==
                                                    0) {
                                                  setState(() {
                                                    offeringsAvailable = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    offeringsAvailable = true;
                                                  });
                                                }
                                              },
                                              child: Card(
                                                  shape: filteredSp[index]
                                                              ['selected'] ==
                                                          true
                                                      ? RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Color(
                                                                  0xFF3f51b5)))
                                                      : RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          side: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey)),
                                                  elevation: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            // Image.network(
                                                            //   "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
                                                            //   height: 60,
                                                            //   width: 60,
                                                            // ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              flex: 10,
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    box10,
                                                                    Text(
                                                                      filteredSp[index]
                                                                              [
                                                                              'name']
                                                                          .trim(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Colors.grey[800]),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          Text(
                                                                            'Ph: ' +
                                                                                (filteredSp[index]['mobile'] != null ? filteredSp[index]['mobile'] : 'NA'),
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.grey[600]),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   width: 10,
                                                                          // ),
                                                                          if (filteredSp[index]['mobile'] != null &&
                                                                              filteredSp[index]['mobile'] != 'NA')
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.phone_enabled_rounded,
                                                                                color: Colors.blue.shade400,
                                                                              ),
                                                                              onPressed: () => launch('tel:' + filteredSp[index]['mobile']),
                                                                            ),
                                                                          // RaisedButton(
                                                                          // onPressed: () =>
                                                                          //     launch(
                                                                          //         'tel:7585867170'),
                                                                          //   child: Text(
                                                                          //       'Call'),
                                                                          //   textColor:
                                                                          //       Colors
                                                                          //           .black,
                                                                          //   padding:
                                                                          //       const EdgeInsets.all(
                                                                          //           2.0),
                                                                          // ),
                                                                        ]),
                                                                    // Container(
                                                                    //   padding: EdgeInsets
                                                                    //       .symmetric(
                                                                    //           vertical:
                                                                    //               7),
                                                                    //   child: RatingBar
                                                                    //       .builder(
                                                                    //     ignoreGestures:
                                                                    //         true,
                                                                    //     initialRating:
                                                                    //         double.parse(
                                                                    //             filteredSp[index]['rating'].toString()),
                                                                    //     minRating:
                                                                    //         1,
                                                                    //     direction: Axis
                                                                    //         .horizontal,
                                                                    //     itemSize:
                                                                    //         15,
                                                                    //     allowHalfRating:
                                                                    //         true,
                                                                    //     itemCount:
                                                                    //         5,
                                                                    //     itemPadding:
                                                                    //         EdgeInsets.symmetric(
                                                                    //             horizontal:
                                                                    //                 1.0),
                                                                    //     itemBuilder:
                                                                    //         (context,
                                                                    //                 _) =>
                                                                    //             Icon(
                                                                    //       Icons
                                                                    //           .star,
                                                                    //       color: Colors
                                                                    //           .amber,
                                                                    //     ),
                                                                    //     onRatingUpdate:
                                                                    //         (double
                                                                    //             value) {},
                                                                    //   ),
                                                                    // ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      // decoration:
                                                                      //     BoxDecoration(
                                                                      //         border: Border
                                                                      //             .all(
                                                                      //           color:
                                                                      //               Colors.amber,
                                                                      //         ),
                                                                      //         borderRadius:
                                                                      //             BorderRadius.all(Radius.circular(20))),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                              // padding:
                                                                              //     EdgeInsets.all(2),
                                                                              // decoration: BoxDecoration(
                                                                              //     color:
                                                                              //         Colors.amber,
                                                                              //     borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              // child:
                                                                              // //     Icon(
                                                                              // //   Icons
                                                                              // //       .check,
                                                                              // //   size:
                                                                              // //       13,
                                                                              // // ),
                                                                              ),

                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 5),
                                                                            // child: Text(
                                                                            //     'Address: ' +
                                                                            //         'asfdddddddddddddddddddddddddddddddddddddddddddddddddd',
                                                                            //     textAlign:
                                                                            //         TextAlign.justify,
                                                                            //     overflow: TextOverflow.ellipsis,
                                                                            //     // maxLines: 4,
                                                                            //     // overflow: TextOverflow.ellipsis,
                                                                            //     // textDirection: TextDirection.rtl,
                                                                            //     // textAlign: TextAlign.justify,
                                                                            //     style: TextStyle(
                                                                            //       fontSize: 12,
                                                                            //       fontWeight: FontWeight.w600,
                                                                            //     )),
                                                                          ),
                                                                          // Expanded(
                                                                          //   child:
                                                                          //       Text(
                                                                          //     'a long text',
                                                                          //     overflow:
                                                                          //         TextOverflow.clip,
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ),
                                                            Spacer(),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  " ${filteredSp[index]['price']} ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "Beds Available",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Text(
                                                                            "Coming soon",
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.black),
                                                                          );
                                                                          // return SpDetails(
                                                                          //     spId: filteredSp[index]
                                                                          //         [
                                                                          //         "serviceProviderId"]);
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    // child: Text(
                                                                    //   "More Info",
                                                                    //   style: TextStyle(
                                                                    //       fontSize:
                                                                    //           12,
                                                                    //       fontWeight:
                                                                    //           FontWeight
                                                                    //               .w600,
                                                                    //       color: Color(
                                                                    //           0xFF3f51b5)),
                                                                    // ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      if (filteredSp[index]
                                                              ['address'] !=
                                                          null)
                                                        Container(
                                                          child: Text(
                                                            "Address: " +
                                                                filteredSp[
                                                                        index]
                                                                    ['address'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 5,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      Divider(),

                                                      // if (filteredSp[index]
                                                      //         ["offerings"].length !=
                                                      //     0)
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .center,
                                                      //   children: [
                                                      //     Text(
                                                      //       'Regular Beds: ' +
                                                      //           filteredSp[index][
                                                      //                           "offerings"]
                                                      //                       [
                                                      //                       'regularBed']
                                                      //                   [
                                                      //                   'available']
                                                      //               .toString(),
                                                      //       style: TextStyle(
                                                      //           fontSize: 10),
                                                      //     ),
                                                      //     SizedBox(
                                                      //       width: 40,
                                                      //     ),
                                                      //     Text(
                                                      //       'Oxygen Beds: ' +
                                                      //           filteredSp[index][
                                                      //                           "offerings"]
                                                      //                       [
                                                      //                       'oxygenBed']
                                                      //                   [
                                                      //                   'available']
                                                      //               .toString(),
                                                      //       style: TextStyle(
                                                      //           fontSize: 10),
                                                      //     ),
                                                      //     SizedBox(
                                                      //       width: 40,
                                                      //     ),
                                                      //     Text(
                                                      //       'ICU Beds: ' +
                                                      //           filteredSp[index][
                                                      //                           "offerings"]
                                                      //                       [
                                                      //                       'icuBed']
                                                      //                   [
                                                      //                   'available']
                                                      //               .toString(),
                                                      //       style: TextStyle(
                                                      //           fontSize: 10),
                                                      //     ),
                                                      //     SizedBox(
                                                      //       width: 5,
                                                      //     ),
                                                      //     // ImageIcon(
                                                      //     //   AssetImage(
                                                      //     //       "assets/premium.png"),
                                                      //     //   size: 10,
                                                      //     // ),
                                                      //   ],
                                                      // )
                                                      if (filteredSp[index]
                                                                  ["offerings"]
                                                              .length !=
                                                          0)
                                                        Directionality(
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          child:
                                                              GridView.builder(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  shrinkWrap:
                                                                      true,
                                                                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          2,
                                                                      childAspectRatio:
                                                                          6 / 1,
                                                                      crossAxisSpacing:
                                                                          0,
                                                                      mainAxisSpacing:
                                                                          0),
                                                                  itemCount: filteredSp[
                                                                              index]
                                                                          [
                                                                          "offerings"]
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              ctx,
                                                                          i) {
                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          filteredSp[index]["offerings"][i]["label"] +
                                                                              ": " +
                                                                              filteredSp[index]["offerings"][i]["value"]["vacant"].toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 10),
                                                                        ),

                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        // ImageIcon(
                                                                        //   AssetImage(
                                                                        //       "assets/premium.png"),
                                                                        //   size: 10,
                                                                        // ),
                                                                      ],
                                                                    );
                                                                  }),
                                                        ),
                                                    ]),
                                                  )),
                                            );
                                          }),
                                    ]);
                    })),
          ),
        ));
  }

  void _showReviews() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This service provider is almost alaways on time!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3f51b5)),
                ),
                box10,
                Container(height: 5, width: 50, color: Color(0xFF3f51b5)),
                box10,
                Text(
                    "Reviews show that this service provider almost always runs on schedule."),
                box10,
                Text(
                  "We still recommend that you check the latest reviews by tapping on the ratings.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OKAY',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3f51b5)),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          );
        });
  }
}

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}
