// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';
import 'package:projectapp/pages/pin_generate.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: Text('abc'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: textColor,
        label: Row(
          children: const [
            Icon(Icons.pin_rounded),
            SizedBox(
              width: 10.0,
            ),
            Text('PIN'),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PinGeneration(),
            ),
          );
        },
      ),
    );
  }
}
