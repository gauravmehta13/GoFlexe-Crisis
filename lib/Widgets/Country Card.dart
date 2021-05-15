import 'package:crisis/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CountryCard extends StatelessWidget {
  final String stateName;
  final String confirmed;
  final String deltaConfirmed;
  final String active;
  final String recovered;
  final String deltaRecovered;
  final String deceased;
  final String deltaDeceased;
  final String image;

  CountryCard(
      {Key key,
      this.stateName,
      this.confirmed,
      this.deltaConfirmed,
      this.active,
      this.recovered,
      this.deltaRecovered,
      this.deceased,
      this.deltaDeceased,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400], width: 0.5)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              image,
              width: 100,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
            box10,
            Container(
              child: AutoSizeText(
                stateName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF325399),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Confirmed: ",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFF83F38), fontSize: 13,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$confirmed",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFF83F38),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Active: ",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF0278F9),
                    fontSize: 13,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$active",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF0278F9),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Recovered: ",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF41A745),
                    fontSize: 13,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$recovered",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF41A745),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Deceased: ",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6B747C),
                    fontSize: 13,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$deceased",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6B747C),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
