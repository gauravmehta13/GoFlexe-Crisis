import 'package:crisis/Constants.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/TextFieldSearch.dart';
import 'package:crisis/model/StateDistrict%20Model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Fade Route.dart';
import 'ListNGO.dart';

class NGO extends StatefulWidget {
  @override
  _NGOState createState() => _NGOState();
}

class _NGOState extends State<NGO> {
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

  Future<List> fetchStates() async {
    return states?.states ?? [];
  }

  Future<List> fetchDistricts() async {
    await Future.delayed(Duration(milliseconds: 30));
    return districts?.districts ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NGO's",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: loading == true
          ? Loading()
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(height: 100, child: Image.asset("assets/ngo.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Find NGO's near you",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                    ),
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
                        labelText: 'Select State',
                      ),
                      controller: stateController,
                      initialList: states.states,
                      future: () {
                        return fetchStates();
                      },
                      getSelectedValue: (state) {
                        final FocusScopeNode currentScope =
                            FocusScope.of(context);
                        if (!currentScope.hasPrimaryFocus &&
                            currentScope.hasFocus) {
                          FocusManager.instance.primaryFocus.unfocus();
                        }

                        setState(() {
                          stateName = state.label;
                        });

                        print(state.label);
                        print(state
                            .value); // this prints the selected option which could be an object
                      },
                      label: '',
                    )),
                    box10,
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
                          onPressed: stateName.isEmpty
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                        page: NgoList(
                                      stateName: stateName,
                                    )),
                                  );
                                },
                          child: Text(
                            "Find NGO",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
