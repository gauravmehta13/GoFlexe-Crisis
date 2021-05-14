import 'dart:convert';
import 'package:crisis/Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../../Fade Route.dart';
import 'Hospital Beds.dart';
import '../../model/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../redux/actions.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class Place {
  bool isSelected;
  final String title;
  Place(
    this.isSelected,
    this.title,
  );
}

class Hospital extends StatefulWidget {
  @override
  createState() {
    return new _HospitalState();
  }
}

_HospitalState createState() => _HospitalState();

class _HospitalState extends State<Hospital>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime today = new DateTime.now();

  List<Place> place = [];
  List<dynamic> items = [];
  bool pickupLift = true;
  bool dropLift = true;
  String pickupFloor = "";
  String dropFloor = "";
  String state = "";
  bool setUnset = true;
  String selectedDistrict = "";
  List<String> districts = [];
  List<String> states = [];
  TabController _controller;
  var dio = Dio();
  bool additionalServices = false;
  bool shiftTypeSelected = false;
  bool stateLoading = false;
  bool districtLoading = false;
  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    super.initState();
    // place.add(new Place(true, 'Hospital'));
    // place.add(new Place(false, 'Awareness'));
    // place.add(new Place(false, 'Home'));
    // place.add(new Place(false, 'Oxygen'));
    //getItems('Hospital');
    getStates();
  }

  getItems(tab) async {
    //if (!tab) tab = 'Hospital';
    print('I am called');
    setState(() {
      items = [];
    });

    var url = Uri.https('t2v0d33au7.execute-api.ap-south-1.amazonaws.com',
        '/Staging01/capacity', {
      'type': 'owner',
      'tenantSet_id': 'CRISIS01',
      'ownerId': 'CRISIS01',
      'tab': tab
    });
    var resp = await http.get(url);

    List<dynamic> item = json.decode(resp.body);
    for (var i = 0; i < item[0]['assetTypes'].length; i++) {
      item[0]['assetTypes'][i]['selected'] = false;
    }
    print(item);

    setState(() {
      items = item[0]['assetTypes'];
    });
  }

  getStates() async {
    setState(() {
      stateLoading = true;
      states = [];
    });

    // var rep =
    //     await dio.get("https://cdn-api.co-vin.in/api/v2/admin/location/states");
    // print(rep.data);

    var url = Uri.https('t2v0d33au7.execute-api.ap-south-1.amazonaws.com',
        '/Staging01/capacity', {
      'type': 'allStates',
      'tenantSet_id': 'CRISIS01',
      'ownerId': 'CRISIS01'
    });
    var resp = await http.get(url);
    List<dynamic> res = json.decode(resp.body);
    print(res);
    // List<dynamic> item = json.decode(resp.body);
    List<String> temp = [];
    for (var i = 0; i < res.length; i++) {
      temp.add(res[i]);
    }

    setState(() {
      states = temp;
      stateLoading = false;
    });
  }

  getDistrict(stateName) async {
    print('I am called' + stateName);
    setState(() {
      districtLoading = true;
      districts = [];
    });

    var url = Uri.https('t2v0d33au7.execute-api.ap-south-1.amazonaws.com',
        '/Staging01/capacity', {
      'type': 'state',
      'tenantSet_id': 'CRISIS01',
      'ownerId': 'CRISIS01',
      'state': stateName
    });
    var resp = await http.get(url);
    List<dynamic> res = json.decode(resp.body);
    print(res);
    // List<dynamic> item = json.decode(resp.body);
    List<String> temp = [];
    for (var i = 0; i < res.length; i++) {
      temp.add(res[i]);
    }

    setState(() {
      districts = temp;
      districtLoading = false;
    });
  }

  String dropDateValidator;
  String pickupDateValidator;
  Place selectedPlace;

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
            onPressed: shiftTypeSelected == true
                ? () {
                    FocusScope.of(context).unfocus();
                    if (key.currentState.validate() == true) {
                      FirebaseAnalytics().logEvent(
                          name: 'Item Selection Screen',
                          parameters: {
                            'Description': 'Went to Item Selection Screen'
                          });
                      Navigator.push(
                        context,
                        FadeRoute(page: HospitalBedList()),
                      );
                    }
                  }
                : null,
            child: Text(
              "Find a Bed",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: stateLoading == true
          ? Loading()
          : SingleChildScrollView(
              child: Form(
                key: key,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 100,
                              child: Image.asset("assets/hospital.png")),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Find Hospital Bed near you",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          box20,
                          DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItem: true,
                            items: states,
                            label: "Select State",
                            hint: "Your State name",
                            // popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: (e) {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(StateName(e));
                              print(state.stateName);
                              setUnset = true;

                              getDistrict(e);
                            },
                            validator: (String item) {
                              if (item == null)
                                return "Required";
                              else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          districtLoading == true
                              ? Center(
                                  child: LinearProgressIndicator(
                                    backgroundColor: Color(0xFF3f51b5),
                                    valueColor: AlwaysStoppedAnimation(
                                      Color(0xFFf9a825),
                                    ),
                                  ),
                                )
                              : DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItem: true,
                                  items: districts,
                                  label: "Select District",
                                  hint: "Your District Name",
                                  selectedItem:
                                      setUnset ? null : selectedDistrict,
                                  // selectedItem:
                                  //     (districts.length == 0) ? null : districts[0],
                                  // popupItemDisabled: (String s) => s.startsWith('I'),
                                  onChanged: (e) {
                                    FocusScope.of(context).unfocus();
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(DistrictName(e));
                                    setUnset = false;
                                    selectedDistrict = e;
                                    setState(() {
                                      shiftTypeSelected = true;
                                    });
                                  },
                                  validator: (String item) {
                                    if (item == null)
                                      return "Required";
                                    else
                                      return null;
                                  },
                                ),

                          // items.length != 0
                          //     ? new GridView.builder(
                          //         gridDelegate:
                          //             SliverGridDelegateWithFixedCrossAxisCount(
                          //           crossAxisCount: items.length,
                          //           crossAxisSpacing: 5.0,
                          //           mainAxisSpacing: 5.0,
                          //         ),
                          //         shrinkWrap: true,
                          //         itemCount: items.length,
                          //         itemBuilder: (BuildContext context, int index) {
                          //           return new InkWell(
                          //             splashColor: Colors.blueAccent,
                          //             onTap: () {
                          //               FocusScope.of(context).unfocus();
                          // setState(() {
                          //   items.forEach((element) {
                          //     element['selected'] = false;
                          //   });
                          //   items[index]['selected'] = true;
                          //   shiftTypeSelected = true;
                          // });
                          //               StoreProvider.of<AppState>(context).dispatch(
                          //                   ShiftType(items[index]['label']));
                          //               // print(items[index]['custom']);
                          //               print(items[index]['label']);
                          //             },
                          //             child: new RadioItem(items[index]),
                          //           );
                          //         },
                          //       )
                          //     : Center(
                          //         child: LinearProgressIndicator(
                          //           backgroundColor: Color(0xFF3f51b5),
                          //           valueColor: AlwaysStoppedAnimation(
                          //             Color(0xFFf9a825),
                          //           ),
                          //         ),
                          //       ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

class PlaceSelection extends StatelessWidget {
  final Place _item;
  PlaceSelection(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _item.isSelected ? Color(0xFF3f51b5) : Colors.transparent,
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: Center(
        child: Text(_item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _item.isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  var _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    bool selected = _item['selected'] == true;
    return new Container(
      child: Center(
        child: Text(_item['label'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
      decoration: new BoxDecoration(
        color: selected ? Color(0xFF3f51b5) : Colors.transparent,
        border: new Border.all(
            width: 1.0, color: selected ? Color(0xFF3f51b5) : Colors.grey),
        borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
      ),
    );
  }
}
