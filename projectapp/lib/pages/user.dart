// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';
import 'package:projectapp/pages/pin_generate.dart';

class User extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;
  const User(this.user);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello User,',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 28,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle_rounded, size: 38),
                      onPressed: () {
                        // ignore: avoid_print
                        print(widget.user['user']['Email']);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              AreaWidget("MedBay", "16-11-2021", "10:55 am"),
              AreaWidget("Security", "20-12-2021", "11:55 pm"),
              AreaWidget("Storage", "01-05-2021", "01:50 am"),
              AreaWidget("Weapons", "12-11-2021", "03:05 pm"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: textColor,
        label: Row(
          children: const [
            Icon(Icons.pin_rounded),
            SizedBox(width: 6),
            Text('PIN'),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PinGeneration()),
          );
        },
      ),
    );
  }

  Widget AreaWidget(String title, String curDate, String curTime) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_rounded,
              size: 42,
            ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                DateTime(curDate, curTime),
              ],
            )
          ],
        ),
      ),
      children: [
        OtherDateTime(),
        OtherDateTime(),
        OtherDateTime(),
      ],
    );
  }

  Widget DateTime(String Date, String Time) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date:',
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Time:',
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(width: 60),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Date,
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              Time,
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget OtherDateTime() {
    return Padding(
      padding: const EdgeInsets.only(left: 88, top: 10),
      child: DateTime("14-11-2021", "10:55 am"),
    );
  }
}
