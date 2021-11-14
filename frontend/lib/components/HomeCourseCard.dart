import 'package:flutter/material.dart';

class HomeCourseCard extends StatelessWidget {
  const HomeCourseCard({Key? key,required this.title, required this.subtitle, required this.onTap}) : super(key: key);

  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: new Image.asset(
                "assets/images/class-img.jpeg",
                height: 140,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),

            new Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: new Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),

            new Text(
              subtitle,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
              ),
            ),
          ],
        ),
      )
    );
  }
}
