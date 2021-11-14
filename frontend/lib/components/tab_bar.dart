import 'package:flutter/material.dart';
import 'package:frontend/pages/mylist_page.dart';
import 'package:frontend/pages/search_page.dart';
import '../pages/home.dart';

/// This is the TabBar widget that the main application instantiates.
class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

/// This is the private State class that goes with TabBar.
class _BottomTabBarState extends State<BottomTabBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    MyListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'My List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}