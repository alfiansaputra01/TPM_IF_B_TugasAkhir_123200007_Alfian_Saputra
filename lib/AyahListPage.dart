import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AyahListPage extends StatefulWidget {
  final int surahNumber;

  AyahListPage(this.surahNumber);

  @override
  _AyahListPageState createState() => _AyahListPageState();
}

class _AyahListPageState extends State<AyahListPage> {
  List<dynamic> ayahList = [];

  @override
  void initState() {
    super.initState();
    fetchAyahList();
  }

  Future<void> fetchAyahList() async {
    final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah/${widget.surahNumber}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        setState(() {
          ayahList = data['data']['ayahs'];
        });
      } else {
        throw Exception('Failed to fetch ayah list: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch ayah list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayah List - Surah ${widget.surahNumber}'),
      ),
      body: ListView.builder(
        itemCount: ayahList.length,
        itemBuilder: (BuildContext context, int index) {
          final ayah = ayahList[index];
          final ayahNumber = ayah['numberInSurah'];
          final ayahText = ayah['text'];

          return ListTile(
            title: Text('Ayah $ayahNumber'),
            subtitle: Text(ayahText),
          );
        },
      ),
    );
  }
}
