import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/Vaccination/Vaccination%20Slots.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/TextFieldSearch.dart';
import 'package:crisis/model/StateDistrict%20Model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Fade Route.dart';

class Vaccination extends StatefulWidget {
  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  var dio = Dio();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  bool district = false;
  bool loading = false;
  bool districtLoading = false;

  States states;
  District districts;

  String pinCode = "";
  String districtId = "";
  String districtName = "";
  var pinController = TextEditingController();

  void initState() {
    super.initState();
    getStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: SizedBox(
              height: 50,
              width: double.infinity,
              child: pinCode.isNotEmpty || districtId.isNotEmpty
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFf9a825), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            FadeRoute(
                                page: VaccinationSlots(
                              pin: pinCode,
                              district: district,
                              districtId: districtId,
                              distrctName: districtName,
                            )));
                      },
                      child: Text(
                        "Search Slot",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFf9a825), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        await launch("https://selfregistration.cowin.gov.in/");
                      },
                      child: Text(
                        "Get Vaccinated",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
        ),
        body: loading == true
            ? Loading()
            : SingleChildScrollView(
                child: Form(
                    child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                          height: 60,
                          child: Image.asset("assets/injection.png")),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Vaccination",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Search for vaccination slots"),
                    box30,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  district = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: district == true
                                        ? Color(0xFF9eaeff)
                                        : Colors.white,
                                    border: Border.all(
                                        color: district == false
                                            ? Color(0xFF9eaeff)
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: Text(
                                    "District",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  district = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: district == false
                                        ? Color(0xFF9eaeff)
                                        : Colors.white,
                                    border: Border.all(
                                        color: district == true
                                            ? Color(0xFF9eaeff)
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: Text(
                                    "Pin Code",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    box20,
                    if (district == true)
                      loading == true
                          ? Loading()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  box20,
                                  TextFieldSearch(
                                    minStringLength: 0,
                                    decoration: new InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFF2821B5),
                                        ),
                                      ),
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey)),
                                      labelText: 'Search State',
                                    ),
                                    controller: stateController,
                                    initialList: states?.states ?? [],
                                    future: () {
                                      return fetchStates();
                                    },
                                    getSelectedValue: (state) {
                                      FocusScope.of(context).unfocus();
                                      getDistricts(state.value);
                                      setState(() {
                                        districtController.text = "";
                                      });
                                      print(state.label);
                                      print(state
                                          .value); // this prints the selected option which could be an object
                                    },
                                    label: '',
                                  ),
                                  box30,
                                  districtLoading == true
                                      ? LinearProgressIndicator()
                                      : TextFieldSearch(
                                          minStringLength: 0,
                                          decoration: new InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF2821B5),
                                              ),
                                            ),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.grey)),
                                            labelText: 'Search District',
                                          ),
                                          label: 'Enter District',
                                          controller: districtController,
                                          initialList:
                                              districts?.districts ?? [],
                                          future: () {
                                            return fetchDistricts();
                                          },
                                          getSelectedValue: (district) {
                                            FocusScope.of(context).unfocus();
                                            setState(() {
                                              districtId =
                                                  district.value.toString();
                                              districtName =
                                                  district.label.toString();
                                            });
                                            print(district.label);
                                            print(district
                                                .value); // this prints the selected option which could be an object
                                          }),
                                ],
                              ),
                            ),
                    if (district == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            box20,
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              controller: pinController,
                              onChanged: (value) {
                                setState(() {
                                  pinCode = value;
                                });
                              },
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
                                    borderSide:
                                        new BorderSide(color: Colors.grey)),
                                labelText: 'Search by pincode',
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ))));
  }

  getStates() async {
    setState(() {
      loading = true;
    });
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
    return states.states;
  }

  Future<List> fetchDistricts() async {
    return districts.districts;
  }
}
