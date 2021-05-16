import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/Hospital/Hospital.dart';
import 'package:crisis/Screens/Disclaimer.dart';
import 'package:crisis/Screens/Faq.dart';
import 'package:crisis/Screens/MythBusters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Fade Route.dart';
import 'Screens/Covid Stats/Stats TabBar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void initState() {
    // getUser();
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Color(0xFF3f51b5)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _auth?.currentUser?.phoneNumber != null
                              ? Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            (_auth?.currentUser?.phoneNumber ??
                                                ""),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              : Container(
                                  child: Text("GoFlexe Crisis",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),
                                ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  )),
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
                  displaySnackBar("Coming Soon", context);
                  // Navigator.push(
                  //   context,
                  //   FadeRoute(page: StatsTabBar()),
                  // );
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
              Spacer(),
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
              ListTile(
                dense: true,
                onTap: () {
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
  const uri = 'mailto:contact@goflexe.com';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
