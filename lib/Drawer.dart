import 'package:crisis/HomePage/Hospital.dart';
import 'package:crisis/Order/Stats.dart';
import 'package:crisis/Order/health.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Fade Route.dart';
import 'Order/Stats TabBar.dart';
import 'Order/indian_states.dart';
import 'Screens/Order/My Orders.dart';
import 'Videos.dart';

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
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
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
                                        // Text(userName,
                                        //     //   name,
                                        //     style: TextStyle(
                                        //       fontWeight: FontWeight.w600,
                                        //       fontSize: 14,
                                        //       color: Colors.white,
                                        //     )),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
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

              Spacer(),
              // ListTile(
              //   dense: true,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       FadeRoute(page: Videos()),
              //     );
              //   },
              //   title: Text("About Us"),
              //   // minLeadingWidth: 25,
              //   leading: FaIcon(
              //     FontAwesomeIcons.youtube,
              //     color: Colors.black87,
              //     size: 18,
              //   ),
              // ),
              // ListTile(
              //   dense: true,
              //   onTap: () async {
              //     const url = 'https://partnergoflexe.netlify.app/#/';

              //     if (await canLaunch(url)) {
              //       await launch(url, forceSafariVC: false);
              //     } else {
              //       throw 'Could not launch $url';
              //     }
              //   },
              //   title: Text("Join as Partner"),
              //   // minLeadingWidth: 25,
              //   leading: FaIcon(
              //     FontAwesomeIcons.peopleCarry,
              //     color: Colors.black87,
              //     size: 18,
              //   ),
              // ),
              ListTile(
                dense: true,
                onTap: () {},
                title: Text("Report a Complaint"),
                // minLeadingWidth: 25,
                leading: FaIcon(
                  FontAwesomeIcons.heartBroken,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              ExpansionTile(
                title: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.mailBulk,
                      color: Colors.black87,
                      size: 18,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Color(0xFF0072b1),
                          ),
                          onPressed: () {}),
                      IconButton(
                        icon: Icon(
                          Icons.mail_outline,
                          color: Color(0xFFD44638),
                        ),
                        onPressed: () {
                          _sendMail();
                        },
                      ),
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Color(0xFF00acee),
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.telegram,
                            color: Color(0xFF0088cc),
                          ),
                          onPressed: () {})
                    ],
                  )
                  // ListTile(
                  //   onTap: () {},
                  //   title: Text("E-Mail"),
                  // minLeadingWidth: 25,
                  //   leading: Icon(
                  //     Icons.mail_outline,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: () {},
                  //   title: Text("LinkedIn"),
                  // minLeadingWidth: 25,
                  //   leading: FaIcon(
                  //     FontAwesomeIcons.linkedin,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                ],
              ),
              Divider(),
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
