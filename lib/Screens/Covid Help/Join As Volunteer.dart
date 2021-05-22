import 'dart:convert';

import 'package:crisis/Auth/In%20App%20Register.dart';
import 'package:crisis/Constants.dart';
import 'package:crisis/data/Districts.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Fade Route.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class VolunteerJoin extends StatefulWidget {
  @override
  _VolunteerJoinState createState() => _VolunteerJoinState();
}

class _VolunteerJoinState extends State<VolunteerJoin> {
  final ScrollController scrollController = ScrollController();
  List<StateDistrictMapping> districtMapping = [];
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  String districtName = "";
  String stateName = "";
  bool panIndia = false;
  void initState() {
    super.initState();
    if (_auth.currentUser == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          FadeRoute(
              page: InAppRegister(
            screenName: "Volunteer",
          )),
        );
      });
    }

    districtMapping = StateDistrictMapping.getDsitricts();
    if (_auth.currentUser != null) {
      phoneController.text = _auth.currentUser.phoneNumber.substring(3, 13);
    }
    FirebaseAnalytics().logEvent(name: 'Join_As_Volunteer', parameters: null);
  }

  scrollToTop() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  registerVolunteer() async {
    var dio = Dio();
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            "tenantSet_id": "CRISIS01",
            "useCase": "register",
            "tenantUsecase": "register",
            "phone": _auth.currentUser.phoneNumber,
            "email": "",
            "name": nameController.text,
            "state": stateName,
            "city": districtName,
            "panIndia": panIndia.toString()
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      displayTimedSnackBar("Registration Successful", context, 2);
    } catch (e) {
      displayTimedSnackBar("Error, Please try again later..!!", context, 2);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFf9a825), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () async {
                registerVolunteer();
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            )),
      ),
      appBar: AppBar(
        title: Text(
          "Covid Help - Volunteer Form",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 80, child: Image.asset("assets/charity.png")),
              SizedBox(
                height: 10,
              ),
              Text(
                "Join the war against COVID-19",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              box10,
              Text(
                "Register as Volunteer",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              box10,
              Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFc1f0dc),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "As per need, you will be contacted via SMS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2f7769),
                        fontSize: 12,
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              new TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.addressCard),
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF2821B5),
                      ),
                    ),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey[200])),
                    labelText: "Full Name*"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              box20,
              new TextFormField(
                textInputAction: TextInputAction.next,
                controller: phoneController,
                decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF2821B5),
                      ),
                    ),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey[200])),
                    labelText: "Mobile Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              box20,
              Column(
                children: [
                  Column(
                    children: [
                      Autocomplete<StateDistrictMapping>(
                        displayStringForOption: (option) => option.district,
                        fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) =>
                            TextField(
                          scrollPadding: const EdgeInsets.only(bottom: 150.0),
                          controller: textEditingController,
                          onTap: () {
                            textEditingController.clear();
                            setState(() {
                              stateName = "";
                            });
                          },
                          focusNode: focusNode,
                          decoration: new InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.city),
                              isDense: true, // Added this
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
                                  borderSide:
                                      new BorderSide(color: Colors.grey[200])),
                              labelText: "Select City"),
                        ),
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return districtMapping;
                          }
                          return districtMapping.where((s) {
                            return s.district
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (StateDistrictMapping selection) {
                          final FocusScopeNode currentScope =
                              FocusScope.of(context);
                          if (!currentScope.hasPrimaryFocus &&
                              currentScope.hasFocus) {
                            FocusManager.instance.primaryFocus.unfocus();
                          }
                          print(selection.district);
                          print(selection.districtID);
                          setState(() {
                            districtName = selection.district.toString();
                            stateName = selection.state.toString();
                          });
                          scrollToTop();
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerRight,
                          child: Text(stateName ?? ""))
                    ],
                  ),
                  box20,
                  CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    title: const Text(
                      'I am ready to help PAN India',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    activeColor: Color(0xFF3f51b5),
                    checkColor: Colors.white,
                    selected: panIndia,
                    value: panIndia,
                    onChanged: (bool value) {
                      setState(() {
                        panIndia = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
