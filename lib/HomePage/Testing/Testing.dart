import 'dart:async';
import 'dart:math' as math;
import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/Testing/symptoms.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import 'Diagnostic.dart';

//https://mahmoudabdellatief-88944.medium.com/flutter-pinned-tabbar-with-triggered-scrolling-and-page-anchors-slivers-c81a19f221a6

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> with TickerProviderStateMixin {
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
  int _activeMeterIndex = 0;
  Timer _timer;
  List<Symptoms> symptoms;
  bool expanded = false;

  static final int _initialPage = 8;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController _pdfController;

  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/guide.pdf'),
      initialPage: _initialPage,
    );
    if (_activeMeterIndex == 0) {
      load();
    }
    scrollController = ScrollController();
    _tabController = new TabController(length: 4, vsync: this);
    _topTabController = new TabController(length: 4, vsync: this);
    addScrollControllerListener();

    symptoms = Symptoms.getSymptoms();
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
        } else if (scrollController.offset >
                testHeight + symptomHeight + resultConusionHeight - 200 &&
            scrollController.offset <=
                testHeight +
                    symptomHeight +
                    resultConusionHeight +
                    diagnoseHeight) {
          _tabController.animateTo(3);
        } else if (scrollController.offset > testHeight + symptomHeight &&
            scrollController.offset <
                testHeight + symptomHeight + resultConusionHeight) {
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
            isScrollable: true,
            indicatorWeight: 2.0,
            labelColor: Color(0xFF3f51b5),
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                child: Text(
                  "Symptoms",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              new Tab(
                child: Text(
                  "Test Types",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              new Tab(
                child: Text(
                  "Interpretation",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              new Tab(
                child: Text(
                  "Diagnose",
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
    _pdfController.dispose();
    _topTabController.dispose();
    scrollController.dispose();
  }

  load() {
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _activeMeterIndex = 2;
      });
    });
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
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Center(
                              //   child: SizedBox(
                              //       height: 50,
                              //       child:
                              //           Image.asset("assets/symptoms (1).png")),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Text(
                              //   "Symptoms",
                              //   style: TextStyle(
                              //       fontSize: 15, fontWeight: FontWeight.w600),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
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
                              Image.network(
                                  "https://cdn.thewire.in/wp-content/uploads/2020/04/05204920/Screenshot-2020-04-05-at-7.40.03-PM.png")
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
                                    child: Image.asset("assets/confusion.png")),
                              ),
                              box10,
                              Text(
                                "Interpretation",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Center(
                                child: Image.asset("assets/result.jpg"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
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
                              "Diagnose",
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
                      )
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
