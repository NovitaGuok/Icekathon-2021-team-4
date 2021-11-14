import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      body: Container(),
    );
  }
}
