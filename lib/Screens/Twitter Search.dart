import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../Constants.dart';
import 'package:csc_picker/csc_picker.dart';

class TwitterScreen extends StatefulWidget {
  @override
  _TwitterScreenState createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {
  ScrollController _scrollController = ScrollController();
  String city = "";

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
                  "https://twitter.com/search?q=verified+$city+(bed+OR+beds+OR+icu+OR+oxygen+OR+ventilator+OR+ventilators+OR+fabiflu)+-%22not+verified%22+-%22unverified%22+-%22needed%22+-%22required%22&f=live"),
              builder: (context, followLink) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFf9a825), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: city.isEmpty ? null : followLink,
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
          padding: EdgeInsets.all(20),
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
              Autocomplete<String>(
                displayStringForOption: (option) => option,
                fieldViewBuilder: (context, textEditingController, focusNode,
                        onFieldSubmitted) =>
                    TextField(
                  controller: textEditingController,
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
                  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
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
            ],
          ),
        ),
      ),
    );
  }
}
