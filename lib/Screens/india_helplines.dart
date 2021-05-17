import 'package:crisis/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class IndiaHelplines extends StatefulWidget {
  @override
  _IndiaHelplinesState createState() => _IndiaHelplinesState();
}

class _IndiaHelplinesState extends State<IndiaHelplines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [primaryColor, primaryColor]),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '#IndiaFightsCorona',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Lets Fight Together!!!',
                        style: TextStyle(color: Colors.white),
                      ),
                      box20,
                      Image.asset(
                        'assets/fight-corona.png',
                        alignment: Alignment.bottomCenter,
                        height: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.phone),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('Helpline Number'),
                subtitle: Text('+91-11-23978046'),
                onTap: () => _launchURL('tel:+91-11-23978046'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.email),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('Helpline Email ID'),
                subtitle: Text('ncov2019@gov.in'),
                onTap: () => _launchURL('mailto:ncov2019@gov.in'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.phone),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('Toll Free'),
                subtitle: Text('1075'),
                onTap: () => _launchURL('tel:1075'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.help),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('State & Union Territories'),
                subtitle: Text('View PDF'),
                onTap: () => _launchURL(
                    'https://www.mohfw.gov.in/pdf/coronvavirushelplinenumber.pdf'),
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  FontAwesomeIcons.rupeeSign,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('Donate to PM Cares'),
                subtitle: Text('Via Website'),
                onTap: () => _launchURL(
                    'https://www.pmcares.gov.in/en?should_open_safari=true'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
