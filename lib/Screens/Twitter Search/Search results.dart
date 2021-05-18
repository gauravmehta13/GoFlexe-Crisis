import 'dart:convert';

import 'package:crisis/Widgets/Loading.dart';
import 'package:crisis/Widgets/No%20Results%20Found.dart';
import 'package:dart_twitter_api/api/tweets/data/tweet.dart';
import 'package:dart_twitter_api/api/tweets/data/tweet_search.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../Constants.dart';
import 'Twitter Search.dart';

class TwitterSearchResults extends StatefulWidget {
  final query;
  final area;
  TwitterSearchResults({this.query, this.area});
  @override
  _TwitterSearchResultsState createState() => _TwitterSearchResultsState();
}

class _TwitterSearchResultsState extends State<TwitterSearchResults> {
  List<Tweet> tweets;
  List<Tweet> filteredTweets;
  bool loading = true;

  void initState() {
    super.initState();
    getTweets();

    FirebaseAnalytics().logEvent(
        name: 'Twitter_Search_Results', parameters: {"city": widget.area});
  }

  getT() async {
    var consumerKey = 'CysHavmnRH44KUT8bTj8obvpb';
    var consumerSecret = 'd3fvW10kV5WyjbiUgGVFYzcpuM1i8cYJPxuFhs5dky05M2p2Sf';
    var token = "848460975221198849-zfXLNozb9YcngE62K3xq2hgIlLK622r";
    var secret = "eE4RHDPBDFgWAONyxqv13fYBkstK8aMilsBy3ywVk9SuC";

    var bearerToken =
        "AAAAAAAAAAAAAAAAAAAAAKoMPwEAAAAAssZhrq9AerMdRowRzYiyPc%2Bo5hk%3DKwkbm1MxEmhdTC8d2xTdSzQNNq1ydv3xg6iHCdGKgNO4WmcFpj";
    final response = await http.get(
        new Uri.https("api.twitter.com", "/1.1/users/search.json?q=soccer", {
          "count": "15",
          "tweet_mode": "extended",
          "exclude_replies": "false"
        }),
        headers: {
          "Authorization":
              'oauth_consumer_key="${consumerKey}", oauth_token="${token}"',
          "Content-Type": "application/json"
        });
    print(response.body);
  }

  getTweets() async {
    setState(() {
      loading = true;
    });
    final tempTweets = await twitterApi.tweetSearchService.searchTweets(
        q: widget.query,
        resultType: "recent",
        tweetMode: "extended",
        locale: "en",
        count: 10);

    print(tempTweets.statuses.length);
    setState(() {
      tweets = tempTweets.statuses;
      filteredTweets = tweets;
      loading = false;
    });
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  RegExp exp =
      new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFf9a825), // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () async {
                  FirebaseAnalytics().logEvent(
                      name: 'Went_To_Twitter_Website', parameters: null);
                  _launchUrl(
                      "https://twitter.com/search?q=${widget.query}&src=typeahead_click&f=live");
                },
                child: Text(
                  "Find Realtime Data On Twitter",
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ),
        appBar: AppBar(
          title: Text(widget.area),
        ),
        body: loading == true
            ? Loading()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: tweets.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 100,
                                child: Image.asset("assets/anxiety.png")),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Sorry!",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "No Tweets Available",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18),
                            ),
                            box30,
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            box20,
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new TextFormField(
                                textInputAction: TextInputAction.go,
                                onChanged: (string) {
                                  setState(() {
                                    filteredTweets = (tweets)
                                        .where((u) => (u.fullText
                                            .toString()
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
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFF2821B5),
                                    ),
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.grey)),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text(
                              //   "Note : To see realtime tweets of covid resources for ${widget.area}, Please tap on the button below.",
                              //   style: TextStyle(
                              //       fontSize: 12, color: Colors.grey[700]),
                              // ),
                            ),
                            filteredTweets.length == 0
                                ? NoResult()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: filteredTweets.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          FirebaseAnalytics().logEvent(
                                              name: 'Went_To_Twitter_Website',
                                              parameters: null);
                                          _launchUrl(
                                              "https://twitter.com/search?q=${widget.query}&src=typeahead_click&f=live");
                                        },
                                        child: Card(
                                          elevation: 2,
                                          shape: new RoundedRectangleBorder(
                                              side: new BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.lightBlue,
                                                      backgroundImage: NetworkImage(
                                                          filteredTweets[index]
                                                                  .user
                                                                  .profileImageUrlHttps ??
                                                              ""),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 10,
                                                      child: Text(
                                                        filteredTweets[index]
                                                                .user
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      FontAwesomeIcons.clock,
                                                      size: 12,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        DateFormat(
                                                              'jm',
                                                            )
                                                                .format(filteredTweets[
                                                                        index]
                                                                    .createdAt)
                                                                .toString()
                                                                .toString() ??
                                                            "",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 12,
                                                        )),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      filteredTweets[index]
                                                                  .retweetedStatus !=
                                                              null
                                                          ? filteredTweets[
                                                                  index]
                                                              .retweetedStatus
                                                              .fullText
                                                          : filteredTweets[
                                                                  index]
                                                              .fullText,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                          ],
                        ),
                      )));
  }
}

class Hmac {}
