import 'dart:async';

import 'package:crisis/HomePage/symptoms.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  int _activeMeterIndex = 0;
  Timer _timer;

  List<Symptoms> symptoms;
  bool expanded = false;

  void initState() {
    super.initState();
    if (_activeMeterIndex == 0) {
      load();
    }

    symptoms = Symptoms.getSymptoms();
  }

  load() {
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _activeMeterIndex = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                    height: 100, child: Image.asset("assets/symptoms.png")),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ExpansionPanelList(
                    dividerColor: Colors.amber,
                    expansionCallback: (int index, bool status) {
                      setState(() {
                        _activeMeterIndex = _activeMeterIndex == 0 ? null : 0;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: Color(0xFFeceef8),
                        isExpanded: _activeMeterIndex == 0,
                        headerBuilder:
                            (BuildContext context, bool isExpanded) => Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ImageIcon(
                              AssetImage("assets/fever.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("List of symptoms"),
                          ],
                        ),
                        canTapOnHeader: true,
                        body: IgnorePointer(
                          child: Container(
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: symptoms.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(symptoms[i].heading,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                              Container(
                                                  child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    symptoms[i].symptoms.length,
                                                itemBuilder: (context, j) {
                                                  return Text(
                                                    "     • ${symptoms[i].symptoms[j]}",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                  );
                                                },
                                              )),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      },
                                    ))
                                  ])),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
