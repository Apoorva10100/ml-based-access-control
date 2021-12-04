// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';
import 'package:projectapp/pages/pin_generate.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  final user;
  const User(this.user);

  @override
  _UserState createState() => _UserState(user);
}

class _UserState extends State<User> {
  final user;
  _UserState(this.user);

  List responseData = [];
  List locations = [];
  List date = [];
  List time = [];
  late String curDate;
  late String curTime;

  Future<List> _getLocations(String email) async {
    final Uri apiUrl = Uri.parse("http://192.168.18.243:3000/user/getloc");
    var response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
      }),
    );
    responseData = json.decode(response.body);
    locations = responseData.toSet().toList();
  }

  @override
  void initState() {
    // _getLocations(user['user']['Email']);
    super.initState();
  }

  Future<List> _Date(String email, String loc) async {
    String temp = "http://192.168.18.243:3000/user/getAccessed/" + loc;
    final Uri apiUrl = Uri.parse(temp);
    var response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': email,
        }));

    final List responseData = json.decode(response.body);
    curDate =
        responseData[responseData.length - 1]['dateandtime'].split(' ')[0];
    curTime =
        responseData[responseData.length - 1]['dateandtime'].split(' ')[1];
    return responseData;
  }

  Future<List> _Date1(String email, String loc) async {
    String temp = "http://192.168.18.243:3000/user/getAccessed/" + loc;
    final Uri apiUrl = Uri.parse(temp);
    var response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': email,
        }));

    date = [];
    time = [];
    final List responseData = json.decode(response.body);
    for (int i = 0; i < responseData.length; i++) {
      date.add(responseData[i]['dateandtime'].split(' ')[0]);
      time.add(responseData[i]['dateandtime'].split(' ')[1]);
    }
    print("First***********************");
    print(loc);
    print(date[(date.length - 1)]);
    print(time[(time.length - 1)]);
    return responseData;
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
                      'Hello ' + user['user']['Employee_Name'],
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 28,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle_rounded, size: 38),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              AreaWidget(),
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
            MaterialPageRoute(
                builder: (context) =>
                    PinGeneration(widget.user['user']['Email'])),
          );
        },
      ),
    );
  }

  Widget AreaWidget() {
    return FutureBuilder(
      future: _getLocations(user['user']['Email']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ExpansionTile(
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
                                locations[index],
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              DateAndTime(locations[index]),
                            ],
                          )
                        ],
                      ),
                    ),
                    children: [
                      OtherDateTime(locations[index]),
                    ],
                  )
                ],
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget DateAndTime(String location) {
    return FutureBuilder(
      future: _Date(user['user']['Email'], location),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
                    curDate,
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    curTime,
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
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget OtherDateTime(String location) {
    return FutureBuilder(
      future: _Date1(user['user']['Email'], location),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // List reversedDate = List.from(date.reversed);
          // List reversedTime = List.from(time.reversed);
          // reversedDate = reversedDate.sublist(1,reversedDate.length);
          // reversedTime = reversedTime.sublist(1,reversedTime.length);
          return ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: date.length - 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 88, top: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                          date[index],
                          // reversedDate[index],
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          time[index],
                          //reversedTime[index],
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
