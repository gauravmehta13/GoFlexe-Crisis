import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../Constants.dart';
import 'package:dart_twitter_api/twitter_api.dart';

import '../../Fade Route.dart';
import 'Search results.dart';

final twitterApi = TwitterApi(
  client: TwitterClient(
    consumerKey: 'CysHavmnRH44KUT8bTj8obvpb',
    consumerSecret: 'd3fvW10kV5WyjbiUgGVFYzcpuM1i8cYJPxuFhs5dky05M2p2Sf',
    token: "848460975221198849-zfXLNozb9YcngE62K3xq2hgIlLK622r",
    secret: "eE4RHDPBDFgWAONyxqv13fYBkstK8aMilsBy3ywVk9SuC",
  ),
);

class TwitterScreen extends StatefulWidget {
  @override
  _TwitterScreenState createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {
  ScrollController _scrollController = ScrollController();
  String city = "";
  bool beds = true;
  bool ventilator = true;
  bool icu = true;
  bool oxygen = true;
  bool tests = false;
  bool fabiflu = false;
  bool remdesivir = false;
  bool favipiravir = false;
  bool tocilizumab = false;
  bool plasma = false;
  bool food = false;
  bool ambulance = false;

  void initState() {
    super.initState();
    FirebaseAnalytics().logEvent(name: 'Twitter_Resources', parameters: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Link(
              target: LinkTarget.blank,
              uri: Uri.parse(
                  "https://twitter.com/search?q=verified+$city+(${beds == true ? "bed+OR+beds+OR" : ""}+${icu == true ? "icu+OR" : ""}+${oxygen == true ? "oxygen+OR" : ""}+${ventilator == true ? "ventilator+OR+ventilators+OR" : ""}+${tests == true ? "test+OR+tests+OR+testing+OR" : ""}+${fabiflu == true ? "fabiflu+OR" : ""}+${favipiravir == true ? "favipiravir+OR" : ""}+${remdesivir == true ? "remdesivir+OR" : ""}+${tocilizumab == true ? "tocilizumab+OR" : ""}+${plasma == true ? "plasma+OR" : ""}+${food == true ? "food+OR+tiffin+OR" : ""}+${ambulance == true ? "ambulance" : ""})+%20-not%20verified%20-unverified%20-needed%20-need%20-needs%20-required%20-require%20-requires%20-requirement%20-requirements&src=typeahead_click&f=live"),
              builder: (context, followLink) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFf9a825), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: city.isEmpty
                        ? null
                        : () {
                            String query =
                                "verified+$city+(${beds == true ? "bed+OR+beds+OR" : ""}+${icu == true ? "icu+OR" : ""}+${oxygen == true ? "oxygen+OR" : ""}+${ventilator == true ? "ventilator+OR+ventilators+OR" : ""}+${tests == true ? "test+OR+tests+OR+testing+OR" : ""}+${fabiflu == true ? "fabiflu+OR" : ""}+${favipiravir == true ? "favipiravir+OR" : ""}+${remdesivir == true ? "remdesivir+OR" : ""}+${tocilizumab == true ? "tocilizumab+OR" : ""}+${plasma == true ? "plasma+OR" : ""}+${food == true ? "food+OR+tiffin+OR" : ""}+${ambulance == true ? "ambulance" : ""})+%20-not%20verified%20-unverified%20-needed%20-need%20-needs%20-required%20-require%20-requires%20-requirement%20-requirements";
                            Navigator.push(
                              context,
                              FadeRoute(
                                  page: TwitterSearchResults(
                                query: query,
                                area: city,
                              )),
                            );
                            //followLink();
                          },
                    child: Text(
                      "Find On Twitter",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              box20,
              Image.asset(
                "assets/twitter.png",
                height: 100,
              ),
              box20,
              Text(
                "Twitter Search for Covid",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              box10,
              Text(
                "Find Latest Resources in realtime on twitter",
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
              box30,
              box30,
              Padding(
                padding: const EdgeInsets.all(10),
                child: Autocomplete<String>(
                  displayStringForOption: (option) => option,
                  fieldViewBuilder: (context, textEditingController, focusNode,
                          onFieldSubmitted) =>
                      TextField(
                    controller: textEditingController,
                    onTap: () {
                      textEditingController.clear();
                    },
                    focusNode: focusNode,
                    scrollPadding: const EdgeInsets.only(bottom: 150.0),
                    // onEditingComplete: onFieldSubmitted,
                    decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "Search City"),
                  ),
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return cities;
                    }
                    return cities.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    final FocusScopeNode currentScope = FocusScope.of(context);
                    if (!currentScope.hasPrimaryFocus &&
                        currentScope.hasFocus) {
                      FocusManager.instance.primaryFocus.unfocus();
                    }
                    print(selection);
                    setState(() {
                      city = selection;
                    });
                    _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: beds,
                                onChanged: (value) {
                                  setState(() {
                                    beds = value;
                                  });
                                },
                              ),
                              Text(
                                "Beds",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: ventilator,
                                onChanged: (value) {
                                  setState(() {
                                    ventilator = value;
                                  });
                                },
                              ),
                              Text(
                                "Ventilator",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: fabiflu,
                                onChanged: (value) {
                                  setState(() {
                                    fabiflu = value;
                                  });
                                },
                              ),
                              Text(
                                "Fabiflu",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: remdesivir,
                                onChanged: (value) {
                                  setState(() {
                                    remdesivir = value;
                                  });
                                },
                              ),
                              Text(
                                "Remdesivir",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: icu,
                                onChanged: (value) {
                                  setState(() {
                                    icu = value;
                                  });
                                },
                              ),
                              Text(
                                "ICU",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: plasma,
                                onChanged: (value) {
                                  setState(() {
                                    plasma = value;
                                  });
                                },
                              ),
                              Text(
                                "Plasma",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: favipiravir,
                                onChanged: (value) {
                                  setState(() {
                                    favipiravir = value;
                                  });
                                },
                              ),
                              Text(
                                "Favipiravir",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: food,
                                onChanged: (value) {
                                  setState(() {
                                    food = value;
                                  });
                                },
                              ),
                              Text(
                                "Food",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: oxygen,
                                onChanged: (value) {
                                  setState(() {
                                    oxygen = value;
                                  });
                                },
                              ),
                              Text(
                                "Oxygen",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: ambulance,
                                onChanged: (value) {
                                  setState(() {
                                    ambulance = value;
                                  });
                                },
                              ),
                              Text(
                                "Ambulance",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: tocilizumab,
                                onChanged: (value) {
                                  setState(() {
                                    tocilizumab = value;
                                  });
                                },
                              ),
                              Text(
                                "Tocilizumab",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: tests,
                                onChanged: (value) {
                                  setState(() {
                                    tests = value;
                                  });
                                },
                              ),
                              Text(
                                "Tests",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
