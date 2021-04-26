// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'Login.dart';

// class SignUpScreen extends StatefulWidget {
//   SignUpScreen({Key key}) : super(key: key);
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isloading = false;

//   @override
//   Widget build(BuildContext context) {
//     Widget SignupButton;
//     if (isloading) {
//       SignupButton = Center(
//         child: CircularProgressIndicator(
//           valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFfbad20)),
//         ),
//       );
//     } else {
//       SignupButton = FlatButton(
//           color: Color(0xFFfbad20),
//           height: 50,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: BorderSide(color: Color(0xFFfbad20))),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Create New Account',
//                 style: TextStyle(color: Color(0xff002a66)),
//               )
//             ],
//           ));
//     }
//     // Future<bool> _onBackPressed() {
//     //   return showDialog(
//     //         context: context,
//     //         builder: (context) => new AlertDialog(
//     //           title: new Text('Are you sure?'),
//     //           content: new Text('Do you want to exit the App'),
//     //           actions: <Widget>[
//     //             new GestureDetector(
//     //               onTap: () => Navigator.of(context).pop(false),
//     //               child: Text("NO"),
//     //             ),
//     //             SizedBox(height: 16),
//     //             new GestureDetector(
//     //               onTap: () => Navigator.of(context).pop(true),
//     //               child: Text("YES"),
//     //             ),
//     //             SizedBox(height: 16),
//     //           ],
//     //         ),
//     //       ) ??
//     //       false;
//     // }

//     // return WillPopScope(
//     //     onWillPop: _onBackPressed,
//     //     child:
//     return Scaffold(
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
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment(-1.1, 0),
//                   child: FlatButton(
//                     child: Text(
//                       'Sign Up Later',
//                       style: TextStyle(
//                         color: Color(0xff002a66),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ImageIcon(AssetImage('assets/images/delivery.png'),
//                         size: 50, color: Color(0xff002a66)),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "GoFlexe",
//                       style: GoogleFonts.dmSans(
//                           fontSize: 40,
//                           fontWeight: FontWeight.w900,
//                           color: Color(0xff002a66)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 new TextFormField(
//                   controller: _nameController,
//                   decoration: new InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Color(0xff002a66),
//                       ),
//                     ),
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.grey)),
//                     hintText: 'Enter your Name',
//                     labelText: 'Full Name (Required)',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 new TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,
//                   decoration: new InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Color(0xff002a66),
//                       ),
//                     ),
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.grey)),
//                     hintText: 'Enter your E-mail',
//                     labelText: 'E-mail (Required)',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 new TextFormField(
//                   keyboardType: TextInputType.visiblePassword,
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) => value.isEmpty
//                       ? "Password is invalid"
//                       : value.length < 9
//                           ? "Password must contain at least 8 characters"
//                           : null,
//                   decoration: new InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Color(0xff002a66),
//                       ),
//                     ),
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.grey)),
//                     hintText: 'Enter a Password',
//                     labelText: 'Password (Required)',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SignupButton,
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                           child: Divider(
//                         thickness: 1.5,
//                       )),
//                     ),
//                     Text(
//                       "  or  ",
//                       style: TextStyle(fontStyle: FontStyle.italic),
//                     ),
//                     Expanded(
//                       child: Container(
//                           child: Divider(
//                         thickness: 1.5,
//                       )),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 FlatButton(
//                     height: 50,
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) => Login()));
//                     },
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         side: BorderSide(color: Color(0xff002a66))),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Login',
//                           style: TextStyle(color: Color(0xff002a66)),
//                         )
//                       ],
//                     )),
//                 Spacer(
//                   flex: 3,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       //)
//     );
//   }
// }
