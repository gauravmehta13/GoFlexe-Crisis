import 'dart:convert';
import 'dart:ui';
import 'package:crisis/model/app_state.dart';
import 'package:crisis/redux/actions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grouped_list/grouped_list.dart';
import '../Appbar.dart';
import '../Constants.dart';
import '../Fade Route.dart';
import '../Widgets/Counter.dart';
import '../HomePage/Hospital/Hospital Beds.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ExtraItems {
  int id;
  String name;
  int value;

  ExtraItems({this.id, this.name, this.value});
}

class ItemsSelection extends StatefulWidget {
  _ItemsSelectionState createState() => _ItemsSelectionState();
}

class _ItemsSelectionState extends State<ItemsSelection> {
  List<dynamic> filteredItems = [];
  List<dynamic> additionalItems = [];
  List<dynamic> vehicles = [];
  List<dynamic> items = [];
  List<bool> additionalSelected = [];

  @override
  void initState() {
    super.initState();
    // items = AdditionalItems.getAdditionalItems();
    // for (var i = 0; i <= AdditionalItems.getAdditionalItems().length; i++) {
    //   additionalSelected.insert(i, false);
    // }
  }

  // getItems(shiftType) async {
  //   print(shiftType);

  // }
  //
  //
  setItemQuantity() {
    for (var i = 0; i < additionalItems.length; i++) {
      int x = 0;
      for (var j = 0; j < additionalItems[i]['custom'].length; j++) {
        setState(() {
          x = x + additionalItems[i]['custom'][j]['quantity'];
        });
      }
      if (additionalItems[i]['custom'].length != 0) {
        setState(() {
          additionalItems[i]['total'] = x;
        });
      }
    }
  }

  setVehicleQuantity() {
    for (var i = 0; i < vehicles.length; i++) {
      int x = 0;
      for (var j = 0; j < vehicles[i]['custom'].length; j++) {
        setState(() {
          x = x + vehicles[i]['custom'][j]['quantity'];
        });
      }
      if (vehicles[i]['custom'].length != 0) {
        setState(() {
          vehicles[i]['total'] = x;
        });
      }
    }
  }

