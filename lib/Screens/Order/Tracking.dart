import 'package:crisis/Widgets/Stepper.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';

class Tracking extends StatefulWidget {
  final details;
  Tracking({@required this.details});
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  List trackingDetails = [];
  List<FAStep> trackingSteps = [];
  int _currentStep = 0;
  bool orderDelivered = false;
  FAStepperType _stepperType = FAStepperType.vertical;
  bool isLoading = true;
  bool orderNotAccepted = false;

  void initState() {
    super.initState();
    getTracking();
  }

  getTracking() async {
    try {
      // var dio = Dio();
      // var resp = await dio.get(
      //     'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/tracking?type=getProcessByCustomerOrderId&customerOrderId=${widget.orderId}',
      //     options: Options(responseType: ResponseType.plain));
      // print(resp);
      // Map<String, dynamic> map = json.decode(resp.toString());
      setState(() {
        trackingDetails = widget.details["trackingData"]["stages"];
        print(trackingDetails);
      });
      getCurrentStage(widget.details["trackingData"]["stages"]);
      for (var i = 0; i < trackingDetails.length; i++) {
        trackingSteps.add(
          FAStep(
              title: Text(trackingDetails[i]["stageLabel"]),
              isActive: true,
              state: _getState(trackingDetails[i]["number"]),
              content: Container(
                width: double.infinity,
                child: Text(trackingDetails[i]["description"]),
              )),
        );
      }
    } catch (e) {
      setState(() {
        orderNotAccepted = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  getCurrentStage(data) {
    var count = 0;
    data.forEach((stage) => {
          if (stage["status"] == "COMPLETED") {count++}
        });
    if (data.length == count) {
      setState(() {
        orderDelivered = true;
      });
    } else {
      setState(() {
        _currentStep = count;
      });
    }
  }

  increaseStep() {
    setState(() {
      if (this._currentStep < 4) {
        this._currentStep = this._currentStep + 1;
      } else if (this._currentStep == 4) {
        setState(() {
          orderDelivered = true;
        });
      }
    });
  }

  List tracking = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: C.primaryColor, width: 2),
          borderRadius: BorderRadius.vertical(
              top: (Radius.circular(30)), bottom: (Radius.circular(0))),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height / 2,
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : orderNotAccepted == true
                ? Container(
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Waiting for Service Provider to accept Order")
                        ]))
                : orderDelivered == false
                    ? trackingStepper()
                    : Container(
                        width: double.infinity,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/check.png",
                                height: 60,
                                width: 60,
                              ),
                              C.box20,
                              Text(
                                "Order Delivered Successfully",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ])));
  }

  Widget trackingStepper() {
    return FAStepper(
        titleHeight: 20,
        // titleHeight: 120.0,
        stepNumberColor: Colors.grey,
        // titleIconArrange: FAStepperTitleIconArrange.column,
        physics: ClampingScrollPhysics(),
        type: _stepperType,
        currentStep: this._currentStep,
        // onStepTapped: (step) {
        //   setState(() {
        //     this._currentStep = step;
        //   });
        //   print('onStepTapped :' + step.toString());
        // },
        // onStepContinue: () {
        //   setState(() {
        //     if (this._currentStep < 4 - 1) {
        //       this._currentStep = this._currentStep + 1;
        //     } else {
        //       _currentStep = 0;
        //     }
        //   });
        //   print('onStepContinue :' + _currentStep.toString());
        // },
        // onStepCancel: () {
        //   setState(() {
        //     if (this._currentStep > 0) {
        //       this._currentStep = this._currentStep - 1;
        //     } else {
        //       this._currentStep = 0;
        //     }
        //   });
        //   print('onStepCancel :' + _currentStep.toString());
        // },
        steps: trackingSteps);
  }

  FAStepstate _getState(int i) {
    if (_currentStep > i)
      return FAStepstate.complete;
    else if (_currentStep == i - 1) {
      return FAStepstate.indexed;
    } else
      return FAStepstate.indexed;
  }
}
