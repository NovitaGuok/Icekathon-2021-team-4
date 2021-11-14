import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My List", style: TextStyle(fontWeight: FontWeight.bold),),
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
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'LESSONS'),
              Tab(text: 'COURSES')
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('My Lessons View')),
            Center(child: Text('My Courses View'))
          ],
        ),
      ),
    );
  }
}