  bool allFilter = true;
  bool furnitureFilter = false;
  bool applianceFilter = false;
  bool kitchenFilter = false;
  bool smallItemsFilter = false;
  int beds = 0;
  @override
  Widget build(BuildContext context) {
    Widget filters = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              smallItemsFilter = false;
              allFilter = true;
              furnitureFilter = false;
              applianceFilter = false;
              kitchenFilter = false;
              filteredItems = additionalItems;
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: allFilter == true ? Color(0xFF3f51b5) : Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "All",
              style: TextStyle(
                  fontSize: 13,
                  color: allFilter == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              smallItemsFilter = false;
              allFilter = false;
              furnitureFilter = true;
              applianceFilter = false;
              kitchenFilter = false;
              filteredItems = (additionalItems)
                  .where((u) =>
                      u['categoryName'].toLowerCase().contains("furniture"))
                  .toList();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: furnitureFilter == true
                    ? Color(0xFF3f51b5)
                    : Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Furniture",
              style: TextStyle(
                  fontSize: 13,
                  color: furnitureFilter == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              smallItemsFilter = false;
              allFilter = false;
              furnitureFilter = false;
              applianceFilter = true;
              kitchenFilter = false;
              filteredItems = (additionalItems)
                  .where((u) =>
                      u['categoryName'].toLowerCase().contains("appliances"))
                  .toList();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: applianceFilter == true
                    ? Color(0xFF3f51b5)
                    : Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Appliances",
              style: TextStyle(
                  fontSize: 13,
                  color: applianceFilter == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              smallItemsFilter = false;
              allFilter = false;
              furnitureFilter = false;
              applianceFilter = false;
              kitchenFilter = true;
              filteredItems = (additionalItems)
                  .where((u) =>
                      u['categoryName'].toLowerCase().contains("kitchen"))
                  .toList();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: kitchenFilter == true
                    ? Color(0xFF3f51b5)
                    : Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Kitchen items",
              style: TextStyle(
                  fontSize: 13,
                  color: kitchenFilter == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              smallItemsFilter = true;
              allFilter = false;
              furnitureFilter = false;
              applianceFilter = false;
              kitchenFilter = false;

              filteredItems = (additionalItems)
                  .where(
                      (u) => u['categoryName'].toLowerCase().contains("small"))
                  .toList();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: smallItemsFilter == true
                    ? Color(0xFF3f51b5)
                    : Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Small Items",
              style: TextStyle(
                  fontSize: 13,
                  color: smallItemsFilter == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
      ],
    );

    Widget loadingShimmer = Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Card(
                child: new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
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
                        borderSide: new BorderSide(color: Colors.grey)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Search Items",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: filters),
              SizedBox(
                height: 15,
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: additionalItems.length == 0
          ? Container()
          : FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Add Additional Items'),
                          content: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: new GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 2 / 1),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      print(items[index]['selected']);
                                      if (items[index]['selected'] == false) {
                                        additionalItems.add(items[index]);
                                        print("ok");
                                        setState(() {
                                          additionalItems = additionalItems;
                                          items[index]['selected'] = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: Color(0xFF3f51b5),
                                            )),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              if (items[index]['selected'] ==
                                                  true)
                                                Icon(Icons.done),
                                              Expanded(
                                                child: Text(
                                                  items[index]['itemName'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))));
                              },
                            ),
                          ),
                          actions: <Widget>[
                            new ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Done'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ).then((val) {
                  setState(() {
                    additionalItems = additionalItems;
                  });
                  print(val);
                });
              },
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
              onPressed: additionalItems.length == 0
                  ? null
                  : () async {
                      FirebaseAnalytics().logEvent(
                          name: 'Service Provider Selection Screen',
                          parameters: {
                            'Description': 'Went to SP Selection Screen'
                          });
                      await StoreProvider.of<AppState>(context)
                          .dispatch(Items(filteredItems));
                      await StoreProvider.of<AppState>(context)
                          .dispatch(Vehicles(vehicles));
                      Navigator.push(
                        context,
                        FadeRoute(page: HospitalBedList()),
                      );
                    },
              child: Text(
                "Next",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )),
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MyAppBar(curStep: 2)),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(10),
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              onInit: (store) async {
                Map type = {
                  "shiftType": store.state.shiftType,
                  "vehicle": [
                    store.state.car == true ? "Car" : "",
                    store.state.bike == true ? "Bike" : ""
                  ]
                };
                print(type);
                var data = json.encode(type);
                var url = Uri.https(
                    't2v0d33au7.execute-api.ap-south-1.amazonaws.com',
                    '/Staging01/capacity', {
                  'type': 'owner',
                  'tenantId': 'PackersAndMovers',
                  'ownerId': 'PackersAndMovers',
                  'mappings': data,
                });
                var resp = await http.get(url);
                print(resp.body);

                Map map = json.decode(resp.body.toString());
                print(map['vehicleMapping']['custom']);
                /////////////////////////////////
                for (var i = 0;
                    i < map['shiftTypeMapping']['custom'].length;
                    i++) {
                  setState(() {
                    map['shiftTypeMapping']['custom'][i]['total'] =
                        map['shiftTypeMapping']['custom'][i]['quantity'];
                  });
                }
                for (var i = 0;
                    i < map['vehicleMapping']['custom'].length;
                    i++) {
                  setState(() {
                    map['vehicleMapping']['custom'][i]['total'] =
                        map['vehicleMapping']['custom'][i]['quantity'];
                  });
                }
                ////////////////////////////////////
                setState(() {
                  items = map['shiftTypeMapping']['additionalItems'];
                  additionalItems = map['shiftTypeMapping']['custom'];
                  filteredItems = additionalItems;
                  vehicles = map['vehicleMapping']['custom'];
                });
                print(additionalItems);
                setItemQuantity();
                setVehicleQuantity();
              },
              builder: (context, state) {
                return additionalItems.length == 0
                    ? kIsWeb == true
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : loadingShimmer
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: new TextFormField(
                              textInputAction: TextInputAction.go,
                              onChanged: (string) {
                                setState(() {
                                  filteredItems = (additionalItems)
                                      .where((u) => (u['itemName']
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
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Search Items",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal, child: filters),
                          SizedBox(
                            height: 15,
                          ),
                          if (allFilter == true)
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: vehicles.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (vehicles[index]['selected'] == true)
                                    return Card(
                                        shape: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey, width: 1)),
                                        elevation: 0,
                                        child: Column(children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ImageIcon(
                                                  NetworkImage(vehicles[index]
                                                          ['additionalDetails']
                                                      ['image']),
                                                  size: 50,
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      vehicles[index]
                                                              ['itemName'] ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      vehicles[index][
                                                                  'additionalDetails']
                                                              ['description'] ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if (vehicles[index]['custom']
                                                        .length !=
                                                    0)
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                    return Container(
                                                                        child:
                                                                            Column(
                                                                      children: [
                                                                        Card(
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  vehicles[index]['itemName'],
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                Spacer(),
                                                                                IconButton(
                                                                                    icon: Icon(Icons.close),
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    }),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        box10,
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.all(20),
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: ClampingScrollPhysics(),
                                                                              itemCount: vehicles[index]['custom'].length,
                                                                              itemBuilder: (BuildContext context, int i) {
                                                                                return Card(
                                                                                    shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                                                                                    elevation: 0,
                                                                                    child: Column(children: [
                                                                                      Container(
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            ImageIcon(
                                                                                              NetworkImage(vehicles[index]['custom'][i]['additionalDetails']['image']),
                                                                                              size: 50,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 40,
                                                                                            ),
                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  vehicles[index]['custom'][i]['itemName'] ?? "",
                                                                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 5,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 5,
                                                                                                ),
                                                                                                Text(
                                                                                                  vehicles[index]['additionalDetails']['description'] ?? "",
                                                                                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Spacer(),
                                                                                            Counter(
                                                                                                initialValue: vehicles[index]['custom'][i]['quantity'] ?? 0,
                                                                                                minValue: 0,
                                                                                                maxValue: 30,
                                                                                                step: 1,
                                                                                                decimalPlaces: 0,
                                                                                                onChanged: (value) async {
                                                                                                  await setState(() {
                                                                                                    vehicles[index]['custom'][i]['quantity'] = value;
                                                                                                  });
                                                                                                  setVehicleQuantity();
                                                                                                }),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ]));
                                                                              }),
                                                                        ),
                                                                      ],
                                                                    ));
                                                                  });
                                                                });
                                                          },
                                                          child: NotWorkingCounter(
                                                              initialValue:
                                                                  vehicles[
                                                                          index]
                                                                      ['total'],
                                                              minValue: 0,
                                                              maxValue: 100,
                                                              decimalPlaces:
                                                                  0)),
                                                      Text(
                                                        "Customizable",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  )
                                                else
                                                  Counter(
                                                      initialValue:
                                                          vehicles[index]
                                                                  ['total'] ??
                                                              0,
                                                      minValue: 0,
                                                      maxValue: 30,
                                                      step: 1,
                                                      decimalPlaces: 0,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          vehicles[index]
                                                              ['total'] = value;
                                                        });
                                                      }),
                                              ],
                                            ),
                                          )
                                        ]));
                                  else
                                    return Container();
                                }),
                          GroupedListView<dynamic, String>(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            elements: filteredItems,
                            groupBy: (element) => element['categoryName'],
                            groupComparator: (value1, value2) =>
                                value2.compareTo(value1),
                            // itemComparator: (item1, item2) =>
                            //     item2.name.compareTo(item1.name),
                            // optional
                            // useStickyGroupSeparators: true, // optional
                            // floatingHeader: true, // optional
                            order: GroupedListOrder.DESC,
                            groupSeparatorBuilder: (String value) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            itemBuilder: (c, element) {
                              return Card(
                                shape: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1)),
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ImageIcon(
                                            NetworkImage(
                                                element['additionalDetails']
                                                    ['image']),
                                            size: 50,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                element['itemName'] ?? "",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                element['additionalDetails']
                                                        ['description'] ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          if (element['custom'].length != 0)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return Container(
                                                                child: Column(
                                                              children: [
                                                                Card(
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Spacer(),
                                                                        Text(
                                                                          element[
                                                                              'itemName'],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(Icons.close),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                box10,
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              ClampingScrollPhysics(),
                                                                          itemCount: element['custom']
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return Card(
                                                                                shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                                                                                elevation: 0,
                                                                                child: Column(children: [
                                                                                  Container(
                                                                                    padding: EdgeInsets.all(10),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        ImageIcon(
                                                                                          NetworkImage(element['additionalDetails']['image']),
                                                                                          size: 50,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                        ),
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              element['custom'][index]['itemName'] ?? "",
                                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            Text(
                                                                                              element['additionalDetails']['description'] ?? "",
                                                                                              style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Spacer(),
                                                                                        Counter(
                                                                                            initialValue: element['custom'][index]['quantity'] ?? 0,
                                                                                            minValue: 0,
                                                                                            maxValue: 30,
                                                                                            step: 1,
                                                                                            decimalPlaces: 0,
                                                                                            onChanged: (value) async {
                                                                                              await setState(() {
                                                                                                element['custom'][index]['quantity'] = value;
                                                                                              });
                                                                                              setItemQuantity();
                                                                                            }),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ]));
                                                                          }),
                                                                ),
                                                              ],
                                                            ));
                                                          });
                                                        });
                                                  },
                                                  child: NotWorkingCounter(
                                                    initialValue:
                                                        element['total'] ?? 0,
                                                    minValue: 0,
                                                    maxValue: 100,
                                                    step: 1,
                                                    decimalPlaces: 0,
                                                  ),
                                                ),
                                                Text(
                                                  "Customizable",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey[700]),
                                                )
                                              ],
                                            )
                                          else
                                            Counter(
                                                initialValue:
                                                    element['total'] ?? 0,
                                                minValue: 0,
                                                maxValue: 30,
                                                step: 1,
                                                decimalPlaces: 0,
                                                onChanged: (value) {
                                                  setState(() {
                                                    element['total'] = value;
                                                  });
                                                }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            // optional
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
