import 'package:crisis/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Vaccination extends StatefulWidget {
  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFf9a825), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () async {
                await launch("https://selfregistration.cowin.gov.in/");
              },
              child: Text(
                "Get Vaccinated",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        body: loading == true
            ? Loading()
            : SingleChildScrollView(
                child: Form(
                    child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                          height: 100,
                          child: Image.asset("assets/injection.png")),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ))));
  }
}
