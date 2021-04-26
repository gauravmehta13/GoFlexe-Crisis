// import 'package:flutter/material.dart';

// class AddButton extends StatelessWidget {
//   @override
//   bool services = false;
//   Widget build(BuildContext context) {
//     return Container(
//       padding: new EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTap: () {},
//         child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//               side: BorderSide(
//                 color: Color(0xFF3f51b5),
//                 width: 1,
//               ),
//             ),
//             child: services == false
//                 ? (Container(
//                     padding: EdgeInsets.all(5),
//                     child: new Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         new Text("ADD",
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w600)),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(
//                           Icons.add,
//                           color: Color(0xFF3f51b5),
//                         ),
//                       ],
//                     ),
//                   ))
//                 : Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Color(0xFF3f51b5),
//                     ),
//                     padding: EdgeInsets.all(5),
//                     child: new Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         new Text("DONE",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white)),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(
//                           Icons.check,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   )),
//       ),
//     );
//   }
// }
