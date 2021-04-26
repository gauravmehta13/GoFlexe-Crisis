// import 'package:flutter/material.dart';
// import 'package:packers/Unused%20Pages/Commercial%20Move.dart';
// import 'package:packers/Order/Residential%20Move.dart';

// class PackersTabBar extends StatefulWidget {
//   @override
//   _PackersTabBarState createState() => _PackersTabBarState();
// }

// class _PackersTabBarState extends State<PackersTabBar>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 150,
//             child: Stack(
//               children: [
//                 Container(height: 100, color: Color(0xFF3f51b5)),
//                 Positioned(
//                   top: 80,
//                   child: Container(
//                     height: 45,
//                     width: MediaQuery.of(context).size.width - 50,
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(
//                         25.0,
//                       ),
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       indicator: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                             25.0,
//                           ),
//                           color: Color(0xFF3f51b5)),
//                       labelColor: Colors.white,
//                       unselectedLabelColor: Colors.black,
//                       tabs: [
//                         // first tab [you can add an icon using the icon property]
//                         Tab(
//                           text: 'Residential',
//                         ),

//                         // second tab [you can add an icon using the icon property]
//                         Tab(
//                           text: 'Commercial',
//                         ),
//                         Tab(
//                           text: 'Industrial',
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),

//           // tab bar view here
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 ResidentialMove(),
//                 CommercialMove(),
//                 Container(
//                   child: Center(
//                     child: Text("Coming Soon"),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
