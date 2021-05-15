import 'dart:convert';

import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/data_text_chart.dart';
import 'package:crisis/Widgets/info_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';

class WorldStats extends StatefulWidget {
  @override
  _WorldStatsState createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> {
  var totalData;
  bool loading = true;
  String _timeString;
  List<double> confirmed = [];
  List<double> deceased = [];
  List<double> recovered = [];

  @override
  void initState() {
    super.initState();
    _getTime();
    getStats();
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  getGraphData() async {
    try {
      var dio = Dio();
      String url =
          'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=365';

      BaseOptions options = BaseOptions(
          receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
      dio = Dio(options);
      final response = await dio.get(url);
      print(response.data);
      var temp = response.data;
      var tempCases = temp["cases"];
      var tempDeath = temp["deaths"];
      var tempRecovered = temp["recovered"];

      for (var i = 0; i < tempCases.length; i++) {
        if (i == 0) {
          confirmed.add(
              double.parse(tempCases.values.elementAt(i).toString()) + 0.1);
        }
        confirmed.add(double.parse(tempCases.values.elementAt(i).toString()));
      }

      for (var i = 0; i < tempRecovered.length; i++) {
        if (i == 0) {
          recovered.add(
              double.parse(tempRecovered.values.elementAt(i).toString()) + 0.1);
        }
        recovered
            .add(double.parse(tempRecovered.values.elementAt(i).toString()));
      }
      for (var i = 0; i < tempDeath.length; i++) {
        if (i == 0) {
          deceased.add(
              double.parse(tempDeath.values.elementAt(i).toString()) + 0.1);
        }
        deceased.add(double.parse(tempDeath.values.elementAt(i).toString()));
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        confirmed = null;
        deceased = null;
        recovered = null;
        loading = false;
      });
    }
  }

  getStats() async {
    const url = 'https://corona.lmao.ninja/v3/covid-19/all';
    Dio _dio;
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);

    setState(() {
      totalData = response.data;
    });
    getGraphData();
  }

  @override
  Widget build(BuildContext context) {
    final display = createDisplay();

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2340),
        orientation: Orientation.portrait);
    return Scaffold(
        // backgroundColor: Colors.white,

        body: loading == true
            ? Loading()
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(40),
                    // vertical: ScreenUtil().setWidth(50),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          // height: 1050.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Data Based on World',
                                  style: GoogleFonts.montserrat(
                                    color: Color(0xFF6B747C),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _timeString.toString() ?? "",
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF6B747C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.notifications,
                                      size: 45.w,
                                      color: Color(0xFF6B747C),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.w,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    DataTextChart(
                                      title: "Confirmed",
                                      number: display(int.parse(
                                          totalData["cases"].toString())),
                                      deltaNumber:
                                          '[+${display(int.parse(totalData["todayCases"].toString()))}]',
                                      numberColor: Color(0xFFF83F38),
                                      deltaNumberColor: Color(0xFF9E2726),
                                      titleColor: Color(0xFFF83F38),
                                      data: confirmed,
                                      lineColor: Color(0xFFF83F38),
                                      pointColor: Color(0xFFF83F38),
                                    ),
                                    DataTextChart(
                                      title: "Active",
                                      number: display(int.parse(
                                          totalData["active"].toString())),
                                      deltaNumber: "",
                                      numberColor: Color(0xFF3f51b5),
                                      deltaNumberColor: Color(0xFF0055B1),
                                      titleColor: Color(0xFF3f51b5),
                                      data: null,
                                      lineColor: Color(0xFF3f51b5),
                                      pointColor: Color(0xFF3f51b5),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 10.w,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    DataTextChart(
                                      title: "Recovered",
                                      number: display(int.parse(
                                          totalData["recovered"].toString())),
                                      deltaNumber:
                                          '[+${display(int.parse(totalData["todayRecovered"].toString()))}]',
                                      numberColor: Color(0xFF41A745),
                                      deltaNumberColor: Color(0xFF276A39),
                                      titleColor: Color(0xFF41A745),
                                      data: recovered,
                                      lineColor: Color(0xFF41A745),
                                      pointColor: Color(0xFF41A745),
                                    ),
                                    DataTextChart(
                                      title: "Deceased",
                                      number: display(int.parse(
                                          totalData["deaths"].toString())),
                                      deltaNumber:
                                          '[+${display(int.parse(totalData["todayDeaths"].toString()))}]',
                                      numberColor: Color(0xFF6B747C),
                                      deltaNumberColor: Color(0xFF494E58),
                                      titleColor: Color(0xFF6B747C),
                                      data: deceased,
                                      lineColor: Color(0xFF6B747C),
                                      pointColor: Color(0xFF6B747C),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ExpansionTile(
                      //   title: Text(
                      //     'Most Affected States',
                      //     style: GoogleFonts.montserrat(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      //   children: <Widget>[
                      //     MostAffectedStates(
                      //       totalData: null,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          // left: 8,
                          // right: 8,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                InfoCard(
                                  backgroundColor: Color(0xFFFDE1E1),
                                  title: 'Confirmed Per Million',
                                  description:
                                      '${((double.parse(totalData["casesPerOneMillion"].toString())).toStringAsFixed(0))} out of every 1 million people in have tested positive for the virus.',
                                  number:
                                      '${((double.parse(totalData["casesPerOneMillion"].toString()))).toStringAsFixed(2)}',
                                  numberColor: Color(0xFFF83F38),
                                  titleAndDescriptionColor: Color(0xFFF96B6A),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                InfoCard(
                                  backgroundColor: Color(0xFFF3F3FE),
                                  title: 'Active',
                                  description:
                                      'For every 100 confirmed cases, ${(double.parse(totalData["active"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(0)} are currently infected.',
                                  number:
                                      '${(double.parse(totalData["active"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(2)}%',
                                  numberColor: Color(0xFF3f51b5),
                                  titleAndDescriptionColor: Color(0xFF7E98FB),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: <Widget>[
                                InfoCard(
                                  backgroundColor: Color(0xFFE1F2E8),
                                  title: 'Recovery Rate',
                                  description:
                                      'For every 100 confirmed cases, ${(double.parse(totalData["recovered"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(0)} have recovered from the virus.',
                                  number:
                                      '${(double.parse(totalData["recovered"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(2)}%',
                                  numberColor: Color(0xFF41A745),
                                  titleAndDescriptionColor: Color(0xFF6DC386),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                InfoCard(
                                  backgroundColor: Color(0xFFF6F6F7),
                                  title: 'Mortality Rate',
                                  description:
                                      'For every 100 confirmed cases, ${(double.parse(totalData["deaths"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(0)} have unfortunately passed away from the virus.',
                                  number:
                                      '${(double.parse(totalData["deaths"].toString()) / double.parse(totalData["cases"].toString()) * 100).toStringAsFixed(2)}%',
                                  numberColor: Color(0xFF6F757D),
                                  titleAndDescriptionColor: Color(0xFFBEB2AF),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: <Widget>[
                                InfoCard(
                                  backgroundColor: Color(0xFFFAF7F3),
                                  title: 'Deaths Per Million',
                                  description:
                                      '${((double.parse(totalData["deathsPerOneMillion"].toString())).toStringAsFixed(0))} out of every 1 million people in have died from the virus.',
                                  number:
                                      '${((double.parse(totalData["deathsPerOneMillion"].toString()))).toStringAsFixed(2)}',
                                  numberColor: Color(0xFFB6854D),
                                  titleAndDescriptionColor: Color(0xFFD2B28E),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                InfoCard(
                                  backgroundColor: Color(0xFFE5E3F3),
                                  title: 'Tests Per Million',
                                  description:
                                      'For every 1 million people, ${double.parse(totalData["testsPerOneMillion"].toString()).toStringAsFixed(0)} people were tested.',
                                  number:
                                      '≈ ${double.parse(totalData["testsPerOneMillion"].toString()).toStringAsFixed(0)}',
                                  numberColor: Color(0xFF4655AC),
                                  titleAndDescriptionColor: Color(0xFF7878C2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
