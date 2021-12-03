// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/pages/user.dart';
import 'package:http/http.dart' as http;
import '../colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>?> login(String id, String password) async {
    final Uri apiUrl = Uri.parse("http://192.168.18.243:3000/login");
    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': id,
          'Password': password,
        }),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData['message']);
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  var credentials = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 42,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 70),
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'Email/Reference ID',
                    labelStyle: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Email / Reference ID';
                    }
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Password';
                    }
                  },
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () async {
                    submit();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 15),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: textColor, width: 2)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      var response = await login(idController.text, passwordController.text);
      if (response!["message"] == "Login Successful") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => User(response),
          ),
        );
      } else if (response["message"].endsWith("not found.")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect Email/Reference ID"),
          ),
        );
      } else if (response["message"] == "wrong password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect Password"),
          ),
        );
      }
    }
  }
}
