import 'dart:convert';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants.dart';
import 'package:intl/date_symbol_data_local.dart';

class NgoList extends StatefulWidget {
  final stateName;
  NgoList({this.stateName});
  @override
  _NgoListState createState() => _NgoListState();
}

class _NgoListState extends State<NgoList> {
  var dio = Dio();
  var data = [];
  var filteredData = [];
  bool loading = true;
  DateTime now = new DateTime.now();

  void initState() {
    super.initState();
    getCenters();
    FirebaseAnalytics().logEvent(name: "NGO's", parameters: null);
  }

  getCenters() async {
    var resp = await dio.post(
        'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
        data: {
          'tenantSet_id': 'CRISIS01',
          'tenantUsecase': 'crisis',
          'useCase': 'ngo',
          'state': widget.stateName.toString().toLowerCase()
        });
    print(resp);
    Map<String, dynamic> map = json.decode(resp.toString());
    setState(() {
      data = map['resp']['allPrices']['res'];
      filteredData = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NGO's in ${widget.stateName}",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: loading == true
                ? Loading()
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
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "No NGO's available in your Area",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18),
                            ),
                            box30,
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
                                        .where((u) => (u["nameOfNGO"]
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFF2821B5),
                                    ),
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.grey)),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Search..",
                                ),
                              ),
                            ),
                            box30,
                            filteredData.length == 0
                                ? NoResult()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: filteredData.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          FirebaseAnalytics().logEvent(
                                              name: 'Called_NGO',
                                              parameters: null);
                                          filteredData[index]["phn"] != null
                                              ? launch('tel:' +
                                                  filteredData[index]["phn"])
                                              : displaySnackBar(
                                                  "Contact No. Unavailable",
                                                  context);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          shape: new RoundedRectangleBorder(
                                              side: new BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/NGObadge.png",
                                                          width: 50,
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                      filteredData[index]
                                                                              [
                                                                              "nameOfNGO"] ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                ),
                                                              ],
                                                            ),
                                                            box10,
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  Icons.phone,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    filteredData[index]["phn"] !=
                                                                            null
                                                                        ? filteredData[index]["phn"].replaceAll(
                                                                            new RegExp(
                                                                                r"\s+\b|\b\s"),
                                                                            "")
                                                                        : "NA",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                      fontSize:
                                                                          12,
                                                                    )),
                                                              ],
                                                            ),
                                                            box10,
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
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
                                                  ],
                                                ),
                                              ),
                                              if (filteredData[index]["sector"]
                                                      .length !=
                                                  0)
                                                Container(
                                                  height: 30,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        filteredData[index]
                                                                ["sector"]
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int i) {
                                                      return new Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          side: BorderSide(
                                                            color: primaryColor,
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Center(
                                                              child: Text(
                                                            filteredData[index]
                                                                ["sector"][i],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              box5
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                          ],
                        ),
                      )));
  }
}
