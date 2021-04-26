// import 'package:flutter/material.dart';
// import 'package:flutter_dropdown/flutter_dropdown.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:packers/Order/Address.dart';
// import 'package:packers/model/app_state.dart';
// import 'package:packers/redux/actions.dart';

// import '../data/CommercialData.dart';

// class CommercialMove extends StatefulWidget {
//   @override
//   _CommercialMoveState createState() => _CommercialMoveState();
// }

// class _CommercialMoveState extends State<CommercialMove> {
//   bool _vehicleValue = false;
//   bool _carValue = false;
//   bool _bikeValue = false;
//   List<User> users;
//   User selectedUser;
//   int selectedRadio;
//   int selectedRadioTile;
//   @override
//   void initState() {
//     super.initState();
//     selectedRadio = 0;
//     selectedRadioTile = 0;
//     users = User.getUsers();
//   }

//   setSelectedRadio(int val) {
//     setState(() {
//       selectedRadio = val;
//     });
//   }

//   setSelectedRadioTile(int val) {
//     setState(() {
//       selectedRadioTile = val;
//     });
//   }

//   setSelectedUser(User user) {
//     setState(() {
//       selectedUser = user;
//     });
//   }

//   List<Widget> createRadioListUsers() {
//     List<Widget> widgets = [];
//     for (User user in users) {
//       widgets.add(Column(children: [
//         RadioListTile(
//           dense: true,
//           value: user,
//           groupValue: selectedUser,
//           title: Text(user.firstName),
//           onChanged: (currentUser) {
//             print("Current User ${currentUser.firstName}");
//             setSelectedUser(currentUser);
//           },
//           selected: selectedUser == user,
//           activeColor: Color(0xFF3f51b5),
//         ),
//         Divider(),
//       ]));
//     }
//     return widgets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//           padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
//           child: SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Color(0xFFf9a825), // background
//                 onPrimary: Colors.white, // foreground
//               ),
//               // onPressed: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(builder: (context) => Address()),
//               //   );
//               // },
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           )),
//       body: SingleChildScrollView(
//         child: Container(
//             padding: EdgeInsets.all(20),
//             child: StoreConnector<AppState, AppState>(
//                 converter: (store) => store.state,
//                 builder: (context, state) {
//                   return Column(
//                     children: [
//                       Center(
//                         child: Text(
//                           "What do you want to shift?",
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                         child: Text(
//                           "(The estimated price will be calculted using this scale only.)",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 13, color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Divider(),
//                       Column(
//                         children: createRadioListUsers(),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       CheckboxListTile(
//                         title: const Text('Vehicle Transport (Optional)'),
//                         subtitle:
//                             const Text('Planning to move your vehicles too?'),
//                         autofocus: false,
//                         activeColor: Color(0xFF3f51b5),
//                         checkColor: Colors.white,
//                         selected: state.vehicleTransport,
//                         value: state.vehicleTransport,
//                         onChanged: (bool value) {
//                           StoreProvider.of<AppState>(context)
//                               .dispatch(VehicleTransport(value));
//                         },
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       state.vehicleTransport == true
//                           ? Row(
//                               children: [
//                                 Spacer(),
//                                 Checkbox(
//                                     activeColor: Color(0xFF3f51b5),
//                                     value: state.car,
//                                     onChanged: (e) {
//                                       StoreProvider.of<AppState>(context)
//                                           .dispatch(Car(e));
//                                     }),
//                                 Text("Car"),
//                                 Spacer(),
//                                 Checkbox(
//                                     activeColor: Color(0xFF3f51b5),
//                                     value: state.bike,
//                                     onChanged: (e) {
//                                       StoreProvider.of<AppState>(context)
//                                           .dispatch(Bike(e));
//                                     }),
//                                 Text("Bike"),
//                                 Spacer(),
//                               ],
//                             )
//                           : Container(),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       state.car == true && state.vehicleTransport == true
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 DropDown(
//                                   items: ["Hatchback", "Sedan", "SUV"],
//                                   hint: Text("Select Car Type"),
//                                   onChanged: (e) {
//                                     StoreProvider.of<AppState>(context)
//                                         .dispatch(CarType(e));
//                                   },
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                       state.bike == true && state.vehicleTransport == true
//                           ? Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 60),
//                               child: TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: new InputDecoration(
//                                     contentPadding: EdgeInsets.all(15),
//                                     labelText: 'No. Of Bikes',
//                                     labelStyle: TextStyle(color: Colors.grey)),
//                                 onChanged: (e) {
//                                   StoreProvider.of<AppState>(context)
//                                       .dispatch(NoOfBikes(e));
//                                 },
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   );
//                 })),
//       ),
//     );
//   }
// }
