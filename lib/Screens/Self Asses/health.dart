import 'package:crisis/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/chat.dart';
import 'widgets/chat_chip.dart';
import 'widgets/chat_data.dart';
import 'widgets/self_assess.dart';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> with TickerProviderStateMixin {
  SelfAssess _selfAssess;
  List<Widget> _chatFlow = [];
  AnimationController _animationController;
  ScrollController _scrollController;
  Animation _animation;
  List value;
  List chatDatas = [];
  int currentChat = 0;
  double maxScroll;
  double minScroll;
  int problemsCount = 0;

  @override
  void initState() {
    _selfAssess = SelfAssess();
    _scrollController = ScrollController();
    for (var i = 0; i < healthData.length; i++) {
      chatDatas.add(
        ChatData(
            question: healthData[i]["question"],
            options: healthData[i]["option"]),
      );
    }
    updateChatFlow();
    super.initState();
  }

  scrollToEnd() {
    // minScroll = _scrollController.position.minScrollExtent;
    // _scrollController.jumpTo(minScroll);
    if (currentChat >= 2) {
      maxScroll = _scrollController.position.maxScrollExtent - 100;
      _scrollController.animateTo(maxScroll,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.decelerate);
    }
  }

  updateChatFlow() {
    updateUI(chatDatas[currentChat], currentChat);
    currentChat++;
  }

  addTestScore(CovidTest covidTest) {
    if (covidTest == CovidTest.OK) {
      addAnswer(_selfAssess.answerOk);
    } else if (covidTest == CovidTest.ATRISK) {
      addAnswer(_selfAssess.answerAtRisk);
    } else if (covidTest == CovidTest.ATNOMINALRISK) {
      addAnswer(_selfAssess.answerNominalRisk);
    }
  }

  void addAnswer(List answers) {
    answers.forEach((answer) {
      _chatFlow.add(Chat(
        text: answer,
      ));
    });
  }

  void addChat(String chat) {
    _chatFlow.add(Chat(text: chat));
    setState(() {});
  }

  updateUI(ChatData chatData, i) {
    value = [];
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: chatData.question.length + 1))
      ..forward();
    _animation = IntTween(begin: 0, end: chatData.question.length - 1)
        .animate(_animationController);
    _animation.addListener(() {
      if (!value.contains(_animation.value)) {
        value.add(_animation.value);
        addChat(chatData.question[_animation.value]);
      }
      if (_animation.isCompleted) {
        _chatFlow.add(ChatChip(
            chatChips: chatData.options,
            problemscallback: (value) {
              problemsCount = problemsCount + value;
              print('Problem Colunt = $problemsCount');
            },
            isCompletedCallBack: () {
              if (currentChat < chatDatas.length) {
                updateChatFlow();
              } else if (currentChat == chatDatas.length) {
                currentChat++;
                print(problemsCount);
                TestScore testScore =
                    TestScore(problems: problemsCount, totalProblems: 12);
                addTestScore(testScore.getCoronaScore());
                setState(() {});
              }
            }));
      }

      print('Current chat: $currentChat');
      setState(() {});
    });
  }

  showChatOptions(List options) {
    _chatFlow.add(ChatChip(chatChips: options));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToEnd();
    });
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Covid-19',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Self Assessment Test',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Material(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: height * 0.2),
          controller: _scrollController,
          // reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height,
              maxHeight: double.infinity,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _chatFlow,
            ),
          ),
        ),
      ),
    );
  }
}

class TestScore {
  int problems;
  int totalProblems;

  TestScore({this.problems, this.totalProblems});

  CovidTest getCoronaScore() {
    CovidTest result;
    if (problems >= 3) {
      result = CovidTest.ATRISK;
    } else if (problems >= 2) {
      result = CovidTest.ATNOMINALRISK;
    } else {
      result = CovidTest.OK;
    }
    return result;
  }
}

enum CovidTest {
  OK,
  ATRISK,
  ATNOMINALRISK,
}
