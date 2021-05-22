import 'package:crisis/Constants.dart';
import 'package:crisis/Screens/Covid%20Help/Raise%20help%20request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Fade Route.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FoundWhatNeededDialog extends StatefulWidget {
  @override
  _FoundWhatNeededDialogState createState() => _FoundWhatNeededDialogState();
}

class _FoundWhatNeededDialogState extends State<FoundWhatNeededDialog> {
  var controller = TextEditingController();

  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      controller.text = _auth.currentUser.phoneNumber.substring(3, 13);
    }
  }

  bool notFound = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
                margin: EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    notFound == false
                        ? Text(
                            "Did you find what you were looking for?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )
                        : Text(
                            "Please Enter your phone number so that we can help you further.",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    if (notFound == true)
                      Column(
                        children: [
                          TextFormField(
                            controller: controller,
                            maxLength: 10,
                            decoration: const InputDecoration(
                                isDense: true, hintText: "Enter Contact No."),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 22,
                    ),
                    notFound == false
                        ? Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(fontSize: 18),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(page: RaiseHelpRequest()),
                                      );
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              displaySnackBar(
                                  "Request Submitted Successfully", context);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(fontSize: 18),
                            )),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      child: Image.asset(
                        "assets/found.png",
                        fit: BoxFit.contain,
                      )),
                ),
              ),
            ],
          ));
    });
  }
}
