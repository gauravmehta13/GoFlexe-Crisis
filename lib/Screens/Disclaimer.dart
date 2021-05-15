import 'package:crisis/Constants.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                      height: 50, child: Image.asset("assets/alert.png")),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Medical Disclaimer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                box30,
                Text(
                  "The GoFlexe website does not contain medical advice. The contents of this website, such as text, graphics, images and other material are intended for informational and educational purposes only and not for the purpose of rendering medical advice. The contents of this website are not intended to substitute for professional medical advice, diagnosis or treatment. Although we take efforts to keep the medical information on our website updated, we cannot guarantee that the information on our website reflects the most up-to-date research.\n\nPlease consult your physician for personalized medical advice. Always seek the advice of a physician or other qualified healthcare provider with any questions regarding a medical condition. Never disregard or delay seeking professional medical advice or treatment because of something you have read on the GoFlexe website.\n\nBefore taking any medications, over-the-counter drugs, supplements or herbs, consult a physician for a thorough evaluation. Goflexe does not endorse any medications, vitamins or herbs. A qualified physician should make a decision based on each person's medical history and current prescriptions. The medication summaries provided do not include all of the information important for patient use and should not be used as a substitute for professional medical advice. The prescribing physician should be consulted concerning any questions that you have.\n\nGoFlexe does not recommend or endorse any specific test, physician, product, procedure, opinion or any other information provided on its website. Reliance on any information provided by GoFlexe, GoFlexe employees, others represented on the website by GoFlexe' invitation or other visitors to the website, is solely at your own risk.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
