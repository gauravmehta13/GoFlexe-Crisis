import 'package:crisis/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../redux/actions.dart';

class AdditionalInformation extends StatefulWidget {
  @override
  _AdditionalInformationState createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation> {
  @override
  bool pickupLift = true;
  bool dropLift = true;
  String pickupFloor = "";
  String dropFloor = "";
  storeData() {
    StoreProvider.of<AppState>(context).dispatch(DropFloor(dropFloor));
    StoreProvider.of<AppState>(context).dispatch(PickupFloor(pickupFloor));
    StoreProvider.of<AppState>(context).dispatch(PickupLift(pickupLift));
    StoreProvider.of<AppState>(context).dispatch(DropLift(dropLift));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFf9a825), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () async {
              await storeData();
            },
            child: Text(
              "Next",
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
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(25),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Additional Information",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.chartArea),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF2821B5),
                            ),
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          labelText: 'House Area',
                          helperText: "Enter Carpet Area",
                          suffix: Text("Sqft"),
                        ),
                        onChanged: (e) {
                          // StoreProvider.of<AppState>(context)
                          //     .dispatch(HouseArea(e));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.car == true)
                            Expanded(
                              child: DropDown(
                                items: ["Hatchback", "Sedan", "SUV"],
                                hint: Text("Select Car Type"),
                                onChanged: (e) {
                                  //   StoreProvider.of<AppState>(context)
                                  //       .dispatch(CarType(e));
                                  //
                                },
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          if (state.bike == true)
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 2,
                                style: TextStyle(height: 0.5),
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: 'No. Of Bikes',
                                    labelStyle: TextStyle(color: Colors.grey)),
                                onChanged: (e) {
                                  // StoreProvider.of<AppState>(context)
                                  //     .dispatch(NoOfBikes(e));
                                },
                              ),
                            )
                        ],
                      ),
                      // Divider(),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Drop Floor",
                      //       style: TextStyle(fontWeight: FontWeight.w600),
                      //     ),
                      //     SizedBox(
                      //       width: 13.5,
                      //     ),
                      //     Expanded(
                      //       child: SliderTheme(
                      //         data: SliderTheme.of(context).copyWith(
                      //           activeTrackColor: Color(0xFF3f51b5),
                      //           inactiveTrackColor: Color(0xFFf9a825),
                      //           trackShape: RoundedRectSliderTrackShape(),
                      //           trackHeight: 2.0,
                      //           thumbShape: RoundSliderThumbShape(
                      //               enabledThumbRadius: 8.0),
                      //           thumbColor: Color(0xFF3f51b5),
                      //           overlayColor: Colors.red.withAlpha(32),
                      //           overlayShape: RoundSliderOverlayShape(
                      //               overlayRadius: 20.0),
                      //           tickMarkShape: RoundSliderTickMarkShape(),
                      //           activeTickMarkColor: Color(0xFF3f51b5),
                      //           inactiveTickMarkColor: Colors.red[100],
                      //           valueIndicatorShape:
                      //               PaddleSliderValueIndicatorShape(),
                      //           valueIndicatorColor: Color(0xFFf9a825),
                      //           valueIndicatorTextStyle: TextStyle(
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //         child: Slider(
                      //           value: dropFloor,
                      //           min: 0,
                      //           max: 10,
                      //           divisions: 10,
                      //           label: '${dropFloor.floor()}',
                      //           onChanged: (value) {
                      //             setState(
                      //               () {
                      //                 dropFloor = value;
                      //               },
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     Text(dropFloor == 0
                      //         ? "Ground Floor"
                      //         : "${dropFloor.floor().toString()} Floor")
                      //   ],
                      // ),
                    ],
                  );
                })),
      ),
    );
  }
}
