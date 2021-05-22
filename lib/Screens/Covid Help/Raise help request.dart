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

class RaiseHelpRequest extends StatefulWidget {
  @override
  _RaiseHelpRequestState createState() => _RaiseHelpRequestState();
}

class _RaiseHelpRequestState extends State<RaiseHelpRequest> {
  final ScrollController scrollController = ScrollController();
  List<StateDistrictMapping> districtMapping = [];
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var helpController = TextEditingController();

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
            screenName: "Help",
          )),
        );
      });
    }
    districtMapping = StateDistrictMapping.getDsitricts();
    if (_auth.currentUser != null) {
      phoneController.text = _auth.currentUser.phoneNumber.substring(3, 13);
    }
    FirebaseAnalytics().logEvent(name: 'Help_Request_Form', parameters: null);
  }

  scrollToTop() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  raisehelp() async {
    var dio = Dio();
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            "tenantSet_id": "CRISIS01",
            "useCase": "help",
            "tenantUsecase": "register",
            "phone": phoneController.text,
            "name": nameController.text,
            "city": districtName,
            "state":stateName,
            "help": helpController.text
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
                raisehelp();
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            )),
      ),
      appBar: AppBar(
        title: Text(
          "Covid Help - Request Form",
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
              SizedBox(
                  height: 80, child: Image.asset("assets/helpRequest.png")),
              SizedBox(
                height: 10,
              ),
              Text(
                "Help Request Form",
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
                      "We will share your requirements with our volunteers, You will be notified if we find something useful.",
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
                decoration: textfieldDecoration(
                    "Full Name", FontAwesomeIcons.addressCard),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              box20,
              new TextFormField(
                textInputAction: TextInputAction.next,
                controller: phoneController,
                decoration: textfieldDecoration("Contact Number", Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
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
                                scrollPadding:
                                    const EdgeInsets.only(bottom: 150.0),
                                controller: textEditingController,
                                onTap: () {
                                  textEditingController.clear();
                                  setState(() {
                                    stateName = "";
                                  });
                                },
                                focusNode: focusNode,
                                decoration: textfieldDecoration(
                                    "Select City", FontAwesomeIcons.city)),
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
                      if (stateName.isNotEmpty)
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerRight,
                            child: Text(
                              stateName ?? "",
                              style: TextStyle(fontSize: 12),
                            ))
                    ],
                  ),
                  box20,
                  new TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: helpController,
                    decoration:
                        textfieldDecoration("Help Required", Icons.live_help),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
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
