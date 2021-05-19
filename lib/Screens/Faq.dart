import 'dart:convert';

import 'package:crisis/Constants.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  // final List<Item> _data = generateItems(8)

  List filteredFAQ = [];
  List faqData = [];
  var dio = Dio();
  bool loading = true;

  void initState() {
    super.initState();
    getFaq();
    FirebaseAnalytics().logEvent(name: 'FAQs', parameters: null);
  }

  getFaq() async {
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            'tenantSet_id': 'CRISIS01',
            'tenantUsecase': 'CRISIS01',
            "useCase": "tips",
            "type": "faq",
            //mythbusters
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      print(map);

      setState(() {
        faqData = map["resp"];
        filteredFAQ = faqData;
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
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            "FAQ's",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 16),
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
                                  filteredFAQ = (faqData)
                                      .where((u) => (u["title"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          u["description"]
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
                                hintText: "Search FAQ's..",
                              ),
                            ),
                          ),
                          box20,
                          filteredFAQ.length == 0
                              ? NoResult()
                              : GroupedListView<dynamic, String>(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  elements: filteredFAQ,
                                  groupBy: (element) => element["category"],
                                  // groupComparator: (value1, value2) =>
                                  //     value2.compareTo(value1),
                                  // itemComparator: (item1, item2) =>
                                  //     item2.name.compareTo(item1.name),
                                  // optional
                                  useStickyGroupSeparators: true, // optional
                                  // floatingHeader: true, // optional
                                  // order: GroupedListOrder.ASC,
                                  groupSeparatorBuilder: (String value) =>
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 15),
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                  itemBuilder: (c, element) {
                                    return Card(
                                      child: Container(
                                        // margin: EdgeInsets.only(bottom: 15),
                                        child: ExpansionTile(
                                          title: Row(
                                            children: [
                                              Icon(
                                                Icons.question_answer,
                                                color: Color(0xFF9fa8da),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      element["title"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  bottom: 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Text(element[
                                                          "description"]),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  element["textBottom"] != ''
                                                      ? Text(
                                                          element["textBottom"])
                                                      : Container(),
                                                  element["url"] != ''
                                                      ? Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                                height: 10),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: InkWell(
                                                                child: Text(
                                                                    'Know more',
                                                                    style: TextStyle(
                                                                        color:
                                                                            primaryColor,
                                                                        decoration:
                                                                            TextDecoration.underline)),
                                                                onTap: () =>
                                                                    _launchUrl(
                                                                        element[
                                                                            "url"]),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    ))));
  }
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
