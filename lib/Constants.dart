import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rating_dialog/rating_dialog.dart';

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}

sendFeedback(rating, comment) async {
  var dio = Dio();
  try {
    final response = await dio.post(
        'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
        data: {
          'tenantSet_id': 'CRISIS01',
          'tenantUsecase': 'CRISIS01',
          "useCase": "feedback",
          "rating": rating.toString(),
          "comment": comment.toString()
        });
    print(response);
    Map<String, dynamic> map = json.decode(response.toString());
    displaySnackBar(map["resp"]["allPrices"].toString(),
        myGlobals.scaffoldKey.currentContext);
  } catch (e) {
    print(e);
  }
}

Future<void> giveFeedback(ctx) async {
  return showDialog(
      context: ctx,
      builder: (ctx) => RatingDialog(
            // your app's name?
            title: 'Found this Helpful?',
            // encourage your user to leave a high rating?
            message:
                'Tap a star to set your rating. Add more description here if you want.',
            // your app's logo?
            image:
                SizedBox(height: 100, child: Image.asset("assets/rating.png")),
            submitButton: 'Submit',
            onCancelled: () => print('cancelled'),
            onSubmitted: (response) {
              print('rating: ${response.rating}, comment: ${response.comment}');
              sendFeedback(response.rating, response.comment);
            },
          ));
}

const EdgeInsets padding10 = EdgeInsets.all(10);
const SizedBox box10 = SizedBox(
  height: 10,
);
const SizedBox box20 = SizedBox(
  height: 20,
);
const SizedBox box30 = SizedBox(
  height: 30,
);
const Color primaryColor = Color(0xFF3f51b5);
const Color secondaryColor = Color(0xFFf9a825);

class C {
  static const primaryColor = Color(0xFF3f51b5);
  static const secondaryColor = Color(0xFFf9a825);

  static const textfieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0));

  static const box10 = SizedBox(
    height: 10,
  );
  static const box20 = SizedBox(
    height: 20,
  );
  static const box30 = SizedBox(
    height: 30,
  );
  static const wbox10 = SizedBox(
    width: 10,
  );
  static const wbox20 = SizedBox(
    width: 20,
  );
  static const wbox30 = SizedBox(
    width: 30,
  );
}

displaySnackBar(text, ctx) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ),
  );
}
