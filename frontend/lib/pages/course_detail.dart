import 'package:flutter/material.dart';
import 'package:frontend/components/lesson_card.dart';
import 'package:frontend/globals.dart' as globals;
import 'package:http/http.dart';
import 'dart:convert';
import '../Model/lesson.dart';

class CourseDetail extends StatefulWidget {
  final String id;
  final String title;
  final String description;

  CourseDetail(this.id, this.title, this.description);

  @override
  _CourseDetailState createState() => _CourseDetailState(id, title, description);
}

class _CourseDetailState extends State<CourseDetail> {
  final String id;
  final String title;
  final String description;

  late Lesson lessonResponseModel = Lesson();

  _CourseDetailState(this.id,this.title,this.description);

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${globals.token}'
  };

  void getLessons() async {
    String API_URL = "${globals.baseUrl}/courses/$id/lessons?page=1&per_page=10&search_keyword=&sort=ASC";
    var response = await get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${globals.token}'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      lessonResponseModel = Lesson.fromJson(parsedJson);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: <Widget>[
              // construct the profile details widget here
              LimitedBox(
                maxHeight: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Business Analyst',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () { },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor
                          ),
                        child: Text('START LESSON 1')
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                          onPressed: () { },
                          style: TextButton.styleFrom(
                            primary: Colors.white
                          ),
                          child: Text('Add to my list')
                      ),
                    )
                  ],
                ),
              ),
              // the tab bar with two items
              TabBar(
                labelColor: Colors.white,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    text: 'Lesson',
                  ),
                  Tab(
                    text: 'Overview',
                  ),
                ],
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    ListView(
                      children: listLesson(lessonResponseModel.data ?? []),
                    ),

                    // second tab bar view widget
                    ListView(
                      padding: EdgeInsets.all(20),
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.white70
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "What you'll get",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.video_collection),
                                    SizedBox(width: 10),
                                    Text(
                                      'Many videos',
                                      style: TextStyle(
                                        color: Colors.white70
                                      ),
                                    )
                                  ],
                                ),
                                Divider(color: Colors.white38),
                                Row(
                                  children: [
                                    Icon(Icons.collections_bookmark),
                                    SizedBox(width: 10),
                                    Text(
                                      'Many blogs',
                                      style: TextStyle(
                                          color: Colors.white70
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                    ),

                    // TODO: Third tab bar for quiz
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listLesson(List<Data> item)
  {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < item.length; i++){
      list.add(
          LessonCard(
            item[i].title ?? "",
            item[i].contentType ?? "",
            item[i].description ?? "",
            item[i].contentUrl ?? ""
          )
      );
    }
    list.add(
      LessonCard("Story Carding Quiz #1", "Quiz", "Test your knowledge", "")
    );
    return list;
  }
}

