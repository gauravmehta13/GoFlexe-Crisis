import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Fade Route.dart';

class CarouselWidget extends StatelessWidget {
  final String imgUrl;
  final Widget page;
  final String heading;
  final String subHeading;

  CarouselWidget({this.heading, this.imgUrl, this.page, this.subHeading});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            FadeRoute(page: page),
          );
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Image.asset(
                    imgUrl,
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(heading,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w800)),
                        box10,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            subHeading,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
