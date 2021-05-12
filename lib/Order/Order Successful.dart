import 'package:flutter/material.dart';

import '../HomePage/Hospital.dart';

class OrderSuccessful extends StatefulWidget {
  @override
  _OrderSuccessfulState createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  TimeOfDay evening = TimeOfDay(hour: 19, minute: 0);
  TimeOfDay morning = TimeOfDay(hour: 10, minute: 0);
  TimeOfDay midnight = TimeOfDay(hour: 23, minute: 0);
  TimeOfDay nowTime = TimeOfDay.now();

  String subheading;

  void initState() {
    super.initState();
    print(nowTime.hour);
    if (morning.hour <= nowTime.hour && nowTime.hour <= evening.hour) {
      subheading = "Your Order will be confirmed within 5 minutes";
    } else if (evening.hour <= nowTime.hour && nowTime.hour <= midnight.hour) {
      subheading = "Your Order will be confirmed next day\nby 10.05 am";
    } else if (midnight.hour >= nowTime.hour && nowTime.hour <= morning.hour) {
      subheading = "Your Order will be confirmed by 10.05 am";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
          height: 50,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Color(0xFFf9a825),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Hospital(),
                  ));
            },
            child: Text(
              "Return to Home Screen",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Packers & Movers",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Order Placed Successfully",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subheading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: 100,
            ),
            ImageIcon(
              AssetImage('assets/package.png'),
              color: Color(0xFFf9a825),
              size: 200,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
