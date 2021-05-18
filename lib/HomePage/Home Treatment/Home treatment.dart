import 'package:crisis/HomePage/Home%20Treatment/Home%20treatment%20data.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/TextFieldSearch.dart';
import 'package:crisis/model/StateDistrict%20Model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import '../../Constants.dart';

class HomeTreatment extends StatefulWidget {
  bool homeCare;
  HomeTreatment({this.homeCare});
  @override
  _HomeTreatmentState createState() => _HomeTreatmentState();
}

class _HomeTreatmentState extends State<HomeTreatment>
    with TickerProviderStateMixin {
  final devicesKey = new GlobalKey();
  final medicationKey = new GlobalKey();
  final isolationKey = new GlobalKey();
  final homeCareKey = new GlobalKey();
  final sliverListtKey = new GlobalKey();
  var dio = Dio();
  ScrollController scrollController;
  TabController _tabController;
  TabController _topTabController;
  double devicesHeight;
  double medicationHeight;
  double isolationHeight;
  double homeCareHeight;
  List<DevicesRequired> devices;
  List<Meds> meds;
  List<Warnings> warnings;
  List<IsolationTab> isolationTab;

  bool loading = false;
  bool districtLoading = false;
  States states;
  District districts;
  String pinCode = "";
  String districtId = "";
  String districtName = "";
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  /////////////////
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _tabController = new TabController(length: 4, vsync: this);
    _topTabController = new TabController(length: 4, vsync: this);

    addScrollControllerListener();
    devices = DevicesRequired.getDevicesRequired();
    meds = Meds.getMeds();
    warnings = Warnings.getWarnings();
    isolationTab = IsolationTab.getIsolationTab();
    getStates();
    if (widget.homeCare == true) {
      print("object");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
    FirebaseAnalytics().logEvent(name: 'Home_Treatment', parameters: null);
  }

  SliverPersistentHeader makeTabBarHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.white,
            child: TabBar(
              onTap: (val) {
                tabBarOnTap(val);
              },
              unselectedLabelColor: Colors.grey.shade700,
              indicatorColor: Color(0xFF3f51b5),
              indicatorWeight: 2.0,
              isScrollable: true,
              labelColor: Color(0xFF3f51b5),
              controller: _tabController,
              tabs: <Widget>[
                new Tab(
                  child: Text(
                    "Devices",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Medication",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Isolation",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Home Care",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _topTabController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [
      Expanded(
          child:
              CustomScrollView(controller: scrollController, slivers: <Widget>[
        makeTabBarHeader(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Card(
                child: Container(
                  key: devicesKey,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                            height: 50,
                            child: Image.asset("assets/device.png")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Devices Required",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      box10,
                      Container(
                          child: IgnorePointer(
                        child: Column(
                          children: [
                            Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: devices.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/${devices[i].url}",
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("${devices[i].name}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )),
                      box10,
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                            height: 50,
                            child: Image.asset("assets/oximeter.png")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Interpretation",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      box10,
                      Center(
                        child: Image.asset("assets/o2level.png"),
                      ),
                      box10,
                      Row(
                        children: [
                          Text(
                            "* ",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          ),
                          Expanded(
                            child: Text(
                              "Hypoxemia is defined as decreased pressure in blood and oxygen available to the body or and indivisual tissue or organ.",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  key: medicationKey,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                            height: 50,
                            child: Image.asset("assets/medication.png")),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Medication",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      box20,
                      Divider(),
                      IgnorePointer(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: meds.length,
                          itemBuilder: (context, i) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${meds[i].name}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: meds[i].meds.length,
                                    itemBuilder: (context, j) {
                                      return Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/${meds[i].meds[j].url}",
                                                    height: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${meds[i].meds[j].name}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            "${meds[i].meds[j].description}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.grey[
                                                                        700])),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  box10,
                                  Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: warnings.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: warnings[i].serious == true
                                    ? Colors.orangeAccent[200]
                                    : Color(0xFFe2e7ff),
                                border: Border.all(width: 0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("${warnings[i].name}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                      // Center(
                      //   child: SizedBox(
                      //       height: 50,
                      //       child: Image.asset("assets/homeCare.png")),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //   "Basic Diagnosis medication",
                      //   style: TextStyle(
                      //       fontSize: 15, fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                ),
              ),
              Card(
                  child: Container(
                      key: isolationKey,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: isolationTab.length,
                          itemBuilder: (context, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SizedBox(
                                      height: 50,
                                      child: Image.asset(
                                          "assets/${isolationTab[i].url}")),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  isolationTab[i].name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                box10,
                                Container(
                                    child: IgnorePointer(
                                  child: Column(
                                    children: [
                                      box10,
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: isolationTab[i].tips.length,
                                        itemBuilder: (context, j) {
                                          return Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text("• "),
                                                      Expanded(
                                                        child: Text(
                                                            "${isolationTab[i].tips[j].tip}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                                Divider(
                                  color: Colors.grey,
                                )
                              ],
                            );
                          }))),
              Card(
                  child: Container(
                      key: homeCareKey,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SizedBox(
                                height: 60,
                                child: Image.asset("assets/homeTreatment.png")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Find home care centers near you",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          box30,
                          loading == true
                              ? Loading()
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                                          ? LinearProgressIndicator(
                                              backgroundColor:
                                                  Color(0xFF3f51b5),
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                Color(0xFFf9a825),
                                              ),
                                            )
                                          : TextFieldSearch(
                                              minStringLength: 0,
                                              decoration: new InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(15),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
                          box30,
                          box30,
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFf9a825), // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {
                                  displaySnackBar("Coming Soon", context);
                                  FirebaseAnalytics().logEvent(
                                      name: 'Home_Care_Center',
                                      parameters: null);
                                },
                                child: Text(
                                  "Find Home Care Center",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          box30,
                          box30,
                        ],
                      )))
            ],
          ),
        )
      ]))
    ])));
  }

  void addScrollControllerListener() {
    scrollController.addListener(() {
      if (devicesKey.currentContext != null) {
        devicesHeight = devicesKey.currentContext.size.height;
      }
      if (medicationKey.currentContext != null) {
        medicationHeight = medicationKey.currentContext.size.height;
      }
      if (isolationKey.currentContext != null) {
        isolationHeight = isolationKey.currentContext.size.height;
      }
      if (homeCareKey.currentContext != null) {
        homeCareHeight = homeCareKey.currentContext.size.height;
      }
      if (scrollController.offset > devicesHeight &&
          scrollController.offset < medicationHeight + devicesHeight) {
      } else {}
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollController.offset > 0 &&
            scrollController.offset < devicesHeight) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > devicesHeight &&
            scrollController.offset < medicationHeight + devicesHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset >
                devicesHeight + medicationHeight + isolationHeight - 200 &&
            scrollController.offset <=
                devicesHeight +
                    medicationHeight +
                    isolationHeight +
                    homeCareHeight) {
          _tabController.animateTo(3);
        } else if (scrollController.offset > devicesHeight + medicationHeight &&
            scrollController.offset <
                devicesHeight + medicationHeight + isolationHeight) {
          _tabController.animateTo(2);
        } else {}
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.offset < 1) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > devicesHeight &&
            scrollController.offset < medicationHeight + devicesHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > medicationHeight + devicesHeight &&
            scrollController.offset <
                medicationHeight + devicesHeight + isolationHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
                medicationHeight + devicesHeight + isolationHeight &&
            scrollController.offset <
                medicationHeight +
                    devicesHeight +
                    isolationHeight +
                    homeCareHeight) {
          _tabController.animateTo(3);
        } else {}
      }
    });
  }

  void tabBarOnTap(val) {
    switch (val) {
      case 0:
        {
          if (devicesKey.currentContext == null) {
            scrollController.position
                .ensureVisible(
              isolationKey.currentContext.findRenderObject(),
              alignment:
                  0.0, // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            )
                .then((value) {
              scrollController.position
                  .ensureVisible(
                isolationKey.currentContext.findRenderObject(),
                alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  medicationKey.currentContext.findRenderObject(),
                  alignment:
                      0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    devicesKey.currentContext.findRenderObject(),
                    alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            });
          } else {
            scrollController.position.ensureVisible(
              devicesKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
      case 1:
        {
          if (medicationKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                devicesKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  devicesKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    medicationKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            } else {
              scrollController.position
                  .ensureVisible(
                isolationKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  isolationKey.currentContext.findRenderObject(),
                  alignment: 0.0,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    medicationKey.currentContext.findRenderObject(),
                    alignment: 0.5,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position.ensureVisible(
                      medicationKey.currentContext.findRenderObject(),
                      alignment: 0.0,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    );
                  });
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              medicationKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 400),
            );
          }
        }
        break;
      case 2:
        {
          if (isolationKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                devicesKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  devicesKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    medicationKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      medicationKey.currentContext.findRenderObject(),
                      alignment: 0.5,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position.ensureVisible(
                        isolationKey.currentContext.findRenderObject(),
                        alignment: 0.2,
                        // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      );
                    });
                  });
                });
              });
            } else if (_tabController.previousIndex == 1) {
              scrollController.position
                  .ensureVisible(
                medicationKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position.ensureVisible(
                  isolationKey.currentContext.findRenderObject(),
                  alignment: 0.2,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                );
              });
            }
          } else {
            scrollController.position.ensureVisible(
              isolationKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 600),
            );
          }
        }
        break;
      case 3:
        {
          // if (homeCareKey.currentContext == null) {
          //   if (_tabController.previousIndex == 0) {
          //     scrollController.position
          //         .ensureVisible(
          //       devicesKey.currentContext.findRenderObject(),
          //       alignment:
          //           0.0, // How far into view the item should be scrolled (between 0 and 1).
          //       duration: const Duration(milliseconds: 200),
          //     )
          //         .then((value) {
          //       scrollController.position
          //           .ensureVisible(
          //         devicesKey.currentContext.findRenderObject(),
          //         alignment:
          //             0.5, // How far into view the item should be scrolled (between 0 and 1).
          //         duration: const Duration(milliseconds: 200),
          //       )
          //           .then((value) {
          //         scrollController.position
          //             .ensureVisible(
          //           medicationKey.currentContext.findRenderObject(),
          //           alignment:
          //               0.0, // How far into view the item should be scrolled (between 0 and 1).
          //           duration: const Duration(milliseconds: 200),
          //         )
          //             .then((value) {
          //           scrollController.position
          //               .ensureVisible(
          //             medicationKey.currentContext.findRenderObject(),
          //             alignment:
          //                 0.5, // How far into view the item should be scrolled (between 0 and 1).
          //             duration: const Duration(milliseconds: 200),
          //           )
          //               .then((value) {
          //             scrollController.position
          //                 .ensureVisible(
          //               isolationKey.currentContext.findRenderObject(),
          //               alignment:
          //                   0.0, // How far into view the item should be scrolled (between 0 and 1).
          //               duration: const Duration(milliseconds: 200),
          //             )
          //                 .then((value) {
          //               scrollController.position
          //                   .ensureVisible(
          //                 isolationKey.currentContext.findRenderObject(),
          //                 alignment:
          //                     0.5, // How far into view the item should be scrolled (between 0 and 1).
          //                 duration: const Duration(milliseconds: 200),
          //               )
          //                   .then((value) {
          //                 scrollController.position.ensureVisible(
          //                   homeCareKey.currentContext.findRenderObject(),
          //                   alignment:
          //                       0.0, // How far into view the item should be scrolled (between 0 and 1).
          //                   duration: const Duration(milliseconds: 200),
          //                 );
          //               });
          //             });
          //           });
          //         });
          //       });
          //     });
          //   } else {
          //     scrollController.position
          //         .ensureVisible(
          //       medicationKey.currentContext.findRenderObject(),
          //       alignment:
          //           1.0, // How far into view the item should be scrolled (between 0 and 1).
          //       duration: const Duration(milliseconds: 200),
          //     )
          //         .then((value) {
          //       scrollController.position
          //           .ensureVisible(
          //         isolationKey.currentContext.findRenderObject(),
          //         alignment:
          //             0.0, // How far into view the item should be scrolled (between 0 and 1).
          //         duration: const Duration(milliseconds: 200),
          //       )
          //           .then((value) {
          //         scrollController.position.ensureVisible(
          //           homeCareKey.currentContext.findRenderObject(),
          //           alignment:
          //               0.0, // How far into view the item should be scrolled (between 0 and 1).
          //           duration: const Duration(milliseconds: 200),
          //         );
          //       });
          //     });
          //   }
          // } else {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
          //   scrollController.position.ensureVisible(
          //     homeCareKey.currentContext.findRenderObject(),
          //     alignment: 0.0,
          //     // How far into view the item should be scrolled (between 0 and 1).
          //     duration: const Duration(milliseconds: 800),
          //   );
          // }
        }
        break;
    }
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
