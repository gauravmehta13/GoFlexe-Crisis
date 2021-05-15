import 'package:crisis/Constants.dart';
import 'package:crisis/Screens/Covid%20Stats/World/CountryDetails.dart';
import 'package:crisis/Widgets/Country%20Card.dart';
import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/model/regex.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Fade Route.dart';

class CountriesStats extends StatefulWidget {
  final data;
  CountriesStats({this.data});
  @override
  _CountriesStatsState createState() => _CountriesStatsState();
}

class _CountriesStatsState extends State<CountriesStats> {
  @override
  void didChangeDependencies() {
    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  bool loading = true;
  List tempData;
  List totalData;
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
    const url = 'https://corona.lmao.ninja/v3/covid-19/countries';

    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
    final response = await _dio.get(url);
    print(response.data);
    var temp = response.data;

    setState(() {
      totalData = temp;
      tempData = totalData;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading == true
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    box10,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: new TextFormField(
                          textInputAction: TextInputAction.go,
                          onChanged: (string) {
                            setState(() {
                              tempData = (totalData)
                                  .where((u) => (u["country"]
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                  .toList();
                            });
                          },
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF2821B5),
                              ),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Search..",
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.1,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tempData.length,
                      itemBuilder: (context, index) {
                        // print(tempData[index]["country"]);
                        if (tempData.length == 0) {
                          return SizedBox(height: 0.0);
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(40),
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        child: CountryDetails(
                                          totalData: tempData[index],
                                        ),
                                      );
                                    });
                              },
                              child: CountryCard(
                                stateName: tempData[index]["country"],
                                confirmed: addSeperator(
                                    tempData[index]["cases"].toString()),
                                deltaConfirmed: addSeperator(
                                    tempData[index]["todayCases"].toString()),
                                active: addSeperator(
                                    tempData[index]["active"].toString()),
                                recovered: addSeperator(
                                    tempData[index]["recovered"].toString()),
                                deltaRecovered: addSeperator(tempData[index]
                                        ["todayRecovered"]
                                    .toString()),
                                deceased: addSeperator(
                                    tempData[index]["deaths"].toString()),
                                deltaDeceased: addSeperator(
                                    tempData[index]["todayDeaths"].toString()),
                                image: tempData[index]["countryInfo"]["flag"],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
