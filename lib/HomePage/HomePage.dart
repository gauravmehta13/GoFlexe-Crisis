import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/TabBar.dart';
import 'package:crisis/Screens/Covid%20Stats/Stats%20TabBar.dart';
import 'package:crisis/Screens/Faq.dart';
import 'package:crisis/Screens/MythBusters.dart';
import 'package:crisis/Screens/Twitter%20Search.dart';
import 'package:crisis/Screens/india_helplines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Drawer.dart';
import '../Fade Route.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "GoFlexe",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Color(0xFF3f51b5),
              ),
              Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 130,
                    padding: EdgeInsets.all(10),
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      color: Colors.white,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        width: MediaQuery.of(context).size.width - 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                      context,
                                      FadeRoute(
                                        page: GoFlexeTabBar(
                                          index: 0,
                                        ),
                                      ));
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightBlue,
                                        child:
                                            Image.asset("assets/homeTest.png")),
                                    Text(
                                      "Testing",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: GoFlexeTabBar(index: 1)),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightBlue,
                                        child: Image.asset(
                                            "assets/homeTreat.png")),
                                    Text(
                                      "Home\nTreatment",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: GoFlexeTabBar(index: 2)),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                      child: Image.asset(
                                          "assets/homeHospital.png"),
                                    ),
                                    Text(
                                      "Hospitalisation",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: GoFlexeTabBar(index: 3)),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                      child: Image.asset("assets/homeVacc.png"),
                                    ),
                                    Text(
                                      "Vaccination",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 200,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey[300],
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Find centres near you",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        print("tapped");
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: GoFlexeTabBar(
                                            index: 0,
                                            centerIndex: 0,
                                          )),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.bookMedical,
                                            color: Color(0xFFc14098),
                                            size: 18,
                                          ),
                                          Text(
                                            "Diagnostic",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // Divider(),
                                          // Text(
                                          //   "Find centres near you",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontSize: 11,
                                          //       fontWeight: FontWeight.w600),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  RotatedBox(quarterTurns: 1, child: Divider()),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        print("tapped");
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: GoFlexeTabBar(
                                            index: 1,
                                            centerIndex: 1,
                                          )),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.temperatureHigh,
                                            color: Color(0xFFea9b88),
                                            size: 18,
                                          ),
                                          Text(
                                            "Home Care",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // Divider(),
                                          // Text(
                                          //   "Find centres near you",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontSize: 11,
                                          //       fontWeight: FontWeight.w600),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  RotatedBox(quarterTurns: 1, child: Divider()),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        print("tapped");
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: GoFlexeTabBar(index: 2)),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.hospital,
                                            color: Color(0xFF22b27f),
                                            size: 18,
                                          ),
                                          Text(
                                            "Hospitals",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // Divider(),
                                          // Text(
                                          //   "Find centres near you",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontSize: 11,
                                          //       fontWeight: FontWeight.w600),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  RotatedBox(quarterTurns: 1, child: Divider()),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        print("tapped");
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: GoFlexeTabBar(index: 3)),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.syringe,
                                            color: Color(0xFF63afcb),
                                            size: 18,
                                          ),
                                          Text(
                                            "Vaccine",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // Divider(),
                                          // Text(
                                          //   "Find centres near you",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontSize: 11,
                                          //       fontWeight: FontWeight.w600),
                                          // )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  box10,
                  Container(
                    color: Colors.transparent,
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey[300],
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: StatsTabBar()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.newspaper,
                                      color: primaryColor,
                                      size: 28,
                                    ),
                                    Text(
                                      "Live Data",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RotatedBox(quarterTurns: 1, child: Divider()),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: FAQ()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.question,
                                      color: Color(0xFF1eae98),
                                      size: 28,
                                    ),
                                    Text(
                                      "FAQ's",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RotatedBox(quarterTurns: 1, child: Divider()),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: MythBusters()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.lightbulb,
                                      color: Colors.yellow[600],
                                      size: 28,
                                    ),
                                    Text(
                                      "MythBusters",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RotatedBox(quarterTurns: 1, child: Divider()),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: TwitterScreen()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.twitter,
                                      color: Color(0xFF1DA1F2),
                                      size: 28,
                                    ),
                                    Text(
                                      "Resources",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //box10,
                  // Container(
                  //   color: Colors.transparent,
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   height: 200,
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(
                  //         color: Colors.grey[300],
                  //         width: 0.5,
                  //       ),
                  //       borderRadius: BorderRadius.circular(5.0),
                  //     ),
                  //     shadowColor: Colors.black,
                  //     color: Colors.white,
                  //     child: Container(
                  //       padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  //       child: Column(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 20),
                  //             child: Text(
                  //               "Realtime Covid Data",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontSize: 17, fontWeight: FontWeight.w600),
                  //             ),
                  //           ),
                  //           Expanded(
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceEvenly,
                  //               children: [
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       print("tapped");
                  //                       Navigator.push(
                  //                         context,
                  //                         FadeRoute(
                  //                             page: GoFlexeTabBar(index: 0)),
                  //                       );
                  //                     },
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       children: [
                  //                         FaIcon(
                  //                           Icons.all_out,
                  //                           color: Color(0xFFc14098),
                  //                           size: 18,
                  //                         ),
                  //                         Column(
                  //                           children: [
                  //                             Text(
                  //                               "All Over India",
                  //                               style: TextStyle(
                  //                                   fontSize: 11,
                  //                                   fontWeight:
                  //                                       FontWeight.w600),
                  //                             ),
                  //                             // SizedBox(
                  //                             //   height: 5,
                  //                             // ),
                  //                             // Text(
                  //                             //   "See Covid Cases All over india",
                  //                             //   textAlign: TextAlign.center,
                  //                             //   style: TextStyle(
                  //                             //     fontSize: 10,
                  //                             //   ),
                  //                             // )
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 RotatedBox(quarterTurns: 1, child: Divider()),
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       print("tapped");
                  //                       Navigator.push(
                  //                         context,
                  //                         FadeRoute(
                  //                             page: GoFlexeTabBar(index: 1)),
                  //                       );
                  //                     },
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       children: [
                  //                         FaIcon(
                  //                           FontAwesomeIcons.temperatureHigh,
                  //                           color: Color(0xFFea9b88),
                  //                           size: 18,
                  //                         ),
                  //                         Text(
                  //                           "State Wise",
                  //                           style: TextStyle(
                  //                               fontSize: 11,
                  //                               fontWeight: FontWeight.w600),
                  //                         ),
                  //                         // Divider(),
                  //                         // Text(
                  //                         //   "Find centres near you",
                  //                         //   textAlign: TextAlign.center,
                  //                         //   style: TextStyle(
                  //                         //       fontSize: 11,
                  //                         //       fontWeight: FontWeight.w600),
                  //                         // )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 RotatedBox(quarterTurns: 1, child: Divider()),
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       print("tapped");
                  //                       Navigator.push(
                  //                         context,
                  //                         FadeRoute(
                  //                             page: GoFlexeTabBar(index: 2)),
                  //                       );
                  //                     },
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       children: [
                  //                         FaIcon(
                  //                           FontAwesomeIcons.hospital,
                  //                           color: Color(0xFF22b27f),
                  //                           size: 18,
                  //                         ),
                  //                         Text(
                  //                           "Global",
                  //                           style: TextStyle(
                  //                               fontSize: 11,
                  //                               fontWeight: FontWeight.w600),
                  //                         ),
                  //                         // Divider(),
                  //                         // Text(
                  //                         //   "Find centres near you",
                  //                         //   textAlign: TextAlign.center,
                  //                         //   style: TextStyle(
                  //                         //       fontSize: 11,
                  //                         //       fontWeight: FontWeight.w600),
                  //                         // )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 RotatedBox(quarterTurns: 1, child: Divider()),
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       print("tapped");
                  //                       Navigator.push(
                  //                         context,
                  //                         FadeRoute(
                  //                             page: GoFlexeTabBar(index: 3)),
                  //                       );
                  //                     },
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       children: [
                  //                         FaIcon(
                  //                           FontAwesomeIcons.syringe,
                  //                           color: Color(0xFF63afcb),
                  //                           size: 18,
                  //                         ),
                  //                         Text(
                  //                           "Country Wise",
                  //                           style: TextStyle(
                  //                               fontSize: 11,
                  //                               fontWeight: FontWeight.w600),
                  //                         ),
                  //                         // Divider(),
                  //                         // Text(
                  //                         //   "Find centres near you",
                  //                         //   textAlign: TextAlign.center,
                  //                         //   style: TextStyle(
                  //                         //       fontSize: 11,
                  //                         //       fontWeight: FontWeight.w600),
                  //                         // )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  box20,
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 8),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [
                        Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(page: IndiaHelplines()),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration:
                                //     BoxDecoration(color: Colors.lightBlue[50]),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Image.asset("assets/help.png"),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("Covid-19 Help Lines",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            box10,
                                            Text(
                                              '#IndiaFightsCorona',
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Lets Fight Together!!!',
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(page: StatsTabBar()),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration:
                                //     BoxDecoration(color: Colors.lightBlue[50]),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Image.asset("assets/graph.png"),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("Track Live Data",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            box10,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "See Live Covid Cases of India and it's States",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
