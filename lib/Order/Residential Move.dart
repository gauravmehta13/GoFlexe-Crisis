import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../Fade Route.dart';
import 'Items Selection.dart';
import '../model/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';
import '../Drawer.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Place {
  bool isSelected;
  final String title;
  Place(
    this.isSelected,
    this.title,
  );
}

class ResidentialMove extends StatefulWidget {
  @override
  createState() {
    return new _ResidentialMoveState();
  }
}

_ResidentialMoveState createState() => _ResidentialMoveState();

class _ResidentialMoveState extends State<ResidentialMove>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime today = new DateTime.now();

  List<Place> place = [];
  List<dynamic> items = [];
  bool pickupLift = true;
  bool dropLift = true;
  String pickupFloor = "";
  String dropFloor = "";

  TabController _controller;
  var dio = Dio();
  bool additionalServices = false;
  bool shiftTypeSelected = false;
  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    super.initState();
    place.add(new Place(true, 'Within City'));
    place.add(new Place(false, 'Within Society'));
    place.add(new Place(false, 'OutStation'));
    getItems();
  }

  getItems() async {
    var url = Uri.https('t2v0d33au7.execute-api.ap-south-1.amazonaws.com',
        '/Staging01/capacity', {
      'type': 'owner',
      'tenantId': 'PackersAndMovers',
      'ownerId': 'PackersAndMovers'
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

  String dropDateValidator;
  String pickupDateValidator;
  Place selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "GoFlexe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: "Packers & Movers",
            ),
          ],
        ),
      ),
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
                        FadeRoute(page: ItemsSelection()),
                      );
                    }
                  }
                : null,
            child: Text(
              "Next",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Container(
            padding: EdgeInsets.all(20),
            child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: new GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 3 / 1),
                        shrinkWrap: true,
                        itemCount: place.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPlace = place[index];
                                place.forEach((element) {
                                  element.isSelected = false;
                                });
                                place[index].isSelected = true;

                                StoreProvider.of<AppState>(context)
                                    .dispatch(MovementType(place[index].title));
                                print(place[index].title);
                              });
                            },
                            child: new PlaceSelection(place[index]),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Where do you want to shift?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: [
                        "Banglore",
                        "Hyderabad",
                        "Chennai",
                      ],
                      label: "Pickup City",
                      hint: "Select Pickup City",
                      // popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (e) {
                        StoreProvider.of<AppState>(context)
                            .dispatch(PickupCity(e));
                      },
                      validator: (String item) {
                        if (item == null)
                          return "Required";
                        else
                          return null;
                      },
                    ),
                    if (selectedPlace != null)
                      if (selectedPlace.title == "OutStation")
                        Column(
                          children: [
                            box10,
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: [
                                "Banglore",
                                "Hyderabad",
                                "Chennai",
                              ],
                              label: "Drop City",
                              hint: "Select Drop City",
                              // popupItemDisabled: (String s) => s.startsWith('I'),
                              onChanged: (e) {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(DropCity(e));
                              },
                              // validator: (String item) {
                              //   if (item == null)
                              //     return "Required field";
                              //   else
                              //     return null;
                              // },
                            ),
                          ],
                        ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DateTimePicker(
                                decoration: new InputDecoration(
                                  errorStyle: TextStyle(fontSize: 10),
                                  prefixIcon: Icon(Icons.calendar_today),
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
                                          new BorderSide(color: Colors.grey)),
                                  labelText: 'Pickup Date',
                                ),
                                style: TextStyle(fontSize: 14),
                                firstDate: today,
                                lastDate: DateTime(2100),
                                dateLabelText: "Pickup Date",
                                onChanged: (val) {
                                  print(val);
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(PickupDate(val));
                                },
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: DateTimePicker(
                                style: TextStyle(fontSize: 14),
                                decoration: new InputDecoration(
                                  errorText: dropDateValidator,
                                  errorStyle: TextStyle(fontSize: 10),
                                  prefixIcon: Icon(Icons.calendar_today),
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
                                          new BorderSide(color: Colors.grey)),
                                  labelText: 'Drop Date',
                                ),
                                initialDate: today.add(Duration(
                                  days: 1,
                                )),
                                firstDate: today.add(Duration(
                                  days: 1,
                                )),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Drop Date',
                                onChanged: (val) async {
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(DropDate(val));
                                  if (DateTime.parse(state.pickupDate)
                                      .isAfter(DateTime.parse(val))) {
                                    setState(() {
                                      dropDateValidator =
                                          "Select a date after Pickup Date";
                                    });
                                  } else {
                                    setState(() {
                                      dropDateValidator = null;
                                    });
                                  }
                                },
                                // validator: (val) {
                                //   if (val.isEmpty) {
                                //     return "Required";
                                //   }
                                //   return null;
                                // },
                                onSaved: (val) => print(val),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
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
                                          new BorderSide(color: Colors.grey)),
                                  labelText: 'Pickup Floor',
                                ),
                                onChanged: (e) async {
                                  setState(() {
                                    pickupFloor = e;
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(PickupFloor(e));
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
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
                                          new BorderSide(color: Colors.grey)),
                                  labelText: 'Drop Floor',
                                ),
                                onChanged: (e) {
                                  setState(() {
                                    dropFloor = e;
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(DropFloor(e));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    pickupFloor != ""
                        ? CheckboxListTile(
                            title: const Text(
                                'Lift available at pickup location?'),
                            autofocus: false,
                            activeColor: Color(0xFF3f51b5),
                            checkColor: Colors.white,
                            selected: pickupLift,
                            value: pickupLift,
                            onChanged: (bool value) {
                              setState(() {
                                pickupLift = value;
                              });
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    dropFloor != ""
                        ? CheckboxListTile(
                            title:
                                const Text('Lift available at drop location?'),
                            autofocus: false,
                            activeColor: Color(0xFF3f51b5),
                            checkColor: Colors.white,
                            selected: dropLift,
                            value: dropLift,
                            onChanged: (bool value) {
                              setState(() {
                                dropLift = value;
                              });
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "What do you want to shift?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    items.length != 0
                        ? new GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new InkWell(
                                splashColor: Colors.blueAccent,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    items.forEach((element) {
                                      element['selected'] = false;
                                    });
                                    items[index]['selected'] = true;
                                    shiftTypeSelected = true;
                                  });
                                  StoreProvider.of<AppState>(context).dispatch(
                                      ShiftType(items[index]['label']));
                                  // print(items[index]['custom']);
                                  print(items[index]['label']);
                                },
                                child: new RadioItem(items[index]),
                              );
                            },
                          )
                        : Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Color(0xFF3f51b5),
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xFFf9a825),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Checkbox(
                            activeColor: Color(0xFF3f51b5),
                            value: state?.car ?? false,
                            onChanged: (e) {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(Car(e));
                            }),
                        Text("Car"),
                        Spacer(),
                        Checkbox(
                            activeColor: Color(0xFF3f51b5),
                            value: state?.bike ?? false,
                            onChanged: (e) {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(Bike(e));
                            }),
                        Text("Bike"),
                        Spacer(),
                      ],
                    ),
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
