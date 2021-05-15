import 'package:crisis/Screens/Covid%20Stats/Stats.dart';
import 'package:crisis/Screens/Covid%20Stats/Indian%20States.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class StatsTabBar extends StatefulWidget {
  @override
  _StatsTabBarState createState() => _StatsTabBarState();
}

class _StatsTabBarState extends State<StatsTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Covid Tracking",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          box30,
          Container(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Positioned(
                      top: 40,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              color: Color(0xFF3f51b5)),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              child: Text(
                                "All Over India",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            // second tab [you can add an icon using the icon property]
                            Tab(
                              child: Text(
                                "State Wise",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CovidStats(),
                IndianStates(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
