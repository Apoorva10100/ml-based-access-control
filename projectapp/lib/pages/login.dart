// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:projectapp/pages/user.dart';

import '../colors.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var Credentials = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 38,
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
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Email / Reference ID';
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      letterSpacing: 1,
                      fontSize: 16,
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
                  onPressed: submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 15),
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

  void submit() {
    if (_formKey.currentState!.validate()) {
      print(idController.text);
      print(passwordController.text);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => user(),
        ),
      );
    }

    // final FormState formState = _formKey.currentState;
    // _formKey.currentState.save();
    // if (formState.validate()) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => user(),
    //     ),
    //   );
    // }
  }
}
