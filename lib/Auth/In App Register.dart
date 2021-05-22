import 'dart:convert';

import 'package:crisis/Constants.dart';
import 'package:crisis/Fade%20Route.dart';
import 'package:crisis/HomePage/HomePage.dart';
import 'package:crisis/HomePage/TabBar.dart';
import 'package:crisis/Screens/Covid%20Help/Join%20As%20Volunteer.dart';
import 'package:crisis/Screens/Covid%20Help/Raise%20help%20request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class InAppRegister extends StatefulWidget {
  final String screenName;
  final String pincode;
  final String district;
  final String districtCode;

  InAppRegister(
      {this.districtCode,
      this.pincode,
      this.screenName,
      this.district,
      Key key})
      : super(key: key);

  @override
  _InAppRegisterState createState() => _InAppRegisterState();
}

class _InAppRegisterState extends State<InAppRegister> {
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
  var vaccineRegistrationCompleted = false;
  var verificationCode = '';

  //Form controllers
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the Widget is disposed
  //   nameController.dispose();
  //   cellnumberController.dispose();
  //   otpController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen
        ? vaccineRegistrationCompleted
            ? returnregistrationCompleted()
            : returnOTPScreen()
        : registerScreen();
  }

  Widget returnregistrationCompleted() {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
          height: 50,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Color(0xFFf9a825),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            child: Text(
              "Return to Home Screen",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/check.png",
              height: 100,
            ),
            box30,
            Text(
              "Registration Successful",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            box20,
            Text(
              "You will get an SMS when the Vaccine Slots will become available in your area.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget registerScreen() {
    final node = FocusScope.of(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text('Goflexe'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    "You Need to Login First",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 130,
                    child: Image.asset('assets/holding-phone.png'),
                  ),
                  box30,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                    child: Text(
                      "You'll receive a 4 digit code to verify next.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                  Spacer(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    autofocus: true,
                                    enabled: !isLoading,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(fontSize: 14),
                                    controller: cellnumberController,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 10,
                                    onFieldSubmitted: (_) => node.unfocus(),
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  new ElevatedButton(
                                    onPressed: () {
                                      if (!isLoading) {
                                        if (_formKey.currentState.validate()) {
                                          // If the form is valid, we want to show a loading Snackbar
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              )),
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
          '+91 ' + cellnumberController.text.toString(), RecaptchaVerifier());
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
                    if (widget.screenName == "Vaccination")
                      {await submitVaccinationRequest()}
                    else if (widget.screenName == "Volunteer")
                      {
                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: VolunteerJoin()),
                        )
                      }
                    else if (widget.screenName == "Help")
                      {
                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: RaiseHelpRequest()),
                        )
                      },
                    setState(() {
                      isLoading = false;
                    }),
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
    clearCaptcha();
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
                .then((user) async {
          if (user != null) {
            if (widget.screenName == "Vaccination") {
              await submitVaccinationRequest();
            } else if (widget.screenName == "Volunteer") {
              Navigator.pushReplacement(
                context,
                FadeRoute(page: VolunteerJoin()),
              );
            } else if (widget.screenName == "Help") {
              Navigator.pushReplacement(
                context,
                FadeRoute(page: RaiseHelpRequest()),
              );
            }
            setState(() {
              isLoading = false;
              isResend = false;
            });
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
                        if (widget.screenName == "Vaccination")
                          {await submitVaccinationRequest()}
                        else if (widget.screenName == "Volunteer")
                          {
                            Navigator.pushReplacement(
                              context,
                              FadeRoute(page: VolunteerJoin()),
                            )
                          }
                        else if (widget.screenName == "Help")
                          {
                            Navigator.pushReplacement(
                              context,
                              FadeRoute(page: RaiseHelpRequest()),
                            )
                          },
                        setState(() {
                          isLoading = false;
                          isResend = false;
                        }),
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

  clearCaptcha() {
    print("Clearing Captcha");
    RecaptchaVerifier().clear();
  }

  submitVaccinationRequest() async {
    var dio = Dio();
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            "tenantSet_id": "CRISIS01",
            "useCase": "registerVaccine",
            "tenantUsecase": "register",
            "phone": _auth.currentUser.phoneNumber,
            "pincode": widget.pincode,
            "district": widget.district
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      displayTimedSnackBar(map["resp"]["allProces"], context, 2);
    } catch (e) {
      print(e);
      setState(() {
        vaccineRegistrationCompleted = true;
      });
    }
  }
}
