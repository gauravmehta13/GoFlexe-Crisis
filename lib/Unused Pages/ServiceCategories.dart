// import 'package:flutter/material.dart';
// import 'package:packers/Unused%20Pages/Maps.dart';
// import 'package:packers/Unused%20Pages/Commercial%20Move.dart';
// import 'package:packers/Order/Residential%20Move.dart';

// import '../Drawer.dart';

// class ServiceCategories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     bool selected = false;
//     const curveHeight = 50.0;
//     return Scaffold(
//         drawer: MyDrawer(),
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Text("Packers & Movers"),
//             ],
//           ),
//           centerTitle: true,
//           shape: const MyShapeBorder(curveHeight),
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Spacer(),
//               Text(
//                 "Which Service\ndo you\nneed?",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
//               ),
//               Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ResidentialMove()
//                             //ResidentialMove()
//                             ),
//                       );
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 2.5,
//                       height: MediaQuery.of(context).size.height / 4.5,
//                       child: Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             side: new BorderSide(
//                                 color: selected ? Colors.black : Colors.black12,
//                                 width: 1.0),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             children: [
//                               Spacer(),
//                               ImageIcon(
//                                 AssetImage('assets/ApartMove.png'),
//                                 size: 50,
//                               ),
//                               Spacer(),
//                               Text("Residential\nMove",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600),
//                                   textAlign: TextAlign.center),
//                               Spacer(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CommercialMove()),
//                       );
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 2.5,
//                       height: MediaQuery.of(context).size.height / 4.5,
//                       child: Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             side: new BorderSide(
//                                 color: selected ? Colors.black : Colors.black12,
//                                 width: 1.0),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             children: [
//                               Spacer(),
//                               ImageIcon(
//                                 AssetImage('assets/CommercialMove.png'),
//                                 size: 50,
//                               ),
//                               Spacer(),
//                               Text(" Commercial\nMove",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   textAlign: TextAlign.center),
//                               Spacer(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: Image.asset(
//                   "assets/pack.jpg",
//                   height: MediaQuery.of(context).size.height / 4,
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }

// class MyShapeBorder extends ContinuousRectangleBorder {
//   const MyShapeBorder(this.curveHeight);
//   final double curveHeight;

//   @override
//   Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
//     ..lineTo(0, rect.size.height)
//     ..quadraticBezierTo(
//       rect.size.width / 2,
//       rect.size.height + curveHeight * 1,
//       rect.size.width,
//       rect.size.height,
//     )
//     ..lineTo(rect.size.width, 0)
//     ..close();
// }
