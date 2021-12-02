// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';
import 'package:projectapp/pages/pin_generate.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;
  const User(this.user);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List loc = [];
  String ldt = "";
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    loc.clear();
    _getAccessed(widget.user['user']['Email']);
    super.initState();
  }

  Future<void> _getAccessed(String email) async {
    List temp = [];
    final Uri apiUrl = Uri.parse("http://192.168.0.104:3000/user/getloc");
    var response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': email,
        }));

    var s = response.body.split("\"");
    for (var i = 0; i < s.length; i++) {
      if (s[i].contains(',') || s[i].contains('[') || s[i].contains(']')) {
        continue;
      } else if (temp.contains(s[i])) {
        continue;
      } else {
        temp.add(s[i]);
      }
    }
    setState(() {
      loc = temp;
    });
  }

  Future<String> _lastDate(String email, String pl) async {
    String temp = "http://192.168.0.104:3000/user/getAccessed/" + pl;
    // ignore: avoid_print
    final Uri apiUrl = Uri.parse(temp);
    var response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': email,
        }));

    final List responseData = json.decode(response.body);
    // ignore: avoid_print
    setState(() {
      ldt = responseData[responseData.length - 1]["dateandtime"];
    });
    return ldt.toString();
  }

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
                      onPressed: () async {
                        _lastDate(widget.user['user']['Email'], "serv");
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              for (int i = 0; i < loc.length; i++)
                AreaWidget(loc[i], "123", "abc"),

              //   AreaWidget(loc[pos], "16-11-2021", "10:55 am"),
              // AreaWidget("Security", "20-12-2021", "11:55 pm"),
              // AreaWidget("Storage", "01-05-2021", "01:50 am"),
              // AreaWidget("Weapons", "12-11-2021", "03:05 pm"),
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
                DateAndTime(curDate, curTime),
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

  Widget DateAndTime(String date, String time) {
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
              date,
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              time,
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
      child: DateAndTime("14-11-2021", "10:55 am"),
    );
  }
}
