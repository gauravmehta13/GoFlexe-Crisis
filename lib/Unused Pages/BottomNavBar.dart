import 'package:crisis/Screens/Covid%20Stats/Stats%20TabBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTabIndex = 0;

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  List<Widget> tabs = [
    StatsTabBar(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: TitledBottomNavigationBar(
          indicatorColor: Color(0xFF3f51b5),
          activeColor: Color(0xFF3f51b5),
          currentIndex: currentTabIndex,
          onTap: (index) {
            onTapped(index);
          },
          items: [
            TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
            TitledNavigationBarItem(
                title: Text('My Orders'), icon: FontAwesomeIcons.boxOpen),
          ]),
    );
  }
}
