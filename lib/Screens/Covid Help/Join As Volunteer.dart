import 'dart:convert';

import 'package:crisis/Auth/In%20App%20Register.dart';
import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/HomePage.dart';
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
  final volunteerKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  List<StateDistrictMapping> districtMapping = [];
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  bool registrationDone = false;
  List<String> cityNames = [];
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
            "useCase": "registerVolunteer",
            "tenantUsecase": "register",
            "phone": phoneController.text,
            "name": nameController.text,
            "city": cityNames,
            "state": stateName,
            "panIndia": panIndia.toString()
          });
      print(response);
      setState(() {
        registrationDone = true;
      });
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
            child: registrationDone
                ? MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(0xFFf9a825),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                    child: Text(
                      "Return to Home Screen",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFf9a825), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      if (volunteerKey.currentState.validate()) {
                        registerVolunteer();
                      }
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
      body: Form(
        key: volunteerKey,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.maxFinite,
            child: registrationDone
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset(
                        "assets/check.png",
                        height: 100,
                      ),
                      box30,
                      Text(
                        "Registration Successful",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      box20,
                      Text(
                        "You will get an SMS when patients from your city\nwill need any help.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 80, child: Image.asset("assets/charity.png")),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Join the war against COVID-19",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      box10,
                      Text(
                        "Register as Volunteer",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.addressCard),
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
                            labelText: "Full Name*"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      box20,
                      new TextFormField(
                        enabled: _auth.currentUser != null ? false : true,
                        style: TextStyle(color: Colors.grey),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        controller: phoneController,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone),
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
                            labelText: "Mobile Number"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      box10,
                      if (cityNames.length != 0)
                        new GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 1, crossAxisCount: 3),
                          itemCount: cityNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                cityNames.removeAt(index);
                                setState(() {});
                              },
                              child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: primaryColor,
                                    width: 0.5,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  cityNames[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                )),
                              ),
                            );
                          },
                        ),
                      box20,
                      Autocomplete<StateDistrictMapping>(
                        displayStringForOption: (option) => option.district,
                        fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) =>
                            TextFormField(
                          // autovalidateMode:
                          //     AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          scrollPadding: const EdgeInsets.only(bottom: 200.0),
                          controller: textEditingController,
                          onTap: () {
                            textEditingController.clear();
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
                              labelText: "Select Cities"),
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
                          cityNames.add(selection.district);
                          print(selection.district);
                          print(selection.districtID);
                          setState(() {
                            districtName = selection.district.toString();
                            stateName = selection.state.toString();
                          });
                          scrollToTop();
                        },
                      ),
                      box20,
                      CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0),
                        title: const Text(
                          'I am ready to help PAN India',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
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
          ),
        ),
      ),
    );
  }
}
