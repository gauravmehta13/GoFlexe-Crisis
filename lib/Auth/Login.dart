// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:packers/Order/Residential%20Move.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../Order/Payment Page.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

// class Login extends StatefulWidget {
//   Login({Key key}) : super(key: key);
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _formKey = GlobalKey<FormState>();
//   final _formKeyOTP = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   final _phoneController = TextEditingController();
//   final _otpController = TextEditingController();
//   final nameController = TextEditingController();

//   var isLoading = false;
//   var isResend = false;
//   var isLoginScreen = true;
//   var isOTPScreen = false;
//   var verificationCode = '';
//   @override
//   void initState() {
//     if (_auth.currentUser != null) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => ResidentialMove(),
//         ),
//         (route) => false,
//       );
//     }
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is disposed
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   bool isloading = false;
//   bool otpSent = false;

//   Widget build(BuildContext context) {
//     Widget LoginButton;
//     if (isloading) {
//       LoginButton = Center(
//         child: CircularProgressIndicator(
//           valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFfbad20)),
//         ),
//       );
//     } else {
//       LoginButton = MaterialButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Payment()),
//             );
//           },
//           color: Color(0xFFf9a825),
//           height: 45,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: BorderSide(
//                 color: Color(0xFFf9a825),
//               )),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Login',
//                 style: TextStyle(color: Color(0xff002a66)),
//               )
//             ],
//           ));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "Packers & Movers",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//         ),
//       ),
//       key: _scaffoldKey,
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Please Login to Proceed",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.dmSans(
//                     fontSize: 20,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 new TextFormField(
//                   controller: nameController,
//                   keyboardType: TextInputType.text,
//                   decoration: new InputDecoration(
//                     isDense: true, // Added this
//                     contentPadding: EdgeInsets.all(15),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Color(0xFF2821B5),
//                       ),
//                     ),
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.grey)),
//                     labelText: 'Enter Name',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),

//                 SizedBox(
//                   height: 20,
//                 ),
//                 new TextFormField(
//                   controller: _phoneController,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter phone number';
//                     }
//                   },
//                   decoration: new InputDecoration(
//                     isDense: true, // Added this
//                     contentPadding: EdgeInsets.all(15),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Color(0xFF2821B5),
//                       ),
//                     ),
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.grey)),
//                     labelText: 'Enter Phone',
//                   ),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),
//                 otpSent == true
//                     ? Center(child: Text("OTP sent successfully"))
//                     : Container(),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 otpSent == true
//                     ? Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: PinCodeTextField(
//                                   appContext: context,
//                                   pastedTextStyle: TextStyle(
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   length: 4,
//                                   obscureText: false,
//                                   obscuringCharacter: '*',
//                                   blinkWhenObscuring: true,
//                                   animationType: AnimationType.fade,
//                                   pinTheme: PinTheme(
//                                     shape: PinCodeFieldShape.box,
//                                     borderWidth: 1,
//                                     borderRadius: BorderRadius.circular(5),
//                                     inactiveFillColor: Colors.white,
//                                     inactiveColor: Colors.grey,
//                                     fieldHeight: 50,
//                                     fieldWidth: 50,
//                                     // activeFillColor:
//                                     //     hasError ? Colors.blue.shade100 : Colors.white,
//                                   ),
//                                   cursorColor: Colors.black,
//                                   animationDuration:
//                                       Duration(milliseconds: 300),
//                                   enableActiveFill: true,
//                                   // controller: otpController,
//                                   keyboardType: TextInputType.number,
//                                   boxShadows: [
//                                     BoxShadow(
//                                       offset: Offset(0, 1),
//                                       color: Colors.black12,
//                                       blurRadius: 10,
//                                     )
//                                   ],
//                                   onCompleted: (v) {
//                                     print("Completed");
//                                   },
//                                   // onTap: () {
//                                   //   print("Pressed");
//                                   // },
//                                   onChanged: (value) {
//                                     print(value);
//                                   },
//                                   beforeTextPaste: (text) {
//                                     print("Allowing to paste $text");
//                                     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                                     //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                                     return true;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Column(
//                                 children: [
//                                   MaterialButton(
//                                       padding: EdgeInsets.all(0),
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => Payment()),
//                                         );
//                                       },
//                                       color: Color(0xFFf9a825),
//                                       height: 49,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           side: BorderSide(
//                                             color: Color(0xFFf9a825),
//                                           )),
//                                       child: Text(
//                                         'Submit',
//                                         style:
//                                             TextStyle(color: Color(0xff002a66)),
//                                       )),
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       )
//                     : Container(),
//                 otpSent == false
//                     ? MaterialButton(
//                         onPressed: () async {
//                           await signUp();
//                         },
//                         color: Color(0xFFf9a825),
//                         height: 45,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             side: BorderSide(
//                               color: Color(0xFFf9a825),
//                             )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Send OTP',
//                               style: TextStyle(color: Color(0xff002a66)),
//                             )
//                           ],
//                         ))
//                     : Container(),
//                 // LoginButton,
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   displaySnackBar(text) {
//     final snackBar = SnackBar(content: Text(text));
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }

