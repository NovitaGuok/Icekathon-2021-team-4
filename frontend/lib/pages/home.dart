import 'package:flutter/material.dart';
import 'package:frontend/components/HomeCourseCard.dart';
import 'course_detail.dart';
import 'package:frontend/Model/MyCurriculum.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyCurriculum apiResponseModel = MyCurriculum();
  late MyCurriculum popularResponseModel = MyCurriculum();
  bool isLoading = false;

  void getDataFromAPICurriculum() async {
    setState(() {
      isLoading = true;
    });
    String API_URL = "${globals.baseUrl}/courses/curriculum-based?page=1&per_page=10&search_keyword=&sort=DESC";
    var response = await http.get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${globals.token}'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      apiResponseModel = MyCurriculum.fromJson(parsedJson);
      isLoading = false;
    });
  }

  void getDataFromAPIPopular() async {
    setState(() {
      isLoading = true;
    });
    String API_URL = "${globals.baseUrl}/courses/popular?page=1&per_page=10&search_keyword=&sort=DESC";
    var response = await http.get(Uri.parse(API_URL), headers: {
      'Content-Type' : 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${globals.token}'
    });
    var parsedJson = await json.decode(response.body);
    setState(() {
      popularResponseModel = MyCurriculum.fromJson(parsedJson);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDataFromAPICurriculum();
    getDataFromAPIPopular();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                      child: Text(
                        "My Curriculum",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
                      child: Stack(
                        children: <Widget>[
                          new SingleChildScrollView(
                            child: listWidgetMyCurriculum(apiResponseModel.data ?? []),
                            scrollDirection: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 30, 20),
                      child: Text(
                        "Popular Courses",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
                      child: Stack(
                        children: <Widget>[
                          new SingleChildScrollView(
                            child: listWidgetClassPreview(popularResponseModel.data ?? []),
                            scrollDirection: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      ),
    );
  }

  Widget listWidgetMyCurriculum(List<Data> item)
  {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < item.length; i++){
      list.add(
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: HomeCourseCard(
              title: item[i].title ?? "",
              subtitle: item[i].description ?? "",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(item[i].id ?? "", item[i].title ?? "", item[i].description ?? "")));
              },),
          )
    );
    }
    return Row(children: list);
  }

  Widget listWidgetClassPreview(List<Data> item)
  {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < item.length; i++){
      list.add(
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: HomeCourseCard(
              title: item[i].title ?? "",
              subtitle: item[i].description ?? "",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(item[i].id ?? "", item[i].title ?? "", item[i].description ?? "")));
              },),
          )
      );
    }
    return Row(children: list);
  }
}
