import 'dart:async';
import 'package:crisis/Drawer.dart';
import 'package:crisis/HomePage/Home%20Treatment/Home%20treatment.dart';
import 'package:crisis/HomePage/Hospital/Hospital.dart';
import 'package:crisis/HomePage/Testing/Testing.dart';
import 'package:crisis/HomePage/Vaccination/Vaccination.dart';
import 'package:crisis/Widgets/Found%20What%20Needed%20Dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class GoFlexeTabBar extends StatefulWidget {
  final index;
  final centerIndex;
  GoFlexeTabBar({this.index, this.centerIndex});
  @override
  _GoFlexeTabBarState createState() => _GoFlexeTabBarState();
}

class _GoFlexeTabBarState extends State<GoFlexeTabBar>
    with TickerProviderStateMixin {
  TabController _tabController;
  Timer _timer;

  @override
  void initState() {
    checkLogin(GoFlexeTabBar(), context);
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.index ?? 0);
    super.initState();
    _timer = new Timer(const Duration(minutes: 1), () {
      FirebaseAnalytics().logEvent(name: 'Feedback_Popup', parameters: null);
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
  }

  Future<bool> _willPopCallback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool foundPopup = prefs.getBool('foundPopup');
    print(foundPopup);
    if (foundPopup != true) {
      await showDialog(
          context: context, builder: (ctx) => FoundWhatNeededDialog());
      prefs.setBool('foundPopup', true);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "GoFlexe",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                FirebaseAnalytics()
                    .logEvent(name: 'Shared_Website', parameters: null);
                Share.share(
                    '\n https://crisis.goflexe.com/ \n\nYou will help patients and their families by accessing covid related resources such as diagnostic center, home treatment, hospital bed availability and vaccination centres near them.\n\nYou will be able to spread awareness about corona related myths and clarifying frequently asked questions. Goflexe has connected with authentic government and private sources to bring you verified data.Please share with your friends and families. We’ll get through this crisis together. 🙏');
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Home Treatment",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Hospitalisation",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // second tab [you can add an icon using the icon property]

                  Tab(
                    child: Text(
                      "Vaccination",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
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
                children: [
                  Testing(
                    diagnostic: widget.centerIndex == 0 ? true : false,
                  ),
                  HomeTreatment(
                    homeCare: widget.centerIndex == 1 ? true : false,
                  ),
                  Hospital(),
                  Vaccination()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
