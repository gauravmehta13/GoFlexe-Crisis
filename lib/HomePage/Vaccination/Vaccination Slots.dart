import 'dart:convert';

import 'package:crisis/Auth/In%20App%20Register.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:crisis/Widgets/error404.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants.dart';

import '../../Fade Route.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class VaccinationSlots extends StatefulWidget {
  final pin;
  final bool district;
  final districtId;
  final distrctName;
  VaccinationSlots(
      {this.pin, this.district, this.districtId, this.distrctName});
  @override
  _VaccinationSlotsState createState() => _VaccinationSlotsState();
}

class _VaccinationSlotsState extends State<VaccinationSlots> {
  var dio = Dio();
  var data = [];
  var filteredData = [];
  bool loading = true;
  bool error = false;
  int totalSlots = 0;
  DateTime now = new DateTime.now();

  void initState() {
    super.initState();
    getSlot();
    FirebaseAnalytics().logEvent(name: 'Vaccination_Centers', parameters: null);
  }

  submitVaccinationRequest() async {
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            "tenantSet_id": "CRISIS01",
            "useCase": "registerVaccine",
            "tenantUsecase": "register",
            "phone": _auth.currentUser.phoneNumber.substring(3, 13),
            "pincode": widget.pin,
            "district": widget.districtId
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      displayTimedSnackBar(map["resp"]["allPrices"], context, 2);
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  getSlot() async {
    try {
      if (widget.district == false) {
        var resp = await dio.get(
            "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=${widget.pin}&date=${now.day.toString()}-${now.month.toString()}-${now.year.toString()}");
        print(resp.data);
        var tempData = resp.data["centers"];
        for (var i = 0; i < tempData.length; i++) {
          int x = 0;

          for (var j = 0; j < tempData[i]["sessions"].length; j++) {
            setState(() {
              x = x + tempData[i]["sessions"][j]["available_capacity"];
            });
          }
          setState(() {
            tempData[i]["slots"] = x;
            totalSlots = totalSlots + x;
          });
        }
        print(totalSlots);

        tempData.sort(
            (b, a) => a["slots"].toString().compareTo(b["slots"].toString()));
        setState(() {
          data = tempData;
          filteredData = tempData;
        });
      } else {
        var resp = await dio.get(
            "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=${widget.districtId}&date=${now.day.toString()}-${now.month.toString()}-${now.year.toString()}");
        print(resp.data);
        var tempData = resp.data["centers"];
        for (var i = 0; i < tempData.length; i++) {
          int x = 0;

          for (var j = 0; j < tempData[i]["sessions"].length; j++) {
            setState(() {
              x = x + tempData[i]["sessions"][j]["available_capacity"];
            });
          }
          setState(() {
            tempData[i]["slots"] = x;
            totalSlots = totalSlots + x;
          });
        }
        print(totalSlots);

        tempData.sort(
            (b, a) => a["slots"].toString().compareTo(b["slots"].toString()));
        setState(() {
          data = tempData;
          filteredData = tempData;
        });
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: filteredData.length == 0
            ? Container(
                height: 0,
              )
            : Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
                child: totalSlots == 0
                    ? SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFf9a825), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            if (_auth.currentUser == null) {
                              Navigator.push(
                                context,
                                FadeRoute(
                                    page: InAppRegister(
                                  screenName: "Vaccination",
                                  district: widget.distrctName,
                                  districtCode: widget.districtId,
                                  pincode: widget.pin,
                                )),
                              );
                            } else {
                              submitVaccinationRequest();
                            }
                          },
                          child: Text(
                            "Notify me when slots are available",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFf9a825), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            await launch(
                                "https://selfregistration.cowin.gov.in/");
                          },
                          child: Text(
                            "Book on CoWin",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
              ),
        appBar: AppBar(
          title:
              Text(widget.district == true ? widget.distrctName : widget.pin),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: loading == true
                ? Loading()
                : error == true
                    ? Error404()
                    : data.length == 0
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 100,
                                    child: Image.asset("assets/anxiety.png")),
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
                                  "No slots available at the moment",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 18),
                                ),
                                box30,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color(0xFFf9a825), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () async {
                                          if (_auth.currentUser == null) {
                                            Navigator.push(
                                              context,
                                              FadeRoute(
                                                  page: InAppRegister(
                                                screenName: "Vaccination",
                                                district: widget.distrctName,
                                                districtCode: widget.districtId,
                                                pincode: widget.pin,
                                              )),
                                            );
                                          } else {
                                            submitVaccinationRequest();
                                          }
                                        },
                                        child: Text(
                                          "Notify me when slots are available",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                box20,
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: new TextFormField(
                                    textInputAction: TextInputAction.go,
                                    onChanged: (string) {
                                      setState(() {
                                        filteredData = (data)
                                            .where((u) => (u['name']
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                        string.toLowerCase()) ||
                                                u['address']
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                        string.toLowerCase())))
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
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Search..",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Disclaimer : While we have real-time data, slot availability on CoWin changes rapidly. If you see availability, please book on CoWin instantly before the slots are lost.",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[700]),
                                  ),
                                ),
                                filteredData.length == 0
                                    ? NoResult()
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filteredData.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 2,
                                            shape: new RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: ExpansionTile(
                                                tilePadding:
                                                    EdgeInsets.only(right: 5),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                filteredData[
                                                                            index]
                                                                        [
                                                                        'name'] ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            SizedBox(
                                                              height: 7,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                      filteredData[index]
                                                                              [
                                                                              'address'] ??
                                                                          "",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey[700],
                                                                        fontSize:
                                                                            11,
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: filteredData[index]
                                                                            [
                                                                            "slots"] !=
                                                                        0
                                                                    ? filteredData[index]["slots"] >
                                                                            3
                                                                        ? Colors.green[
                                                                            200]
                                                                        : Colors.orangeAccent[
                                                                            200]
                                                                    : Colors.grey[
                                                                        200],
                                                                border: Border.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            5))),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              // "${filteredData[index]["fee_type"]}",
                                                              "${filteredData[index]["slots"]} Slots",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                          .grey[
                                                                      900],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "${filteredData[index]["fee_type"]}",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                          .grey[
                                                                      900],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                children: <Widget>[
                                                  IgnorePointer(
                                                    child: Container(
                                                        child: Table(
                                                            border:
                                                                TableBorder.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                            children: [
                                                          TableRow(children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "Date",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "Vaccine",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "Available",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          ])
                                                        ])),
                                                  ),
                                                  IgnorePointer(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            filteredData[index]
                                                                    ["sessions"]
                                                                .length,
                                                        itemBuilder:
                                                            (context, j) {
                                                          return Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        0),
                                                            child: Table(
                                                              border: TableBorder.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300]),
                                                              children: [
                                                                TableRow(
                                                                    decoration: new BoxDecoration(
                                                                        color: filteredData[index]["sessions"][j]["available_capacity"] ==
                                                                                0
                                                                            ? Colors.grey[200]
                                                                            : Colors.green[200]),
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          child: Text(
                                                                              filteredData[index]["sessions"][j]["date"] ?? "",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          child: Text(
                                                                              filteredData[index]["sessions"][j]["vaccine"] ?? "",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          child: Text(
                                                                              filteredData[index]["sessions"][j]["available_capacity"].toString() ?? "",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ])
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ]),
                                          );
                                        }),
                              ],
                            ),
                          )));
  }
}
