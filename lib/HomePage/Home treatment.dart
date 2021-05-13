import 'package:crisis/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'dart:math' as math;
import '../Constants.dart';

class HomeTreatment extends StatefulWidget {
  @override
  _HomeTreatmentState createState() => _HomeTreatmentState();
}

class _HomeTreatmentState extends State<HomeTreatment>
    with TickerProviderStateMixin {
  final symptomKey = new GlobalKey();
  final testKey = new GlobalKey();
  final resultConusionKey = new GlobalKey();
  final diagnoseKey = new GlobalKey();
  final sliverListtKey = new GlobalKey();
  ScrollController scrollController;
  TabController _tabController;
  TabController _topTabController;
  double symptomHeight;
  double testHeight;
  double resultConusionHeight;
  double diagnoseHeight;
  /////////////////
  void initState() {
    super.initState();

    scrollController = ScrollController();
    _tabController = new TabController(length: 3, vsync: this);
    _topTabController = new TabController(length: 3, vsync: this);
    addScrollControllerListener();
  }

  void addScrollControllerListener() {
    scrollController.addListener(() {
      if (symptomKey.currentContext != null) {
        symptomHeight = symptomKey.currentContext.size.height;
      }
      if (testKey.currentContext != null) {
        testHeight = testKey.currentContext.size.height;
      }
      if (resultConusionKey.currentContext != null) {
        resultConusionHeight = resultConusionKey.currentContext.size.height;
      }
      if (diagnoseKey.currentContext != null) {
        diagnoseHeight = diagnoseKey.currentContext.size.height;
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
        } else if (scrollController.offset > testHeight + symptomHeight &&
            scrollController.offset <
                testHeight + symptomHeight + resultConusionHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
                testHeight + symptomHeight + resultConusionHeight - 200 &&
            scrollController.offset <=
                testHeight +
                    symptomHeight +
                    resultConusionHeight +
                    diagnoseHeight) {
          _tabController.animateTo(3);
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
                testHeight + symptomHeight + resultConusionHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
                testHeight + symptomHeight + resultConusionHeight &&
            scrollController.offset <
                testHeight +
                    symptomHeight +
                    resultConusionHeight +
                    diagnoseHeight) {
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
              resultConusionKey.currentContext.findRenderObject(),
              alignment:
                  0.0, // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            )
                .then((value) {
              scrollController.position
                  .ensureVisible(
                resultConusionKey.currentContext.findRenderObject(),
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
                resultConusionKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  resultConusionKey.currentContext.findRenderObject(),
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
          if (resultConusionKey.currentContext == null) {
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
                        resultConusionKey.currentContext.findRenderObject(),
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
                  resultConusionKey.currentContext.findRenderObject(),
                  alignment: 0.2,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                );
              });
            }
          } else {
            scrollController.position.ensureVisible(
              resultConusionKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 600),
            );
          }
        }
        break;
      case 3:
        {
          if (diagnoseKey.currentContext == null) {
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
                        resultConusionKey.currentContext.findRenderObject(),
                        alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      )
                          .then((value) {
                        scrollController.position
                            .ensureVisible(
                          resultConusionKey.currentContext.findRenderObject(),
                          alignment:
                              0.5, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                        )
                            .then((value) {
                          scrollController.position.ensureVisible(
                            diagnoseKey.currentContext.findRenderObject(),
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
                  resultConusionKey.currentContext.findRenderObject(),
                  alignment:
                      0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    diagnoseKey.currentContext.findRenderObject(),
                    alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              diagnoseKey.currentContext.findRenderObject(),
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
          color: Colors.white,
          child: TabBar(
            onTap: (val) {
              tabBarOnTap(val);
            },
            unselectedLabelColor: Colors.grey.shade700,
            indicatorColor: Color(0xFF3f51b5),
            indicatorWeight: 2.0,
            labelColor: Color(0xFF3f51b5),
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                child: Text(
                  "Devices",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              new Tab(
                child: Text(
                  "Basic Medication",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              new Tab(
                child: Text(
                  "Isolation",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
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
                              Center(
                                child: Image.asset("assets/0009.jpg"),
                              ),
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
                                    child:
                                        Image.asset("assets/medication.png")),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Medication",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),

                              Center(
                                child: Image.asset("assets/0012.jpg"),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Center(
                              //   child: SizedBox(
                              //       height: 50,
                              //       child: Image.asset("assets/diagnose.png")),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Text(
                              //   "Basic Diagnosis Test",
                              //   style: TextStyle(
                              //       fontSize: 15, fontWeight: FontWeight.w600),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Image.network(
                              //     "https://www.creativefabrica.com/wp-content/uploads/2021/01/27/Covid-testing-vector-infographic-Graphics-8121388-1.jpg")
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          key: resultConusionKey,
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
                                    child: Image.asset("assets/isolation.png")),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Isolation",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),

                              Center(
                                child: Image.asset("assets/0013.jpg"),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Center(
                              //   child: SizedBox(
                              //       height: 50,
                              //       child: Image.asset("assets/diet.png")),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Text(
                              //   "Diet & Nutrition",
                              //   style: TextStyle(
                              //       fontSize: 15, fontWeight: FontWeight.w600),
                              // ),
                              // box10,
                              // Center(
                              //   child: Image.asset("assets/interpretation.png"),
                              // ),
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
