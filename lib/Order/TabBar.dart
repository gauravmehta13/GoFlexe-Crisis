import 'package:crisis/Drawer.dart';
import 'package:crisis/Order/Awareness.dart';
import 'package:crisis/Order/Hospital.dart';
import 'package:flutter/material.dart';

class GoFlexeTabBar extends StatefulWidget {
  @override
  _GoFlexeTabBarState createState() => _GoFlexeTabBarState();
}

class _GoFlexeTabBarState extends State<GoFlexeTabBar>
    with TickerProviderStateMixin {
  TabController _tabController;
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "GoFlexe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        // bottom: TabBar(
        //   controller: _controller,
        //   tabs: [
        //     Tab(
        //       text: "Covid Resources",
        //     ),
        //   ],
        // ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Stack(
              children: [
                Container(height: 60, color: Color(0xFF3f51b5)),
                Positioned(
                  top: 40,
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 30,
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
                      isScrollable: true,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            "Testing",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        // second tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            "Home Treatment",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Hospitalisation",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Vaccination",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
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
                Hospital(),
                Awareness(),
                Container(
                  child: Center(
                    child: Text("Coming Soon"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("Coming Soon"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
