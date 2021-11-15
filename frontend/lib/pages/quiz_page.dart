import 'package:flutter/material.dart';
import 'package:frontend/components/PrimaryButton.dart';
import 'package:frontend/Model/QuizQuestion.dart';
import 'package:frontend/Model/QuizStatus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/globals.dart' as globals;

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isStarted = true;
  bool showScore = false;
  int _current = 0;

  List<Answers> paramSubmit = [];

  void _onStartTapped(bool started) {
    setState(() {
      isStarted = !started;
    });
  }

  late QuizStatus quizStatusResponse = QuizStatus();
  late QuizQuestion questionStatusResponse = QuizQuestion();
  bool isLoading = false;
  String token = globals.token;

  void getDataFromAPIQuizStatus(String courseId) async {
    setState(() {
      isLoading = true;
    });
    String API_URL = "${globals.baseUrl}/courses/${courseId}/quiz";
    var response = await http.get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      quizStatusResponse = QuizStatus.fromJson(parsedJson);
      isLoading = false;
    });
  }

  void getDataFromAPIQuestion(String courseId) async {
    setState(() {
      isLoading = true;
    });
    String API_URL = "${globals.baseUrl}/courses/${courseId}/quiz/questions";
    var response = await http.get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      questionStatusResponse = QuizQuestion.fromJson(parsedJson);
      isLoading = false;
    });
  }

  Future<void> postSubmitQuestion(String courseId) async {
    setState(() {
      isLoading = true;
    });
    String API_URL = "${globals.baseUrl}/courses/${courseId}/quiz/submit";
    var response = await http.post(Uri.parse(API_URL), headers: {
    'Content-Type' : 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    }, body: jsonEncode(<String, String>{

    }));
    var parsedJson = await json.decode(response.body);
    setState(() {
      questionStatusResponse = QuizQuestion.fromJson(parsedJson);
      isLoading = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getDataFromAPIQuizStatus("adad9cb61ff6417ebf63b5cf37a8c49e");
    getDataFromAPIQuestion("adad9cb61ff6417ebf63b5cf37a8c49e");
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
              child: _current < ((questionStatusResponse.data?.questions ?? []).length) ? Column(
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
                              "Score:",
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
                              "${quizStatusResponse.data?.score ?? 0}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                        new Visibility(
                            child: Padding(
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

                          visible: (quizStatusResponse.data?.score ?? 0) == 0,
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
                              questionStatusResponse.data?.questions?[_current].question ?? "",
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
                                    text: "A. ${questionStatusResponse.data?.questions?[_current].choiceA ?? ""}",
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
                                    text: "B. ${questionStatusResponse.data?.questions?[_current].choiceB ?? ""}",
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
                                    text: "C. ${questionStatusResponse.data?.questions?[_current].choiceC ?? ""}",
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
                                    text: "D. ${questionStatusResponse.data?.questions?[_current].choiceD ?? ""}",
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
                                    text: "E. ${questionStatusResponse.data?.questions?[_current].choiceE ?? ""}",
                                    color: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    onPressed: () {
                                      _onNextIndex();
                                    }),
                              ),
                              new Text("${_current + 1} / ${(questionStatusResponse.data?.questions ?? []).length}")
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
                                      Navigator.pop(context);
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
