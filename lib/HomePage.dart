import 'package:flutter/material.dart';
import 'package:quran_app/MenuKalender.dart';
import 'package:quran_app/MenuProfile.dart';
import 'QuranPage.dart';
import 'CurrencyConverterPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    QuranPage(),
    MoneyConversion(),
    CalendarPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Quran App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        height: 50,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <Widget>[
          Icon(Icons.book, size: 30),
          Icon(Icons.monetization_on, size: 30),
          Icon(Icons.calendar_today, size: 30),
          Icon(Icons.person, size: 30),
        ],
      ),
    );
  }
}