//   Future login() async {
//     setState(() {
//       isLoading = true;
//     });

//     var phoneNumber = '+91 ' + _phoneController.text.trim();

//     //first we will check if a user with this cell number exists
//     var isValidUser = false;
//     var number = _phoneController.text.trim();

//     // await _firestore
//     //     .collection('users')
//     //     .where('cellnumber', isEqualTo: number)
//     //     .get()
//     //     .then((result) {
//     //   if (result.docs.length > 0) {
//     //     isValidUser = true;
//     //   }
//     // });

//     //ok, we have a valid user, now lets do otp verification
//     var verifyPhoneNumber = _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (phoneAuthCredential) {
//         //auto code complete (not manually)
//         _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
//               if (user != null)
//                 {
//                   //redirect
//                   setState(() {
//                     isLoading = false;
//                     isOTPScreen = false;
//                   }),
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => ResidentialMove(),
//                     ),
//                     (route) => false,
//                   )
//                 }
//             });
//       },
//       verificationFailed: (FirebaseAuthException error) {
//         displaySnackBar('Validation error, please try again later');
//         setState(() {
//           isLoading = false;
//         });
//       },
//       codeSent: (verificationId, [forceResendingToken]) {
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//           isOTPScreen = true;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//         });
//       },
//       timeout: Duration(seconds: 60),
//     );
//     await verifyPhoneNumber;
//   }

//   Future signUp() async {
//     setState(() {
//       isLoading = true;
//     });
//     debugPrint('Gideon test 1');
//     var phoneNumber = '+91 ' + _phoneController.text.toString();
//     debugPrint('Gideon test 2');
//     var verifyPhoneNumber = _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (phoneAuthCredential) {
//         debugPrint('Gideon test 3');
//         //auto code complete (not manually)
//         _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
//               if (user != null)
//                 {
//                   //store registration details in firestore database
//                   // await _firestore
//                   //     .collection('users')
//                   //     .doc(_auth.currentUser.uid)
//                   //     .set({
//                   //       'name': nameController.text.trim(),
//                   //       'cellnumber': _phoneController.text.trim()
//                   //     }, SetOptions(merge: true))
//                   //     .then((value) => {
//                   //then move to authorised area
//                   setState(() {
//                     isLoading = false;
//                     // isRegister = false;
//                     isOTPScreen = false;

//                     //navigate to is
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => ResidentialMove(),
//                       ),
//                       (route) => false,
//                     );
//                   })
//                 }
//             });
//         debugPrint('Gideon test 4');
//       },
//       verificationFailed: (FirebaseAuthException error) {
//         debugPrint('Gideon test 5' + error.message);
//         setState(() {
//           isLoading = false;
//         });
//       },
//       codeSent: (verificationId, [forceResendingToken]) {
//         debugPrint('Gideon test 6');
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         debugPrint('Gideon test 7');
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//         });
//       },
//       timeout: Duration(seconds: 60),
//     );
//     debugPrint('Gideon test 7');
//     await verifyPhoneNumber;
//     debugPrint('Gideon test 8');
//   }
// }
