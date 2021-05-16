import 'dart:convert';

import 'package:crisis/Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants.dart';
import 'package:intl/date_symbol_data_local.dart';

class DiagnosticCenters extends StatefulWidget {
  final distrctName;
  final stateName;
  DiagnosticCenters({this.distrctName, this.stateName});
  @override
  _DiagnosticCentersState createState() => _DiagnosticCentersState();
}

class _DiagnosticCentersState extends State<DiagnosticCenters> {
  var dio = Dio();
  var data = [];
  var filteredData = [];
  bool loading = true;
  DateTime now = new DateTime.now();

  void initState() {
    super.initState();
    getCenters();
    initializeDateFormatting('en', null);
    initializeDateFormatting('en_US,', null);
  }

  getCenters() async {
    var resp = await dio.post(
        'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
        data: {
          'tenantSet_id': 'CRISIS01',
          'tenantUsecase': 'CRISIS01',
          'useCase': 'diagnostic',
          'state': widget.stateName,
          'district': widget.distrctName
        });
    print(resp);
    Map<String, dynamic> map = json.decode(resp.toString());
    setState(() {
      data = map['resp']['allPrices'];
      filteredData = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Diagnostic Centers in ${widget.distrctName}",
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
                              "No Centers available in your Area",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18),
                            ),
                            box30,
                          ],
                        ),
                      )
                    : SingleChildScrollView(
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
                                        .where((u) => (u["centre"]
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
                            ListView.builder(
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2,
                                    shape: new RoundedRectangleBorder(
                                        side: new BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/examination.png",
                                            width: 50,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            filteredData[index][
                                                                    "centre"] ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_pin,
                                                        size: 18,
                                                        color: Colors.grey,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            filteredData[index][
                                                                    'address'] ??
                                                                "",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontSize: 11,
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
                                  );
                                }),
                          ],
                        ),
                      )));
  }
}
