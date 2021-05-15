import 'dart:convert';

import 'package:crisis/Constants.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
        // [AppBar] with 0 size used to set the statusbar background color and
        // statusbat text/icon color
        appBar: AppBar(
          title: Text("FAQ's"),
        ),
        body: loading == true
            ? Loading()
            : SafeArea(
                child: SingleChildScrollView(
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
                                        .toLowerCase()
                                        .contains(string.toLowerCase()) ||
                                    u["description"]
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF2821B5),
                            ),
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
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
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredFAQ.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.question_answer,
                                    color: Color(0xFF9fa8da),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    filteredFAQ[i]["title"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                  child: Text(
                                    filteredFAQ[i]["description"],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[700]),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ))));
  }
}
