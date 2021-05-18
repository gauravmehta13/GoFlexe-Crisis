import 'package:crisis/Constants.dart';
import 'package:crisis/Screens/Self%20Asses/widgets/chat_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_bubble.dart';

List allReply = [];

class ChatChip extends StatefulWidget {
  final ChatData chatChips;
  final Function isCompletedCallBack;
  final Function problemscallback;

  ChatChip(
      {@required this.chatChips,
      this.isCompletedCallBack,
      this.problemscallback});

  @override
  _ChatChipState createState() => _ChatChipState();
}

class _ChatChipState extends State<ChatChip> {
  List<bool> _selectedValue;
  bool showNextButton = false;
  List<String> chips;
  List<String> questions;
  bool showReply = false;
  List<String> replies = [];
  int problems = 0;

  @override
  void initState() {
    initializeChips();
    super.initState();
  }

  initializeChips() {
    chips = List.from(widget.chatChips.options, growable: true);
    questions = List.from(widget.chatChips.question, growable: true);
    buildNextButton();
    _selectedValue = List.generate(chips.length, (index) => false);
  }

  buildNextButton() {
    String next = 'Next';
    String noneOfThese = 'None of These';
    if (showNextButton) {
      if (chips.contains(noneOfThese)) {
        chips.remove(noneOfThese);
        chips.add(next);
      } else {
        if (!chips.contains(next)) {
          chips.add(next);
        }
      }
    } else {
      if (chips.contains(next)) {
        chips.remove(next);
        chips.add(noneOfThese);
      } else {
        if (!chips.contains(noneOfThese)) {
          chips.add(noneOfThese);
        }
      }
    }
  }

  updateNextButton() {
    if (_selectedValue.contains(true)) {
      showNextButton = true;
    } else {
      showNextButton = false;
    }
  }

  onTapped(value) {
    if (value != chips.length - 1) {
      updateNextButton();
      buildNextButton();
      setState(() {});
    } else {
      if (showNextButton) {
        problems++;
        widget.problemscallback(problems);
        showReply = true;
        for (int selected = 0;
            selected < _selectedValue.length - 1;
            selected++) {
          if (_selectedValue[selected]) {
            replies.add(chips[selected]);
          }
        }
        Map tempMap = {"index": questions, "reply": replies};
        allReply.add(tempMap);
        setState(() {});
      } else {
        showReply = true;
        for (int selected = 0; selected < _selectedValue.length; selected++) {
          if (_selectedValue[selected]) {
            replies.add(chips[selected]);
          }
        }
        Map tempMap = {"index": questions, "reply": replies};
        allReply.add(tempMap);
        setState(() {});
      }
      print(replies.toString());
      print(allReply.toString());
    }
  }

  buildReply(List<String> replies) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.isCompletedCallBack();
    }); //calling isCompletedCallback after building the widget
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        replies.length,
        (index) {
          return Container(
            alignment: Alignment.centerRight,
            child: ChatBubble(
              child: Text(
                replies[index],
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  //fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              isReply: true,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return showReply ? buildReply(replies) : buildChips(width);
  }

  Widget buildChips(double width) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.07, vertical: width * 0.025),
      child: Wrap(
        children: List.generate(
          chips.length,
          (index) {
            return Container(
              padding: EdgeInsets.only(right: width * 0.02),
              child: ChoiceChip(
                selected: _selectedValue[index],
                onSelected: (value) {
                  _selectedValue[index] = value;
                  onTapped(index);
                },
                label: FittedBox(
                  child: Text(
                    chips[index],
                  ),
                ),
                labelStyle: GoogleFonts.montserrat(
                  color: _selectedValue[index]
                      ? const Color(0xFFFFFFFF)
                      : primaryColor,
                  fontSize: 14,
                ),
                labelPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.035, vertical: width * 0.007),
                selectedColor: primaryColor,
                backgroundColor: const Color(0xFFFFFFFF),
                // shape: RoundedRectangleBorder(
                //     side: BorderSide(), borderRadius: BorderRadius.circular(20)),
                shadowColor: Colors.black,
                pressElevation: 0,
                elevation: 15,
                selectedShadowColor: const Color(0xFFF8F8FF),
              ),
            );
          },
        ),
      ),
    );
  }
}