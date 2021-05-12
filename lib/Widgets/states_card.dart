import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StatesCard extends StatelessWidget {
  final String stateName;
  final String confirmed;
  final String deltaConfirmed;
  final String active;
  final String recovered;
  final String deltaRecovered;
  final String deceased;
  final String deltaDeceased;
  var data;

  StatesCard(
      {Key key,
      this.stateName,
      this.confirmed,
      this.deltaConfirmed,
      this.active,
      this.recovered,
      this.deltaRecovered,
      this.deceased,
      this.deltaDeceased,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      height: 420.w,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: 60.w,
                  width: 480.w,
                  child: AutoSizeText(
                    stateName,
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
                  height: stateName.length > 10 ? 20.w : 50.w,
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
            SizedBox(
              width: 10.w,
            ),
            Container(
              // width: 500.w,
              child: Sparkline(
                data: data,
                fallbackHeight: 50.w,
                fallbackWidth: 400.w,
                lineColor: Colors.red,
                pointSize: 5,
                lineWidth: 3,
                sharpCorners: true,
                lineGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red[500],
                    Colors.red[100],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
