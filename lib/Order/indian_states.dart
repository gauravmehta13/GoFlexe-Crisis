import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/states_card.dart';
import 'package:crisis/model/general_data_model.dart';
import 'package:crisis/model/regex.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';

class IndianStates extends StatefulWidget {
  final data;
  IndianStates({this.data});
  @override
  _IndianStatesState createState() => _IndianStatesState();
}

class _IndianStatesState extends State<IndianStates>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  bool loading = true;
  var totalData1;
  var statesLength;
  var stateDailyDataLength;
  var stateDailyData;
  Dio _dio;

  @override
  void initState() {
    super.initState();
    getStats();
  }

  getStats() async {
    const url = 'https://api.covid19india.org/data.json';

    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);
    print("1");
    var tempData = Covid19.fromJson(response.data);

    setState(() {
      statesLength = tempData.statewise;
      totalData1 = response.data;
    });
    fetchStatesDailyData();
  }

  fetchStatesDailyData() async {
    const url = 'https://api.covid19india.org/states_daily.json';

    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);
    var tempTestData = response.data;
    setState(() {
      stateDailyData = tempTestData;
      stateDailyDataLength = tempTestData['states_daily'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<double> _generateConfirmedData(int index) {
      List<double> result = <double>[];
      for (int i = stateDailyDataLength.length - 120;
          i < stateDailyDataLength.length;
          i++) {
        result.add(
          (double.parse(stateDailyData['states_daily'][i]
              [totalData1['statewise'][index]['statecode'].toLowerCase()])),
        );
      }
      return result;
    }

    return Scaffold(
        body: loading == true
            ? Loading()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: statesLength.length - 1,
                itemBuilder: (context, index) {
                  print(totalData1['statewise'][index + 1]['state']);
                  if (totalData1['statewise'][index + 1]['state'] ==
                      "State Unassigned") {
                    return SizedBox(height: 0.0);
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(40),
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30),
                      ),
                      child: StatesCard(
                        stateName: totalData1['statewise'][index + 1]['state'],
                        confirmed: addSeperator(
                            totalData1['statewise'][index + 1]['confirmed']),
                        deltaConfirmed: addSeperator(totalData1['statewise']
                            [index + 1]['deltaconfirmed']),
                        active: addSeperator(
                            totalData1['statewise'][index + 1]['active']),
                        recovered: addSeperator(
                            totalData1['statewise'][index + 1]['recovered']),
                        deltaRecovered: addSeperator(totalData1['statewise']
                            [index + 1]['deltarecovered']),
                        decreased: addSeperator(
                            totalData1['statewise'][index + 1]['deaths']),
                        deltaDecreased: addSeperator(
                            totalData1['statewise'][index + 1]['deltadeaths']),
                        data: _generateConfirmedData(index + 1),
                      ),
                    );
                  }
                },
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
