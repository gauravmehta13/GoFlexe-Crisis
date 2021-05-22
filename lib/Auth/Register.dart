import 'dart:async';

import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/HomePage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ConfirmationResult confirmationResult;
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController cellnumberController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';

  FocusNode inputNode = FocusNode();
  Timer timer;

  //Form controllers
  @override
  void initState() {
    super.initState();
    setSkip();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (inputNode.hasFocus == false) {
          FocusScope.of(context).requestFocus(inputNode);
        }
        print("object");
      });
    });
    FirebaseAnalytics().logEvent(name: 'Login_Page', parameters: null);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  setSkip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("skippedLogin", true);
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FirebaseAnalytics()
                    .logEvent(name: 'Skipped_Login', parameters: null);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          elevation: 0,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: primaryColor,
                        child: Column(
                          children: <Widget>[
                            box20,
                            Image.asset(
                              'assets/fight-corona.png',
                              alignment: Alignment.bottomCenter,
                              height: 150,
                              fit: BoxFit.fitWidth,
                            ),
                            box30,
                            Text(
                              "Login to GoFlexe Crisis",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 64),
                              child: Text(
                                "You'll receive a 4 digit code to verify next.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            box20
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 230,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Enter your phone",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      TextFormField(
                                        focusNode: inputNode,
                                        autofocus: true,
                                        enabled: !isLoading,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(fontSize: 14),
                                        controller: cellnumberController,
                                        textInputAction: TextInputAction.send,
                                        maxLength: 10,
                                        onEditingComplete: () {
                                          if (!isLoading) {
                                            if (_formKey.currentState
                                                .validate()) {
                                              // If the form is valid, we want to show a loading Snackbar
                                              setState(() {
                                                isRegister = false;
                                                isOTPScreen = true;
                                              });
                                              login();
                                            }
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIconConstraints: BoxConstraints(
                                              minWidth: 0, minHeight: 0),
                                          isDense: true,
                                          prefixIcon: Text("+91 "),
                                        ),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Please enter a Mobile Number';
                                          }
                                          if (10 < text.length ||
                                              10 > text.length) {
                                            return 'Please enter Correct Mobile Number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      new ElevatedButton(
                                        onPressed: () async {
                                          if (!isLoading) {
                                            if (_formKey.currentState
                                                .validate()) {
                                              // If the form is valid, we want to show a loading Snackbar
                                              await timer?.cancel();
                                              setState(() {
                                                isRegister = false;
                                                isOTPScreen = true;
                                              });
                                              login();
                                            }
                                          }
                                        },
                                        child: new Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 15.0,
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Expanded(
                                                child: Text(
                                                  "Continue",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      box20
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )),
            ),
          ),
        ));
  }

  Widget returnOTPScreen() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text('GoFlexe'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKeyOTP,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    !isLoading
                        ? "Code is sent to +91 " + cellnumberController.text
                        : "Please Wait..",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF818181),
                    ),
                  ),
                ),
                Spacer(),
                !isLoading
                    ? Container(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30),
                        child: PinCodeTextField(
                          autoFocus: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          autoDisposeControllers: false,
                          enablePinAutofill: true,
                          controller: otpController,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(5),
                            inactiveFillColor: Colors.white,
                            inactiveColor: Colors.grey,
                            fieldHeight: 50,
                            fieldWidth: 50,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: false,
                          // controller: otpController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                            verifyOTP();
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            return true;
                          },
                        ),
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xFFf9a825)),
                                )
                              ].where((c) => c != null).toList(),
                            )
                          ]),
                Spacer(),
                !isLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Didn't recieve code? ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF818181),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isResend = false;
                                  isLoading = true;
                                });
                                await login();
                              },
                              child: Text(
                                "Request again",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Spacer(),
                !isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 40, bottom: 5),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: new ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFf9a825), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () async {
                                verifyOTP();
                              },
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "Verify and Continue",
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )))
                    : Container(),
                isResend
                    ? Container(
                        margin: EdgeInsets.only(top: 40, bottom: 5),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: new ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isResend = false;
                                  isLoading = true;
                                });
                                await login();
                              },
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "Resend Code",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )))
                    : Column()
              ],
            ),
          ),
        ));
  }

  Future login() async {
    setState(() {
      isLoading = true;
    });
    if (kIsWeb == true) {
      confirmationResult = await _auth.signInWithPhoneNumber(
        '+91 ' + cellnumberController.text.toString(),
        // RecaptchaVerifier()
      );
      setState(() {
        confirmationResult = confirmationResult;
        isLoading = false;
      });
    } else {
      var phoneNumber = '+91 ' + cellnumberController.text.trim();
      //ok, we have a valid user, now lets do otp verification
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          //auto code complete (not manually)
          _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
                if (user != null)
                  {
                    setState(() {
                      isLoading = false;
                    }),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(),
                      ),
                    )
                  }
              });
        },
        verificationFailed: (FirebaseAuthException error) {
          displaySnackBar('Validation error, please try again later', context);
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
            isOTPScreen = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    }
  }

  verifyOTP() async {
    if (_formKeyOTP.currentState.validate()) {
      // If the form is valid, we want to show a loading Snackbar
      // If the form is valid, we want to do firebase signup...
      print("ok1");
      setState(() {
        print("okset");

        isResend = false;
        isLoading = true;
      });
      print("ok2");
      print(kIsWeb);
      if (kIsWeb == true) {
        print("web");
        UserCredential userCredential =
            await confirmationResult.confirm(otpController.text)
                // ignore: missing_return
                .then((user) {
          if (user != null) {
            setState(() {
              isLoading = false;
              isResend = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            );
          }
          setState(() {
            isLoading = false;
            isResend = false;
          });
        });
      }
      if (kIsWeb == false) {
        print("app");
        try {
          print("appTry");
          await _auth
              .signInWithCredential(PhoneAuthProvider.credential(
                  verificationId: verificationCode,
                  smsCode: otpController.text.toString()))
              .then((user) async => {
                    if (user != null)
                      {
                        setState(() {
                          isLoading = false;
                          isResend = false;
                        }),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                        )
                      }
                  })
              .catchError((error) {
            setState(() {
              isLoading = false;
              isResend = false;
            });
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
