import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "./ProgressBar.dart";
import 'package:flutter/foundation.dart';

class MyAppBar extends StatelessWidget {
  final int curStep;
  MyAppBar({@required this.curStep});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        'GoFlexe',
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 10.0),
        child: StepProgressView(
            width: MediaQuery.of(context).size.width,
            curStep: curStep,
            color: Color(0xFFf9a825),
            titles: ["", "", "", "", "", ""]),
      ),
    );
  }
}
