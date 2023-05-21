import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AyahListPage.dart';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<dynamic> surahList = [];
  List<dynamic> filteredSurahList = [];

  @override
  void initState() {
    super.initState();
    fetchSurahList();
  }

  Future<void> fetchSurahList() async {
    final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        setState(() {
          surahList = data['data'];
          filteredSurahList = surahList;
        });
      } else {
        throw Exception('Failed to fetch surah list: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch surah list');
    }
  }

  void filterSurahList(String query) {
    setState(() {
      filteredSurahList = surahList
          .where((surah) => surah['englishName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                filterSurahList(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSurahList.length,
              itemBuilder: (BuildContext context, int index) {
                final surah = filteredSurahList[index];
                final surahNumber = surah['number'];
                final surahName = surah['name'];
                final surahEnglishName = surah['englishName'];

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Surah $surahNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surahName,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          surahEnglishName,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AyahListPage(surahNumber),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
