import 'package:flutter/material.dart';
import 'package:frontend/components/PrimaryButton.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isStarted = true;
  bool showScore = false;
  final List<String> items = ['apple', 'banana', 'orange', 'lemon'];
  int _current = 0;

  void _onStartTapped(bool started) {
    setState(() {
      isStarted = !started;
    });
  }

  void _onTapShowScore(bool show) {
    setState(() {
      showScore = !show;
    });
  }

  void _onNextIndex() {
      setState(() {
        _current += 1;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            _onStartTapped(isStarted);
          },
        ),
        title: Text(
          "Quiz",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _current < (items.length - 1) ? Column(
                children: <Widget>[
                  new Visibility(
                    child: Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                          child: new Center(
                            child: new Text(
                              "Course Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                          child: new Center(
                            child: new Text(
                              "Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: new Center(
                            child: new Text(
                              "Status Quiz",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                          child: new Center(
                            child: new PrimaryButton(
                              text: "Start Quiz",
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                _onStartTapped(isStarted);
                              },
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    visible: isStarted,
                  ),
                  new Visibility(
                    child: Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                          child: new Center(
                            child: Text(
                              items[_current],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: new PrimaryButton(
                                    text: "A. Selection",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    onPressed: () {
                                      _onNextIndex();
                                    }),
                              ),
                              new Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: new PrimaryButton(
                                    text: "A. Selection",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    onPressed: () {
                                      _onNextIndex();
                                    }),
                              ),
                              new Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: new PrimaryButton(
                                    text: "A. Selection",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    onPressed: () {
                                      _onNextIndex();
                                    }),
                              ),
                              new Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: new PrimaryButton(
                                    text: "A. Selection",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    onPressed: () {
                                      _onNextIndex();
                                    }),
                              ),
                              new Text("${_current + 1} / ${items.length}")
                            ],
                          ),
                        ),
                      ],
                    ),
                    visible: !isStarted,
                  ),
                ],
              )
                  : Column(
                      children: <Widget>[
                        new Visibility(
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.all(20),
                                child: new Text(
                                    "All of question is answered, you can submit your work on button below",
                                  style: TextStyle(fontSize: 20,),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              new PrimaryButton(
                                text: "Submit",
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _onTapShowScore(showScore);
                                },
                              ),
                            ],
                          ),
                          visible: !showScore,
                        ),

                        new Visibility(
                            child: new Column(
                              children: <Widget>[
                                new Text("Your Score"),

                                new Padding(
                                    padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "70",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ),
                                ),

                                new PrimaryButton(
                                    text: "Back",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                                    onPressed: () {
                                      print("go back");
                                    })
                              ],
                            ),
                          visible: showScore,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
