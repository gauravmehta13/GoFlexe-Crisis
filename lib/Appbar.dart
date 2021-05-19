import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "./ProgressBar.dart";
import 'package:flutter/foundation.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  MyAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      title: Text(
        title,
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
