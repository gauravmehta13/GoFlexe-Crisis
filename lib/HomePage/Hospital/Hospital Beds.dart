import 'dart:convert';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:crisis/model/app_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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

  void initState() {
    super.initState();
    FirebaseAnalytics()
        .logEvent(name: 'Hospital_Bed_Centers', parameters: null);
  }

  getSP(items) async {
    print(items);
    var resp = await dio.post(
        'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
        data: {
          'tenantSet_id': 'CRISIS01',
          'tenantUsecase': 'CRISIS01',
          'useCase': 'hospital',
          'state': items['stateName'],
          'district': items['districtName']
        });
    print(resp);
    Map<String, dynamic> map = json.decode(resp.toString());
    spList = map['resp']['allPrices'];
    tempList = map['resp']["allPrices"];

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
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: MyAppBar(curStep: 0)),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.all(10),
                child: StoreConnector<AppState, AppState>(
                    onInit: (store) {
                      Map city = {
                        "stateName": store.state.stateName,
                        "districtName": store.state.districtName,
                        "usecase": store.state.usecase
                      };
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
                          : spList.length == 0
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
                                        "No Hospital Beds Available at the moment",
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
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(string
                                                              .toLowerCase()) ||
                                                      u['address']
                                                          .toString()
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
                                      filteredSp.length == 0
                                          ? NoResult()
                                          : ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: filteredSp.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            side: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .grey)),
                                                    elevation: 2,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
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
                                                                        filteredSp[index]['name']
                                                                            .trim(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.grey[800]),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          launch('tel:' +
                                                                              filteredSp[index]['mobile']);
                                                                        },
                                                                        child: Row(
                                                                            children: [
                                                                              Icon(Icons.phone, color: Colors.grey[600], size: 12),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                (filteredSp[index]['mobile'] != null ? filteredSp[index]['mobile'] : 'NA'),
                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey[600]),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
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
                                                                              (BuildContext context) {
                                                                            return Text(
                                                                              "Coming soon",
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
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
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_pin,
                                                                size: 18,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  filteredSp[index]
                                                                          [
                                                                          'address'] ??
                                                                      "NA",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                              .grey[
                                                                          700]),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        if (filteredSp[index][
                                                                    "offerings"]
                                                                .length !=
                                                            0)
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/hospitalBed.png",
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    100,
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                5),
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                2,
                                                                            childAspectRatio: 6 /
                                                                                1,
                                                                            crossAxisSpacing:
                                                                                0,
                                                                            mainAxisSpacing:
                                                                                0),
                                                                        itemCount:
                                                                            filteredSp[index]["offerings"]
                                                                                .length,
                                                                        itemBuilder:
                                                                            (BuildContext ctx,
                                                                                i) {
                                                                          return Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                filteredSp[index]["offerings"][i]["label"],
                                                                                style: TextStyle(color: Colors.grey[900], fontSize: 13),
                                                                              ),
                                                                              Text(
                                                                                " : ",
                                                                                style: TextStyle(color: Colors.grey[900], fontSize: 13),
                                                                              ),
                                                                              Text(
                                                                                filteredSp[index]["offerings"][i]["value"]["vacant"].toString(),
                                                                                style: TextStyle(color: Colors.grey[900], fontSize: 13),
                                                                              )
                                                                            ],
                                                                          );
                                                                        }),
                                                              ),
                                                            ],
                                                          ),
                                                      ]),
                                                    ));
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
