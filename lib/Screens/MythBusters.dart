import 'dart:convert';

import 'package:crisis/Constants.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class MythBusters extends StatefulWidget {
  @override
  _MythBustersState createState() => _MythBustersState();
}

class _MythBustersState extends State<MythBusters> {
  List filteredMyth = [];
  List mythBusterData = [];
  var dio = Dio();
  bool loading = true;

  void initState() {
    super.initState();
    getMyths();
    FirebaseAnalytics().logEvent(name: 'MythBusters', parameters: null);
  }

  getMyths() async {
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            'tenantSet_id': 'CRISIS01',
            'tenantUsecase': 'CRISIS01',
            "useCase": "tips",
            "type": "mythbusters",
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      print(map);

      setState(() {
        mythBusterData = map["resp"];
        filteredMyth = mythBusterData;
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // [AppBar] with 0 size used to set the statusbar background color and
        // statusbat text/icon color
        appBar: AppBar(
          title: Text(
            "MythBusters",
          ),
        ),
        body: loading == true
            ? Loading()
            : SafeArea(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new TextFormField(
                              textInputAction: TextInputAction.go,
                              onChanged: (string) {
                                setState(() {
                                  filteredMyth = (mythBusterData)
                                      .where((u) => (u["myth"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          u["fact"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(string.toLowerCase())))
                                      .toList();
                                });
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                hintText: "Search Myths..",
                              ),
                            ),
                          ),
                          box20,
                          filteredMyth.length == 0
                              ? NoResult()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: filteredMyth.length,
                                  itemBuilder: (context, i) {
                                    return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.orangeAccent[100],
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "MYTH :",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    filteredMyth[i]["myth"],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.green,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Center(
                                                        child: RotatedBox(
                                                            quarterTurns: 3,
                                                            child: Text(
                                                              "Fact",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )),
                                                      )),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      constraints:
                                                          BoxConstraints(
                                                        minHeight:
                                                            50, //minimum height
                                                      ),
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 5, 0, 5),
                                                        child: Text(
                                                          filteredMyth[i]
                                                              ["fact"],
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                                  }),
                        ],
                      ),
                    ))));
  }
}
