import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/lesson_card.dart';
import '../Model/lesson.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:frontend/globals.dart'as globals;

class MyLessonsView extends StatefulWidget {
  const MyLessonsView({Key? key}) : super(key: key);

  @override
  _MyLessonsViewState createState() => _MyLessonsViewState();
}

class _MyLessonsViewState extends State<MyLessonsView> {
  late Lesson lessonResponseModel = Lesson();

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${globals.token}'
  };

  void getLessons() async {
    String API_URL = "${globals.baseUrl}/courses/9385077a459540ca8bdcbfe6a0d0e867/lessons?page=1&per_page=10&search_keyword=&sort=ASC";
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
    return ListView.builder(
        itemCount: (lessonResponseModel.data ?? []).length,
        itemBuilder: (context, index) {
          Data lesson = lessonResponseModel.data![index];
          return LessonCard(lesson.title ?? '', lesson.contentType ?? '', lesson.description ?? '', lesson.contentUrl ?? '');
          // return ListTile(
          //   title: Text(lesson.title ?? ""),
          //   subtitle: Text(lesson.description ?? ""),
          // );
        },
    );
  }
}
