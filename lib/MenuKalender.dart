import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String _timeZone = 'WIB';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    final formatter = DateFormat('HH:mm:ss');
    if (_timeZone == 'WIB') {
      return formatter.format(dateTime);
    } else if (_timeZone == 'WIT') {
      return formatter.format(dateTime.add(Duration(hours: 1)));
    } else if (_timeZone == 'WITA') {
      return formatter.format(dateTime.add(Duration(hours: 2)));
    } else if (_timeZone == 'London') {
      final londonTime = dateTime.toUtc().add(Duration(hours: 1));
      return formatter.format(londonTime);
    } else {
      return formatter.format(dateTime);
    }
  }

  String _formatDate(DateTime dateTime) {
    final formatter = DateFormat('EEEE, dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _timeZone = value;
              });
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'WIB',
                  child: Text('WIB'),
                ),
                PopupMenuItem(
                  value: 'WIT',
                  child: Text('WIT'),
                ),
                PopupMenuItem(
                  value: 'WITA',
                  child: Text('WITA'),
                ),
                PopupMenuItem(
                  value: 'London',
                  child: Text('LONDON'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blue[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _formatTime(now),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Text(
              _formatDate(now),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
