import 'package:flutter/material.dart';

class DetailProfilePage extends StatefulWidget {
  @override
  _DetailProfilePageState createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('images/1651600014143.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                "Nama : Alfian Saputra",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text(
                "NIM : 123200007",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Profil",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 300,
                height: 2,
                color: Colors.blue[900],
              ),
              SizedBox(height: 16),
              Text(
                "Kelas : IF-B",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Tempat Lahir : Raha, Sulawesi Tenggara",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Tanggal Lahir : 01 Juni 2002",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Cita-cita : Menjadi ahli di bidang Teknologi",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Kesan : Tugasnya bikin naik asam lambung",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Pesan : Tingkatkan tugasnya lebih di persulit buat junior pak :)",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
