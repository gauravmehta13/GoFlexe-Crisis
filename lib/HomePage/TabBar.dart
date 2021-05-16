import 'dart:async';
import 'package:crisis/Drawer.dart';
import 'package:crisis/HomePage/Home%20Treatment/Home%20treatment.dart';
import 'package:crisis/HomePage/Hospital/Hospital.dart';
import 'package:crisis/HomePage/Testing/Testing.dart';
import 'package:crisis/HomePage/Vaccination/Vaccination.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class GoFlexeTabBar extends StatefulWidget {
  @override
  _GoFlexeTabBarState createState() => _GoFlexeTabBarState();
}

class _GoFlexeTabBarState extends State<GoFlexeTabBar>
    with TickerProviderStateMixin {
  TabController _tabController;
  TabController _controller;
  Timer _timer;

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    _timer = new Timer(const Duration(minutes: 1), () {
      showFeedback();
    });
  }

  showFeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool feedbackDone = prefs.getBool('feedbackDone');
    print("Feedback Done : $feedbackDone");
    if (feedbackDone == null || feedbackDone == false) {
      giveFeedback(context);
      prefs.setBool('feedbackDone', true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: myGlobals.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "GoFlexe",
          style: TextStyle(fontSize: 17),
        ),
        // bottom: TabBar(
        //   controller: _controller,
        //   tabs: [
        //     Tab(
        //       text: "Covid",
        //     ),
        //   ],
        // ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              onTap: (e) {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
              },
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Color(0xFF3f51b5)),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  child: Text(
                    "Testing",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Home Treatment",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Hospitalisation",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // second tab [you can add an icon using the icon property]

                Tab(
                  child: Text(
                    "Vaccination",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [Testing(), HomeTreatment(), Hospital(), Vaccination()],
            ),
          ),
        ],
      ),
    );
  }
}
