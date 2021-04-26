import 'dart:convert';
import 'package:crisis/Order/Residential%20Move.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../../Constants.dart';
import 'Map Based Tracking.dart';
import 'Order Details.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Place> place = [];
  Random random = new Random();
  List orders = [];
  List filteredOrders = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    place.add(new Place(true, 'All'));
    place.add(new Place(false, 'In Transit'));
    place.add(new Place(false, 'Delivered'));
    this.fetchOrders();
  }

  Place selectedPlace;
  fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    var dio = Dio();
    var url =
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder/customer/${_auth.currentUser.uid}?tenantSet_id=PAM01&usecase=customerOrder";
    print(url);
    final response = await dio.get(url,
        options: Options(
          responseType: ResponseType.plain,
        ));

    var items = json.decode(response.toString());

    for (var i = 0; i < items.length; i++) {
      try {
        var resp = await dio.get(
            'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/tracking?type=getProcessByCustomerOrderId&customerOrderId=${items[i]["OrderId"]}',
            options: Options(responseType: ResponseType.plain));
        print(resp);
        Map<String, dynamic> map = json.decode(resp.toString());
        var progress = getCurrentStage(map);
        items[i]["trackingData"] = map;
        items[i]["progress"] = progress;
      } catch (e) {
        items[i]["progress"] = "Waiting Acceptance";
      }
      print(items[i]["progress"]);
    }

    setState(() {
      orders = items;
      filteredOrders = orders;
      isLoading = false;
    });
    orders
        .sort((a, b) => (b["progress"].length).compareTo(a["progress"].length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "GoFlexe",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text(
              "My Orders",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: new GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 4 / 1),
              shrinkWrap: true,
              itemCount: place.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlace = place[index];
                      place.forEach((element) {
                        element.isSelected = false;
                      });
                      place[index].isSelected = true;
                      if (place[index].title == "All") {
                        filteredOrders = orders;
                      }
                      if (place[index].title == "In Transit") {
                        filteredOrders = (orders)
                            .where((u) => u['progress']
                                .toLowerCase()
                                .contains("in transit"))
                            .toList();
                      }
                      if (place[index].title == "Delivered") {
                        filteredOrders = (orders)
                            .where((u) => u['progress']
                                .toLowerCase()
                                .contains("delivered"))
                            .toList();
                      }
                      print(place[index].title);
                    });
                  },
                  child: new PlaceSelection(place[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: filteredOrders.length != 0
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: filteredOrders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  var route = new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          OrderDetails(
                                            details: filteredOrders[index],
                                          ));
                                  Navigator.of(context).push(route);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 1.5,
                                  child: Container(
                                      height: 150,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Order No. ${filteredOrders[index]['OrderId'].substring(0, 4) ?? "NA"}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Spacer(),
                                              Text(
                                                new DateFormat("EEE, d MMMM")
                                                    .format(DateTime.parse(
                                                        filteredOrders[index]
                                                            ["orderDate"]))
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          orders[index]["movementType"] ==
                                                  "OutStation"
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      'From :  ',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Hyderabad",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      'To : ',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Chennai",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'City :  ',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      filteredOrders[index]
                                                              ["pickupCity"] ??
                                                          "NA",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                'Shift type : ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                filteredOrders[index]
                                                        ["shiftType"] ??
                                                    "NA",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              Spacer(),
                                              Text(
                                                'Total Amount : ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                'Rs. ${filteredOrders[index]["totalAmount"].toString() ?? "NA"}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              if (filteredOrders[index]
                                                      ["progress"] !=
                                                  "Delivered")
                                                filteredOrders[index]
                                                            ["progress"] ==
                                                        "Waiting Acceptance"
                                                    ? MaterialButton(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                        onPressed: () {
                                                          var route =
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      OrderDetails(
                                                                        details:
                                                                            filteredOrders[index],
                                                                      ));
                                                          Navigator.of(context)
                                                              .push(route);
                                                        },
                                                        textColor: Colors.white,
                                                        color: primaryColor,
                                                        child: Text("Details",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                      )
                                                    : MaterialButton(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                        onPressed: () {
                                                          var route =
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      FlutterMap(
                                                                        details:
                                                                            filteredOrders[index],
                                                                      ));
                                                          Navigator.of(context)
                                                              .push(route);
                                                        },
                                                        textColor: Colors.white,
                                                        color: primaryColor,
                                                        child: Text("Track",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                      ),
                                              Spacer(),
                                              // if (index == 1)
                                              //   Text(
                                              //     'Delivered',
                                              //     style: TextStyle(
                                              //         color: primaryColor,
                                              //         fontSize: 15,
                                              //         fontWeight: FontWeight.w600),
                                              //   )
                                              // else if (index == 2)
                                              //   Text(
                                              //     'Cancelled',
                                              //     style: TextStyle(
                                              //         color: Colors.orange[800],
                                              //         fontSize: 15,
                                              //         fontWeight: FontWeight.w600),
                                              //   )
                                              // else
                                              Text(
                                                filteredOrders[index]
                                                    ["progress"],
                                                style: TextStyle(
                                                    color: filteredOrders[index]
                                                                ["progress"] ==
                                                            "In Transit"
                                                        ? Colors.green
                                                        : filteredOrders[index][
                                                                    "progress"] ==
                                                                "Delivered"
                                                            ? C.primaryColor
                                                            : Colors
                                                                .orange[800],
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            );
                          })
                      : Container(
                          child: Center(
                          child: Text("No Orders"),
                        ))),
        ],
      ),
    );
  }

  getCurrentStage(d) {
    var count = 0;
    var data = d["stages"];
    data.forEach((stage) => {
          if (stage["status"] == "COMPLETED") {count++}
        });
    if (count == 0) {
      return "Pending Assignment";
    } else if (data.length == count) {
      return "Delivered";
    } else {
      return "In Transit";
    }
  }
}
