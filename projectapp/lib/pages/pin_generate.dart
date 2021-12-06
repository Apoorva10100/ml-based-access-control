import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';
import 'package:http/http.dart' as http;

class PinGeneration extends StatefulWidget {
  final email;
  // ignore: use_key_in_widget_constructors
  const PinGeneration(this.email);

  @override
  _PinGenerationState createState() => _PinGenerationState();
}

class _PinGenerationState extends State<PinGeneration> {
  var code = "";
  String dropdownValue = '4';
  var rng = Random();

  Future<void> storePin(String pin) async {
    final Uri apiUrl = Uri.parse("http://192.168.18.243:3000/user/saveotp");
    try {
      final http.Response response = await http.patch(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'Email': widget.email, 'Otp': pin}),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Try again."),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200.0),
            Text(
              "Your PIN is:",
              style: TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              code.toString(),
              style: TextStyle(
                letterSpacing: 20,
                fontSize: 80,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        onPressed: () {
          setState(() {
            getPin();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void getPin() {
    var pin = "";
    setState(() {
      for (var i = 0; i < 4; i++) {
        pin = pin + rng.nextInt(9).toString();
      }
      code = pin;
      storePin(code);
    });
  }
}
