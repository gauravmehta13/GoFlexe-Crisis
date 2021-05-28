import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Constants.dart';

class Login extends StatefulWidget {
  final Widget page;
  Login(this.page);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ConfirmationResult confirmationResult;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';
  StreamSubscription<User> subscription;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
////////////////////////////////////////////////////////////////////////
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool phone = false;

  Future googleLogin() async {
    final user = await googleSignIn.signIn();
    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  checkAuthentification() async {
    subscription = _auth.authStateChanges().listen((null));
    subscription.onData((data) {
      if (data != null) {
        print(data);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.page));
        subscription.cancel();
      }
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    if (kIsWeb) {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();
      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    Widget LoginButton;
    if (isLoading) {
      LoginButton = Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFfbad20)),
        ),
      );
    } else {
      LoginButton = isOTPScreen
          ? MaterialButton(
              color: const Color(0xFF2821B5),
              height: 45,
              minWidth: double.maxFinite,
              onPressed: () {
                verifyOTP();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Color(0xFF2821B5),
                  )),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ))
          : MaterialButton(
              color: const Color(0xFF2821B5),
              height: 45,
              minWidth: double.maxFinite,
              onPressed: () {
                phoneLogin();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Color(0xFF2821B5),
                  )),
              child: Text(
                'Send OTP',
                style: TextStyle(color: Colors.white),
              ));
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          key: _formKey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      skipLogin = true;
                    });
                    subscription.cancel();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => widget.page),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF2821B5),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'GoFlexe',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF2821B5),
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  new TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: phoneController,
                    maxLength: 10,
                    validator: (value) =>
                        value.length < 10 ? "Enter correct number" : null,
                    decoration: new InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF2821B5),
                        ),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey)),
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                  if (isOTPScreen) box20,
                  if (isOTPScreen)
                    Container(
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
                    ))
                ],
              ),
              box20,
              LoginButton,
              box10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        child: Divider(
                      thickness: 1.5,
                    )),
                  ),
                  Text(
                    "  or  ",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Expanded(
                    child: Container(
                        child: Divider(
                      thickness: 1.5,
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: MaterialButton(
                    height: 45,
                    onPressed: () {
                      googleLogin();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: Color(0xff3b5998),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png', scale: 3),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(color: Color(0xff3b5998)),
                        )
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: MaterialButton(
                          height: 45,
                          onPressed: () {
                            displaySnackBar("Coming Soon", context);
                            // signInWithFacebook();
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Color(0xff3b5998),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/facebook.png', scale: 3),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                  color:
                                      phone ? Colors.white : Color(0xff3b5998),
                                ),
                              )
                            ],
                          ))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "By logging in, you accept GoFlexe's Terms of\nservice and Privacy ",
                textAlign: TextAlign.center,
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      displaySnackBar(e.message, context);
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  clearCaptcha() {
    if (kIsWeb) {
      print("Clearing Captcha");
      RecaptchaVerifier().clear();
    }
  }

  Future phoneLogin() async {
    setState(() {
      isLoading = true;
    });
    if (kIsWeb == true) {
      confirmationResult = await _auth.signInWithPhoneNumber(
          '+91 ' + phoneController.text.toString(), RecaptchaVerifier());
      setState(() {
        confirmationResult = confirmationResult;
        isLoading = false;
        isOTPScreen = true;
      });
    } else {
      var phoneNumber = '+91 ' + phoneController.text.trim();
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
                        builder: (BuildContext context) => widget.page,
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
    clearCaptcha();
    // If the form is valid, we want to show a loading Snackbar
    // If the form is valid, we want to do firebase signup...
    setState(() {
      isResend = false;
      isLoading = true;
    });
    print(kIsWeb);
    if (kIsWeb == true) {
      print("web");
      UserCredential userCredential =
          await confirmationResult.confirm(otpController.text)
              // ignore: missing_return
              .then((user) {
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => widget.page),
          );
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
      try {
        await _auth
            .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: verificationCode,
                smsCode: otpController.text.toString()))
            .then((user) async => {
                  if (user != null)
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => widget.page),
                      ),
                      setState(() {
                        isLoading = false;
                        isResend = false;
                      }),
                    }
                })
            .catchError((error) {
          displaySnackBar(error, context);
          setState(() {
            isLoading = false;
            isResend = false;
          });
        });
      } catch (e) {
        displaySnackBar(e, context);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
