import 'package:coding_minds_bootstrap/pages/gym_page.dart';
import 'package:coding_minds_bootstrap/pages/house_page.dart';
import 'package:coding_minds_bootstrap/pages/school_page.dart';
import 'package:coding_minds_bootstrap/pages/work_page.dart';
import 'package:flutter/material.dart';

// Home Page (bottom navigation bar)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    SchoolPage(),
    WorkPage(),
    GymPage(),
    HousePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap:(int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Gym'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'House'
          ),
        ]
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}