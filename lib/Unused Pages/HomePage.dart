// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:packers/Drawer.dart';
// import 'package:packers/Unused%20Pages/ServiceCategories.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import '../Order/Residential Move.dart';
// import 'TabBar.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         elevation: 0,
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: Icon(Icons.search),
//               tooltip: 'Search',
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 60,
//               color: Color(0xFF3f51b5),
//             ),
//             Column(
//               children: [
//                 Container(
//                   color: Colors.transparent,
//                   height: 130,
//                   padding: EdgeInsets.all(10),
//                   child: Card(
//                     shadowColor: Colors.black,
//                     elevation: 5,
//                     color: Colors.white,
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       width: MediaQuery.of(context).size.width - 30,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {},
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CircleAvatar(
//                                     backgroundColor: Colors.lightBlue,
//                                     child: Image.asset("assets/truck.png")),
//                                 Text(
//                                   "Trucks",
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {},
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CircleAvatar(
//                                     backgroundColor: Colors.lightBlue,
//                                     child: Image.asset("assets/warehouse.png")),
//                                 Text(
//                                   "Warehouse",
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ResidentialMove()));
//                             },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Colors.lightBlue,
//                                   backgroundImage:
//                                       AssetImage("assets/packers.png"),
//                                 ),
//                                 Text(
//                                   "Packers &\nMovers",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.transparent,
//                   height: 150,
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(10),
//                   child: Card(
//                     shadowColor: Colors.black,
//                     color: Colors.white,
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/ApartMove.png'),
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "Residential\nmove",
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(),
//                               Row(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/CommercialMove.png'),
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "Commercial\nmove",
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           RotatedBox(quarterTurns: 1, child: Divider()),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/ApartMove.png'),
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "Residential\nmove",
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(),
//                               Row(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/CommercialMove.png'),
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "Commercial\nmove",
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           RotatedBox(quarterTurns: 1, child: Divider()),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               ResidentialMove()));
//                                 },
//                                 child: Row(
//                                   children: [
//                                     ImageIcon(
//                                       AssetImage('assets/ApartMove.png'),
//                                       size: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Residential\nmove",
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w600),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               PackersTabBar()));
//                                 },
//                                 child: Row(
//                                   children: [
//                                     ImageIcon(
//                                       AssetImage('assets/CommercialMove.png'),
//                                       size: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Commercial\nmove",
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w600),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 100,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 0.8,
//                     initialPage: 0,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 8),
//                     autoPlayAnimationDuration: Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     scrollDirection: Axis.horizontal,
//                   ),
//                   items: [1, 2, 3, 4, 5].map((i) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Card(
//                           child: Container(
//                               padding: EdgeInsets.all(10),
//                               width: MediaQuery.of(context).size.width,
//                               decoration:
//                                   BoxDecoration(color: Colors.lightBlue[50]),
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   'New Offer $i',
//                                   style: TextStyle(fontSize: 16.0),
//                                 ),
//                               )),
//                         );
//                       },
//                     );
//                   }).toList(),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
