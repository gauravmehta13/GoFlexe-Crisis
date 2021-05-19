import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/Hospital/Hospital.dart';
import 'package:crisis/Screens/Disclaimer.dart';
import 'package:crisis/Screens/Faq.dart';
import 'package:crisis/Screens/MythBusters.dart';
import 'package:crisis/Screens/Twitter%20Search/Twitter%20Search.dart';
import 'package:crisis/Screens/india_helplines.dart';
import 'package:crisis/Videos.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Fade Route.dart';
import 'Screens/Covid Stats/Stats TabBar.dart';
import 'Screens/Self Asses/Self Assesment.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void initState() {
    FirebaseAnalytics().logEvent(name: 'App_Drawer', parameters: null);
    super.initState();
  }

  var userName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: AppBar().preferredSize.height,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Color(0xFF3f51b5)),
                child: _auth?.currentUser?.phoneNumber != null
                    ? Text((_auth?.currentUser?.phoneNumber ?? ""),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ))
                    : Text("GoFlexe Crisis",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        )),
              ),
              ListTile(
                dense: true, // minLeadingWidth: 25,
                onTap: () {
                  Navigator.pop(context);
                },
                title: Text("Home"),
                leading: FaIcon(
                  FontAwesomeIcons.home,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    FadeRoute(page: StatsTabBar()),
                  );
                },
                title: Text("Live Data"),
                leading: FaIcon(
                  FontAwesomeIcons.solidNewspaper,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: Videos()),
                  );
                },
                title: Text("Self Assesment"),
                leading: FaIcon(
                  FontAwesomeIcons.personBooth,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: FAQ()),
                  );
                },
                title: Text("FAQ's"),
                leading: FaIcon(
                  FontAwesomeIcons.question,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: MythBusters()),
                  );
                },
                title: Text("MythBusters"),
                leading: FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: TwitterScreen()),
                  );
                },
                title: Text("Twitter Resources"),
                leading: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              Spacer(),
              ListTile(
                dense: true,
                onTap: () {
                  FirebaseAnalytics()
                      .logEvent(name: 'Contact_Us', parameters: null);
                  _sendMail();
                },
                title: Text(
                  "Contact Us",
                ),
                leading: FaIcon(
                  FontAwesomeIcons.mailBulk,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: IndiaHelplines()),
                  );
                },
                title: Text("Covid-19 Help"),
                leading: FaIcon(
                  FontAwesomeIcons.handsHelping,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pop(context);
                  giveFeedback(context);
                },
                title: Text("Give Feedback"),
                // minLeadingWidth: 25,
                leading: FaIcon(
                  Icons.feedback,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  FirebaseAnalytics()
                      .logEvent(name: 'Medical_Disclaimer', parameters: null);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(page: Disclaimer()),
                  );
                },
                title: Text("Medical Disclaimer"),
                leading: FaIcon(
                  FontAwesomeIcons.notesMedical,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              box10,
              if (_auth.currentUser != null)
                ListTile(
                  dense: true,
                  onTap: () async {
                    signOut();
                  },
                  title: Text("SignOut"),
                  leading: FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.black87,
                    size: 18,
                  ),
                ),
              Container(
                color: primaryColor,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text("Powered By GoFlexe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signOut() {
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Hospital())));
  }
}

_sendMail() async {
  // Android and iOS
  const uri = 'mailto:goflexe@gmail.com';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
