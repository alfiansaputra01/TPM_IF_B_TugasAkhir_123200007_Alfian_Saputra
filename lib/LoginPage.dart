import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ApiHelper.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool isLoginSuccess = true;
  bool isUsername = true;
  bool isPassword = true;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  void _loginNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "username": usernameController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "Login success!");

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return HomePage();
            }),
          );
        } else {
          Fluttertoast.showToast(
              msg: "Login failed, please write the correct username or password...");
        }
      }
    } catch (e) {
      print("error = " + e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('images/alquran-logo-free-vector.jpg'),
                radius: 50,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: usernameController,
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: passwordController,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: (isLoginSuccess) ? Colors.blue : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    usernameController.text = username;
                    passwordController.text = password;
                    print(usernameController.text);
                    if (usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      _loginNow();
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text("Tidak Boleh Ada Yang Kosong"),
                        backgroundColor: Colors.redAccent,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return signup();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
