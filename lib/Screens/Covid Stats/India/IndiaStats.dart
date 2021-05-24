import 'dart:math';

import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/model/general_data_model.dart';
import 'package:crisis/Widgets/data_text_chart.dart';
import 'package:crisis/Widgets/info_card.dart';
import 'package:crisis/model/utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart' as textElement;

const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

class CovidStats extends StatefulWidget {
  static String pointerValue;
  static DateTime pointerTime;
  static int type = 0;

  @override
  _CovidStatsState createState() => _CovidStatsState();
}

class _CovidStatsState extends State<CovidStats>
    with SingleTickerProviderStateMixin {
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
  TabController _tabController;
  bool infectedSwitchControl = false;
  bool recoveredSwitchControl = false;
  bool deathsSwitchControl = false;
  int tabIndex = 0;
  List<dynamic> list = [];

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics().logEvent(name: 'India_Live_Data', parameters: null);
    getStats();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
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
      list = response.data["cases_time_series"];
      list = list.reversed.toList();
      chartData1 = tempData.casesTimeSeries;
      statewise = tempData.statewise[0];
      totalData1 = response.data;

      testData = totalData1["tested"][totalData1["tested"].length - 2]
          ["totalsamplestested"];
    });
    setState(() {
      confirmedData = _generateConfirmedData();
      activeData = _generateActiveData();
      recoveredData = _generateRecoveredData();
      deceasedData = _generateDeceasedData();
      loading = false;
    });
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
                                      '${((double.parse(statewise.confirmed) / 1392031412) * 1000000).toStringAsFixed(0)} out of every 1 million people in India have tested positive for the virus.',
                                  number:
                                      '${((double.parse(statewise.confirmed) / 1392031412) * 1000000).toStringAsFixed(2)}',
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
                                      'For every 1 million people in India, ${((double.parse(testData) / 1392031412) * 1000000).toStringAsFixed(0)} people were tested.',
                                  number:
                                      '≈ ${(((double.parse(testData) / 1392031412) * 1000000).toStringAsFixed(0))}',
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
                      new Container(
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 30,
                                color: kShadowColor,
                              )
                            ]),
                        child: TabBar(
                          // onTap: (index){
                          //   setState(() {
                          //     tabIndex = index;
                          //     CovidStats.type = index;
                          //   });
                          // },
                          controller: _tabController,
                          tabs: [
                            Tab(
                              child: Text(
                                'Confirmed',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Recovered',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Deceased',
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                          unselectedLabelColor: kTextLightColor,
                          indicatorColor: tabIndex == 0
                              ? kInfectedColor
                              : tabIndex == 1
                                  ? kRecovercolor
                                  : kDeathColor,
                          labelColor: tabIndex == 0
                              ? kInfectedColor
                              : tabIndex == 1
                                  ? kRecovercolor
                                  : kDeathColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3.0,
                          indicatorPadding: EdgeInsets.all(10),
                          isScrollable: false,
                        ),
                      ),

                      Container(
                        height: 400.0,
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Daily',
                                          style: TextStyle(
                                              color:
                                                  infectedSwitchControl == true
                                                      ? kInfectedColor
                                                      : kTextLightColor),
                                        ),
                                        Switch(
                                          onChanged: (bool value) {
                                            setState(() {
                                              infectedSwitchControl =
                                                  !infectedSwitchControl;
                                            });
                                          },
                                          value: infectedSwitchControl,
                                          activeColor: kInfectedColor,
                                          activeTrackColor: Colors.orange[100],
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  // margin: EdgeInsets.only(top : 20),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 20, left: 10, right: 3),
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 30,
                                          color: kShadowColor,
                                        )
                                      ]),
                                  child: infectedSwitchControl
                                      ? createBarChart('dailyconfirmed')
                                      : createChart('totalconfirmed'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Daily',
                                          style: TextStyle(
                                              color:
                                                  recoveredSwitchControl == true
                                                      ? kRecovercolor
                                                      : kTextLightColor),
                                        ),
                                        Switch(
                                          onChanged: (bool value) {
                                            setState(() {
                                              recoveredSwitchControl =
                                                  !recoveredSwitchControl;
                                            });
                                          },
                                          value: recoveredSwitchControl,
                                          activeColor: kRecovercolor,
                                          activeTrackColor: Colors.green[100],
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 20, left: 10, right: 3),
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 30,
                                          color: kShadowColor,
                                        )
                                      ]),
                                  child: recoveredSwitchControl == true
                                      ? createBarChart('dailyrecovered')
                                      : createChart('totalrecovered'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Daily',
                                          style: TextStyle(
                                              color: deathsSwitchControl == true
                                                  ? kDeathColor
                                                  : kTextLightColor),
                                        ),
                                        Switch(
                                          onChanged: (bool value) {
                                            setState(() {
                                              deathsSwitchControl =
                                                  !deathsSwitchControl;
                                            });
                                          },
                                          value: deathsSwitchControl,
                                          activeColor: kDeathColor,
                                          activeTrackColor: Colors.red[100],
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 20, left: 10, right: 3),
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 30,
                                          color: kShadowColor,
                                        )
                                      ]),
                                  child: deathsSwitchControl == true
                                      ? createBarChart('dailydeceased')
                                      : createChart('totaldeceased'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  charts.Series<TimeSeriesNums, DateTime> createSeries(
      String id, List<TimeSeriesNums> list, String type) {
    return charts.Series<TimeSeriesNums, DateTime>(
        id: id,
        colorFn: (_, index) =>
            type == "totalconfirmed" || type == "dailyconfirmed"
                ? charts.MaterialPalette.deepOrange.shadeDefault
                : type == "totalrecovered" || type == "dailyrecovered"
                    ? charts.MaterialPalette.green.shadeDefault
                    : charts.MaterialPalette.red.shadeDefault,

        // measureFn also there
        domainFn: (TimeSeriesNums sales, _) => sales.time,
        measureFn: (TimeSeriesNums sales, _) => sales.nums,
        data: list);
  }

  Widget createChart(String type) {
    List<charts.Series<TimeSeriesNums, DateTime>> seriesList = [];
    List<TimeSeriesNums> seriesData = [];
    for (int i = 0; i < min(list.length, 120); i++) {
      seriesData.add(TimeSeriesNums(
          Utils().reformatDate(list[i]['dateymd']), int.parse(list[i][type])));
    }
    seriesList.add(createSeries(type, seriesData, type));
    return charts.TimeSeriesChart(
      seriesList,
      animate: false,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
          tickFormatterSpec:
              new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                  new NumberFormat.compact())),
      domainAxis: new charts.DateTimeAxisSpec(
          tickProviderSpec: new charts.DayTickProviderSpec(increments: [
            24
          ] // that is 24*5 = 120 days means 5 ticks are there
              ),
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
              day: new charts.TimeFormatterSpec(
                  format: 'dd MMM', transitionFormat: 'dd MMM'))),
      behaviors: [
        charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer()),
        //   charts.SlidingViewport(),
        //   charts.PanAndZoomBehavior(),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            CovidStats.pointerValue = model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)
                .toString();
            CovidStats.pointerTime = model.selectedDatum[0].datum.time;
          }
        })
      ],
      defaultRenderer: new charts.LineRendererConfig(),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  Widget createBarChart(String type) {
    List<charts.Series<TimeSeriesNums, DateTime>> seriesList = [];
    List<TimeSeriesNums> seriesData = [];
    for (int i = 0; i < min(list.length, 120); i++) {
      seriesData.add(TimeSeriesNums(
          Utils().reformatDate(list[i]['dateymd']), int.parse(list[i][type])));
    }
    seriesList.add(createSeries(type, seriesData, type));
    return new charts.TimeSeriesChart(
      seriesList,
      animate: false,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
          tickFormatterSpec:
              new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                  new NumberFormat.compact())),
      domainAxis: new charts.DateTimeAxisSpec(
          tickProviderSpec: new charts.DayTickProviderSpec(increments: [
            24
          ] // that is 24*5 = 120 days means 5 ticks are there
              ),
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
              day: new charts.TimeFormatterSpec(
                  format: 'dd MMM', transitionFormat: 'dd MMM'))),
      behaviors: [
        charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer()),
        //   charts.SlidingViewport(),
        //   charts.PanAndZoomBehavior(),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            // model.selectedDatum.forEach((charts.SeriesDatum datumPair) {
            //     print('${datumPair.datum.time}: ${datumPair.datum.nums}');
            // });
            CovidStats.pointerValue = model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)
                .toString();
            CovidStats.pointerTime = model.selectedDatum[0].datum.time;
          }
        })
      ],
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TimeSeriesNums {
  final DateTime time;
  final int nums;
  TimeSeriesNums(this.time, this.nums);
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    // canvas.drawRect(
    //   Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
    //   fill: charts.Color.white
    // );
    // print(CovidStats.type);
    var textStyle = style.TextStyle();
    if (CovidStats.type == 0)
      textStyle.color = charts.Color.fromHex(code: '#FF8748');
    else if (CovidStats.type == 1)
      textStyle.color = charts.Color.fromHex(code: '#36C12C');
    else
      textStyle.color = charts.Color.fromHex(code: '#FF4848');

    textStyle.fontSize = 13;
    canvas.drawText(
        textElement.TextElement(
            'Patients: ' +
                NumberFormat.compact()
                    .format(int.parse(CovidStats.pointerValue)),
            style: textStyle),
        (5).round(),
        (-35).round());

    canvas.drawText(
        textElement.TextElement(
            'Date: ' +
                DateFormat.yMMMMd('en_US').format(CovidStats.pointerTime),
            style: textStyle),
        (5).round(),
        (-50).round());
  }
}
