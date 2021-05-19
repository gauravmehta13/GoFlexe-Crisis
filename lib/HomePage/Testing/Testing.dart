import 'dart:math' as math;
import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/Testing/symptoms.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Diagnostic.dart';

//https://mahmoudabdellatief-88944.medium.com/flutter-pinned-tabbar-with-triggered-scrolling-and-page-anchors-slivers-c81a19f221a6

class Testing extends StatefulWidget {
  bool diagnostic;
  Testing({this.diagnostic});
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> with TickerProviderStateMixin {
  final symptomKey = new GlobalKey();
  final testKey = new GlobalKey();
  final diagnoseKey = new GlobalKey();
  final resultConfusionKey = new GlobalKey();
  final sliverListtKey = new GlobalKey();
  ScrollController scrollController;
  TabController _tabController;
  TabController _topTabController;
  double symptomHeight;
  double testHeight;
  double diagnoseHeight;
  double resultConfusionHeight;
  /////////////////
  List<Symptoms> symptoms;
  bool expanded = false;

  void initState() {
    super.initState();
    scrollController = ScrollController();
    _tabController = new TabController(length: 4, vsync: this);
    _topTabController = new TabController(length: 4, vsync: this);
    addScrollControllerListener();

    symptoms = Symptoms.getSymptoms();
    if (widget.diagnostic == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                  title: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                          height: 50,
                          child: Image.asset("assets/diagnose.png")),
                    ),
                    box20,
                    Text(
                      "Find Diagnostic centre near you",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    box20,
                    Diagnostic(),
                  ],
                ),
              ));
            });
        //scrollToDiagnostic();
      });
    }
    FirebaseAnalytics().logEvent(name: 'Testing', parameters: null);
  }

  scrollToDiagnostic() {
    {
      if (diagnoseKey.currentContext == null) {
        if (_tabController.previousIndex == 0) {
          print("object");
          scrollController.position
              .ensureVisible(
            symptomKey.currentContext.findRenderObject(),
            alignment: 0.0,
            // How far into view the item should be scrolled (between 0 and 1).
            duration: const Duration(milliseconds: 200),
          )
              .then((value) {
            scrollController.position
                .ensureVisible(
              symptomKey.currentContext.findRenderObject(),
              alignment: 0.5,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            )
                .then((value) {
              scrollController.position
                  .ensureVisible(
                testKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  testKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    diagnoseKey.currentContext.findRenderObject(),
                    alignment: 0.2,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            });
          });
        } else if (_tabController.previousIndex == 1) {
          print("object1");
          scrollController.position
              .ensureVisible(
            testKey.currentContext.findRenderObject(),
            alignment: 0.5,
            // How far into view the item should be scrolled (between 0 and 1).
            duration: const Duration(milliseconds: 200),
          )
              .then((value) {
            scrollController.position.ensureVisible(
              diagnoseKey.currentContext.findRenderObject(),
              alignment: 0.2,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            );
          });
        }
      } else {
        print("object2");
        // scrollController.animateTo(1000,
        //     duration: Duration(milliseconds: 500), curve: Curves.ease);
        scrollController.position.ensureVisible(
          diagnoseKey.currentContext.findRenderObject(),
          alignment: 0.0,
          // How far into view the item should be scrolled (between 0 and 1).
          duration: const Duration(milliseconds: 600),
        );
      }
    }
  }

  void addScrollControllerListener() {
    scrollController.addListener(() {
      if (symptomKey.currentContext != null) {
        symptomHeight = symptomKey.currentContext.size.height;
      }
      if (testKey.currentContext != null) {
        testHeight = testKey.currentContext.size.height;
      }
      if (diagnoseKey.currentContext != null) {
        diagnoseHeight = diagnoseKey.currentContext.size.height;
      }
      if (resultConfusionKey.currentContext != null) {
        resultConfusionHeight = resultConfusionKey.currentContext.size.height;
      }
      if (scrollController.offset > symptomHeight &&
          scrollController.offset < testHeight + symptomHeight) {
      } else {}
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollController.offset > 0 &&
            scrollController.offset < symptomHeight) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > symptomHeight &&
            scrollController.offset < testHeight + symptomHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset >
                testHeight + symptomHeight + diagnoseHeight - 200 &&
            scrollController.offset <=
                testHeight +
                    symptomHeight +
                    diagnoseHeight +
                    resultConfusionHeight) {
          _tabController.animateTo(3);
        } else if (scrollController.offset > testHeight + symptomHeight &&
            scrollController.offset <
                testHeight + symptomHeight + diagnoseHeight) {
          _tabController.animateTo(2);
        } else {}
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.offset < 1) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > symptomHeight &&
            scrollController.offset < testHeight + symptomHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > testHeight + symptomHeight &&
            scrollController.offset <
                testHeight + symptomHeight + diagnoseHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
                testHeight + symptomHeight + diagnoseHeight &&
            scrollController.offset <
                testHeight +
                    symptomHeight +
                    diagnoseHeight +
                    resultConfusionHeight) {
          _tabController.animateTo(3);
        } else {}
      }
    });
  }

  void tabBarOnTap(val) {
    switch (val) {
      case 0:
        {
          if (symptomKey.currentContext == null) {
            scrollController.position
                .ensureVisible(
              diagnoseKey.currentContext.findRenderObject(),
              alignment:
                  0.0, // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            )
                .then((value) {
              scrollController.position
                  .ensureVisible(
                diagnoseKey.currentContext.findRenderObject(),
                alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  testKey.currentContext.findRenderObject(),
                  alignment:
                      0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    symptomKey.currentContext.findRenderObject(),
                    alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            });
          } else {
            scrollController.position.ensureVisible(
              symptomKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
      case 1:
        {
          if (testKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                symptomKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  symptomKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    testKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            } else {
              scrollController.position
                  .ensureVisible(
                diagnoseKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  diagnoseKey.currentContext.findRenderObject(),
                  alignment: 0.0,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    testKey.currentContext.findRenderObject(),
                    alignment: 0.5,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position.ensureVisible(
                      testKey.currentContext.findRenderObject(),
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
              testKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 400),
            );
          }
        }
        break;
      case 2:
        {
          if (diagnoseKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                symptomKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  symptomKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    testKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      testKey.currentContext.findRenderObject(),
                      alignment: 0.5,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position.ensureVisible(
                        diagnoseKey.currentContext.findRenderObject(),
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
                testKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position.ensureVisible(
                  diagnoseKey.currentContext.findRenderObject(),
                  alignment: 0.2,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                );
              });
            }
          } else {
            scrollController.position.ensureVisible(
              diagnoseKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 600),
            );
          }
        }
        break;
      case 3:
        {
          if (resultConfusionKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                symptomKey.currentContext.findRenderObject(),
                alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  symptomKey.currentContext.findRenderObject(),
                  alignment:
                      0.5, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    testKey.currentContext.findRenderObject(),
                    alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      testKey.currentContext.findRenderObject(),
                      alignment:
                          0.5, // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position
                          .ensureVisible(
                        diagnoseKey.currentContext.findRenderObject(),
                        alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      )
                          .then((value) {
                        scrollController.position
                            .ensureVisible(
                          diagnoseKey.currentContext.findRenderObject(),
                          alignment:
                              0.5, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                        )
                            .then((value) {
                          scrollController.position.ensureVisible(
                            resultConfusionKey.currentContext
                                .findRenderObject(),
                            alignment:
                                0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration: const Duration(milliseconds: 200),
                          );
                        });
                      });
                    });
                  });
                });
              });
            } else {
              scrollController.position
                  .ensureVisible(
                testKey.currentContext.findRenderObject(),
                alignment:
                    1.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  diagnoseKey.currentContext.findRenderObject(),
                  alignment:
                      0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    resultConfusionKey.currentContext.findRenderObject(),
                    alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              resultConfusionKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
    }
  }

  SliverPersistentHeader makeTabBarHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          width: double.maxFinite,
          color: Colors.white,
          child: Center(
            child: TabBar(
              onTap: (val) {
                tabBarOnTap(val);
              },
              unselectedLabelColor: Colors.grey.shade700,
              indicatorColor: Color(0xFF3f51b5),
              isScrollable: true,
              indicatorWeight: 2.0,
              labelColor: Color(0xFF3f51b5),
              controller: _tabController,
              tabs: <Widget>[
                new Tab(
                  child: Text(
                    "Symptoms",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Test Types",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Diagnose",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                new Tab(
                  child: Text(
                    "Interpretation",
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
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              slivers: <Widget>[
                makeTabBarHeader(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Card(
                        child: Container(
                          key: symptomKey,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: SizedBox(
                                    height: 50,
                                    child:
                                        Image.asset("assets/symptoms (1).png")),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Symptoms",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              box10,
                              Image.asset("assets/covidsymptom.png")
                              // Container(
                              //     child: IgnorePointer(
                              //   child: ListView.builder(
                              //     shrinkWrap: true,
                              //     itemCount: symptoms.length,
                              //     itemBuilder: (context, i) {
                              //       return Container(
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Text(symptoms[i].heading,
                              //                   style: TextStyle(
                              //                     fontSize: 12,
                              //                     fontWeight: FontWeight.w600,
                              //                   )),
                              //             ),
                              //             Container(
                              //                 child: ListView.builder(
                              //               shrinkWrap: true,
                              //               itemCount:
                              //                   symptoms[i].symptoms.length,
                              //               itemBuilder: (context, j) {
                              //                 return Text(
                              //                   "     • ${symptoms[i].symptoms[j]}",
                              //                   style: TextStyle(
                              //                       color: Colors.grey[700]),
                              //                 );
                              //               },
                              //             )),
                              //             Divider(),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          key: testKey,
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
                                    child: Image.asset("assets/testing.png")),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Test Types",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset("assets/test.jpg")
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            key: diagnoseKey,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: SizedBox(
                                    height: 50,
                                    child: Image.asset("assets/diagnose.png")),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Find Diagnostic centre near you",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Diagnostic(),
                              ),
                              box30,
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          key: resultConfusionKey,
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
                                    height: 60,
                                    child: Image.asset("assets/research.png")),
                              ),
                              box10,
                              Text(
                                "Interpretation",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              box20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "I am RT PCR Negative but have symptoms. What to interpret?",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[800]),
                                  ),
                                  box10,
                                  Text(
                                    "• What to do is in your hands, i.e., getting the test done",
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  box10,
                                  Text(
                                    "• What to interpret is in your Doctor's hands",
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  box20,
                                  Text(
                                    "So, What to do?",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[800]),
                                  ),
                                  box10,
                                  Text(
                                    "Simple, Based on your symptoms and history, your doctor will advice either CT Scan or other tests.",
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  box20,
                                  Text(
                                    "What not to do?",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[800]),
                                  ),
                                  box10,
                                  Text(
                                    "Ignoring the symptoms thinking you're RT PCR Negative. Remember, RT PCR Negative COVID gets worse and more serious because of diagnostic delay or patients not consulting their doctor.",
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              box20,
                              Center(
                                child: Image.asset("assets/result.jpg"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
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
