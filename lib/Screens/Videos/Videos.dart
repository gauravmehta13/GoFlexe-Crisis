import 'package:crisis/Widgets/Loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants.dart';
import 'English Videos.dart';
import 'Hindi Videos.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'Informative Videos',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: loading == true
          ? Loading()
          : Column(
              children: [
                box20,
                Container(
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
                          "English",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      // second tab [you can add an icon using the icon property]
                      Tab(
                        child: Text(
                          "हिंदी",
                          style: TextStyle(fontSize: 13),
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
                      EnglishVideos(),
                      HindiVideos(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
