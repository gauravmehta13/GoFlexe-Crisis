import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/model/general_data_model.dart';
import 'package:crisis/Widgets/data_text_chart.dart';
import 'package:crisis/Widgets/info_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';

class CovidStats extends StatefulWidget {
  @override
  _CovidStatsState createState() => _CovidStatsState();
}

class _CovidStatsState extends State<CovidStats> {
  @override
  void didChangeDependencies() {
    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  var allData;
  var statewise;
  var totalData1;
  var chartData1;
  var testData;
  Dio _dio;
  bool loading = true;
  var confirmedData;
  var activeData;
  var recoveredData;
  var deceasedData;

  @override
  void initState() {
    super.initState();
    getStats();
  }

  fetchTestData() async {
    const url = 'https://api.rootnet.in/covid19-in/stats/testing/latest';

    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);
    var tempTestData = response.data;
    setState(() {
      testData = tempTestData;
      confirmedData = _generateConfirmedData();
      activeData = _generateActiveData();
      recoveredData = _generateRecoveredData();
      deceasedData = _generateDeceasedData();
      loading = false;
    });
  }

  List<double> _generateConfirmedData() {
    List<double> result = <double>[];
    for (int i = chartData1.length - 20; i < chartData1.length; i++) {
      result.add(
        (double.parse(totalData1['cases_time_series'][i]['dailyconfirmed'])),
      );
    }
    return result;
  }

  List<double> _generateActiveData() {
    List<double> result = <double>[];
    for (int i = chartData1.length - 20; i < chartData1.length; i++) {
      result.add((double.parse(
              totalData1['cases_time_series'][i]['dailyconfirmed'])) -
          (double.parse(totalData1['cases_time_series'][i]['dailyrecovered'])) -
          (double.parse(totalData1['cases_time_series'][i]['dailydeceased'])));
    }
    return result;
  }

  List<double> _generateRecoveredData() {
    List<double> result = <double>[];
    for (int i = chartData1.length - 20; i < chartData1.length; i++) {
      result.add(
          double.parse(totalData1['cases_time_series'][i]['dailyrecovered']));
    }
    return result;
  }

  List<double> _generateDeceasedData() {
    List<double> result = <double>[];
    for (int i = chartData1.length - 20; i < chartData1.length; i++) {
      result.add(
          double.parse(totalData1['cases_time_series'][i]['dailydeceased']));
    }
    return result;
  }

  getStats() async {
    const url = 'https://api.covid19india.org/data.json';
    Dio _dio;
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);

    var tempData = Covid19.fromJson(response.data);

    setState(() {
      allData = tempData;
      chartData1 = tempData.casesTimeSeries;
      statewise = tempData.statewise[0];
      totalData1 = response.data;
    });
    fetchTestData();
  }

  @override
  Widget build(BuildContext context) {
    final display = createDisplay();
    // print(totalData1['cases_time_series'][chartData1.length - 1]
    //     ['totalconfirmed']);

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
                                  'Data Based on India',
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
                                      statewise.lastupdatedtime,
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
                                      number: display(
                                          int.parse(statewise.confirmed)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltaconfirmed))}]',
                                      numberColor: Color(0xFFF83F38),
                                      deltaNumberColor: Color(0xFF9E2726),
                                      titleColor: Color(0xFFF83F38),
                                      data: confirmedData,
                                      lineColor: Color(0xFFF83F38),
                                      pointColor: Color(0xFFF83F38),
                                    ),
                                    DataTextChart(
                                      title: "Active",
                                      number:
                                          display(int.parse(statewise.active)),
                                      deltaNumber: "",
                                      numberColor: Color(0xFF3f51b5),
                                      deltaNumberColor: Color(0xFF0055B1),
                                      titleColor: Color(0xFF3f51b5),
                                      data: activeData,
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
                                      number: display(
                                          int.parse(statewise.recovered)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltarecovered))}]',
                                      numberColor: Color(0xFF41A745),
                                      deltaNumberColor: Color(0xFF276A39),
                                      titleColor: Color(0xFF41A745),
                                      data: recoveredData,
                                      lineColor: Color(0xFF41A745),
                                      pointColor: Color(0xFF41A745),
                                    ),
                                    DataTextChart(
                                      title: "Deceased",
                                      number:
                                          display(int.parse(statewise.deaths)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltadeaths))}]',
                                      numberColor: Color(0xFF6B747C),
                                      deltaNumberColor: Color(0xFF494E58),
                                      titleColor: Color(0xFF6B747C),
                                      data: deceasedData,
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
                      //       totalData: totalData1,
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
                                      '${((double.parse(statewise.confirmed) / 135260000) * 1000000).toStringAsFixed(0)} out of every 1 million people in India have tested positive for the virus.',
                                  number:
                                      '${((double.parse(statewise.confirmed) / 135260000) * 1000000).toStringAsFixed(2)}',
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
                                      'For every 100 confirmed cases, ${(double.parse(statewise.active) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} are currently infected.',
                                  number:
                                      '${(double.parse(statewise.active) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
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
                                      'For every 100 confirmed cases, ${(double.parse(statewise.recovered) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} have recovered from the virus.',
                                  number:
                                      '${(double.parse(statewise.recovered) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
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
                                      'For every 100 confirmed cases, ${(double.parse(statewise.deaths) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} have unfortunately passed away from the virus.',
                                  number:
                                      '${(double.parse(statewise.deaths) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
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
                                  title: 'Avg. Growth Rate',
                                  description:
                                      'In the last one week, the number of new infections has grown by an average of ${((((double.parse(totalData1['cases_time_series'][chartData1.length - 1]['totalconfirmed']) - double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) / double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) * 100) / 7).toStringAsFixed(0)}% every day.',
                                  number:
                                      '${((((double.parse(totalData1['cases_time_series'][chartData1.length - 1]['totalconfirmed']) - double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) / double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) * 100) / 7).toStringAsFixed(2)}%',
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
                                      'For every 1 million people in India, ${(((testData['data']['totalSamplesTested']) / 135260000) * 1000000).toStringAsFixed(0)} people were tested.',
                                  number:
                                      '≈ ${(((testData['data']['totalSamplesTested']) / 135260000) * 1000000).toStringAsFixed(0)}',
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

  @override
  bool get wantKeepAlive => true;
}
