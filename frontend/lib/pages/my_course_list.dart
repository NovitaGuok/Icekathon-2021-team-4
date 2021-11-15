import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/globals.dart' as globals;
import 'package:frontend/Model/MyCurriculum.dart';
import 'package:frontend/components/HomeCourseCard.dart';
import 'course_detail.dart';
import 'dart:convert';

class MyCourseList extends StatefulWidget {
  const MyCourseList({Key? key}) : super(key: key);

  @override
  _MyCourseListState createState() => _MyCourseListState();
}

class _MyCourseListState extends State<MyCourseList> {
  late MyCurriculum apiResponseModel = MyCurriculum();

  void getDataFromAPICurriculum() async {
    String API_URL = "${globals.baseUrl}/courses/curriculum-based?page=1&per_page=10&search_keyword=&sort=DESC";
    var response = await get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${globals.token}'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      apiResponseModel = MyCurriculum.fromJson(parsedJson);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromAPICurriculum();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: (apiResponseModel.data ?? []).length,
          itemBuilder: (context, index) {
            Data course = apiResponseModel.data![index];
            return HomeCourseCard(
              title: course.title ?? "",
              subtitle: course.curriculumTitle ?? "",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(course.id ?? "", course.title ?? "", course.description ?? "", course.curriculumTitle ?? "")));
              },
            );
          }
          ),
    );
  }
}
