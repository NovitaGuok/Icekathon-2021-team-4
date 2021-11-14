import 'package:flutter/material.dart';
import 'package:frontend/pages/webview.dart';

class LessonCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final String url;

  LessonCard(this.title, this.subtitle, this.description, this.url);

  @override
  _LessonCardState createState() => _LessonCardState(title, subtitle, description, url);
}

class _LessonCardState extends State<LessonCard> {
  final String title;
  final String subtitle;
  final String description;
  final String url;
  
  _LessonCardState(this.title, this.subtitle, this.description, this.url);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      color: Colors.white10,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                // TODO: Lesson thumbnail
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white70
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
                description,
                style: TextStyle(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white38,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
                    },
                    child: Text('Start lesson'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
