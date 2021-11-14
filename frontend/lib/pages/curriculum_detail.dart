import 'package:flutter/material.dart';
import 'package:frontend/components/HomeCourseCard.dart';

class CurriculumDetail extends StatefulWidget {
  const CurriculumDetail({Key? key}) : super(key: key);

  @override
  _CurriculumDetailState createState() => _CurriculumDetailState();
}

class _CurriculumDetailState extends State<CurriculumDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'My Curriculum',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
            ),
          ),
          Divider(
            height: 10,
            indent: 50,
            endIndent: 50,
            color: Colors.white,
            thickness: 2
          ),
          Center(
            child: Text(
              '2021',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Overview title',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: TextStyle(
                color: Colors.white70
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget listWidgetClassPreview(List<Map<dynamic,dynamic>> classes)
  {
    List<Widget> list = <Widget>[];
    for(var classPrev in classes){
      list.add(
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: HomeCourseCard(
              title: classPrev[''],
              subtitle: classPrev[''],
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
              },),
          )
      );
    }
    return Row(children: list);
  }
}
