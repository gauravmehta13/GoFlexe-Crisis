import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_display/delayed_display.dart';
import 'animations/typing_message.dart';
import 'chat_bubble.dart';

class Chat extends StatefulWidget {
  final String text;

  Chat({this.text});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool showTyping = true;
  TypingMessage _typingMessage;

  @override
  void initState() {
    _typingMessage = TypingMessage();
    Future.delayed(const Duration(seconds: 1), () {
      showTyping = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showTyping
        ? DelayedDisplay(
            child: _typingMessage,
          )
        : ChatBubble(
            child: Text(
              widget.text,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                //fontWeight: FontWeight.normal,
                color: Color(0xFF325384),
              ),
            ),
          );
  }
}
