import 'package:crisis/Constants.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/TextFieldSearch.dart';
import 'package:crisis/model/StateDistrict%20Model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Fade Route.dart';
import 'Diagnostic Centers.dart';

class Diagnostic extends StatefulWidget {
  @override
  _DiagnosticState createState() => _DiagnosticState();
}

class _DiagnosticState extends State<Diagnostic> {
  var dio = Dio();
  TextEditingController stateController;
  TextEditingController districtController;
  void initState() {
    super.initState();
    stateController = TextEditingController();
    districtController = TextEditingController();
    getStates();
  }

  bool loading = true;
  bool districtLoading = false;
  String districtName = "";
  String stateName = "";

  States states;
  District districts;
  getStates() async {
    var resp =
        await dio.get("https://cdn-api.co-vin.in/api/v2/admin/location/states");

    setState(() {
      states = States.fromJson(resp.data);
      loading = false;
    });
    print(states.toString());
    print(states.states[0].label);
  }

  getDistricts(id) async {
    setState(() {
      districtLoading = true;
    });
    var resp = await dio
        .get("https://cdn-api.co-vin.in/api/v2/admin/location/districts/$id");

    setState(() {
      districts = District.fromJson(resp.data);
      districtLoading = false;
    });
    print(districts.toString());
    print(districts.districts[0].label);
  }

  Future<List> fetchStates() async {
    return states?.states ?? [];
  }

  Future<List> fetchDistricts() async {
    await Future.delayed(Duration(milliseconds: 30));
    return districts?.districts ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Column(
            children: [
              Container(
                  child: TextFieldSearch(
                minStringLength: 0,
                decoration: new InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFF2821B5),
                    ),
                  ),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey)),
                  labelText: 'Search State',
                ),
                controller: stateController,
                initialList: states.states,
                future: () {
                  return fetchStates();
                },
                getSelectedValue: (state) {
                  final FocusScopeNode currentScope = FocusScope.of(context);
                  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                    FocusManager.instance.primaryFocus.unfocus();
                  }
                  getDistricts(state.value);
                  setState(() {
                    stateName = state.label;
                  });
                  setState(() {
                    districtController.text = "";
                  });
                  print(state.label);
                  print(state
                      .value); // this prints the selected option which could be an object
                },
                label: '',
              )),
              box10,
              districtLoading == true
                  ? LinearProgressIndicator(
                      backgroundColor: Color(0xFF3f51b5),
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xFFf9a825),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFieldSearch(
                          minStringLength: 0,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF2821B5),
                              ),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            labelText: 'Search District',
                          ),
                          label: 'Enter District',
                          controller: districtController,
                          initialList: districts?.districts ?? [],
                          future: () {
                            return fetchDistricts();
                          },
                          getSelectedValue: (state) {
                            final FocusScopeNode currentScope =
                                FocusScope.of(context);
                            if (!currentScope.hasPrimaryFocus &&
                                currentScope.hasFocus) {
                              FocusManager.instance.primaryFocus.unfocus();
                            }
                            setState(() {
                              districtName = state.label;
                            });
                            print(state.label);
                            print(state
                                .value); // this prints the selected option which could be an object
                          })),
              box30,
              box30,
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFf9a825), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: districtName.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                  page: DiagnosticCenters(
                                stateName: stateName,
                                distrctName: districtName,
                              )),
                            );
                          },
                    child: Text(
                      "Find Diagnostic Center",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
