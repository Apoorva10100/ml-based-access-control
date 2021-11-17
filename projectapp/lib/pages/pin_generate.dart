import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectapp/colors.dart';

class PinGeneration extends StatefulWidget {
  const PinGeneration({Key? key}) : super(key: key);

  @override
  _PinGenerationState createState() => _PinGenerationState();
}

class _PinGenerationState extends State<PinGeneration> {
  var code = "";
  var rng = Random();
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
    });
  }
}
