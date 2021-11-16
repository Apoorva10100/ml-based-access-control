// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';

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
          // child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Icon(
                    Icons.account_circle_rounded,
                    size: 38,
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            
            Item3(),
            Item3(),
            Item3(),
          ],
        ),
      ),
      //),
    );
  }

  Widget Item3() {
    return Container(
      decoration: BoxDecoration(),
      child: ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical:10 ),
          child: Row(
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 42,
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Area 1',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
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
                            '02-11-2021',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '18:49 am',
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
                ],
              )
            ],
          ),
        ),
        children: [
          Item4(),
          Item4()
         
        ],
      ),
    );
  }

Widget Item4(){
  return Padding(
    padding: const EdgeInsets.only(left:90, top:10),
    child: Row(
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
                          '02-11-2021',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '18:49 am',
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
}


}

