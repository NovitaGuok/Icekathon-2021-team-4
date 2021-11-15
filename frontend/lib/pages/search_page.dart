import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/globals.dart' as globals;
import 'dart:convert';
import 'package:frontend/Model/MyCurriculum.dart';
import 'course_detail.dart';
import 'package:frontend/components/HomeCourseCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late MyCurriculum apiResponseModel = MyCurriculum();

  void getDataFromAPICurriculum(String keyword) async {
    String API_URL = "${globals.baseUrl}/courses/curriculum-based?page=1&per_page=10&search_keyword=$keyword&sort=DESC";
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
        leading: Image.asset('assets/images/Logo-white.png'),
        actions: <Widget>[
          IconButton(
            icon: ClipOval(child: Image.asset("assets/images/userImage.jpeg"),),
            iconSize: 50,
            onPressed: () {
              print("Profile tapped");
            },
          ),
        ],
        bottom: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
          title: TextField(
            onSubmitted: (field) {
              if (field.isEmpty) {
                setState(() {
                  apiResponseModel = MyCurriculum();
                });
              } else {
                getDataFromAPICurriculum(field);
              }
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2)
              ),
              hintText: 'Search a topic',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
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
      ),
    );
  }
}
