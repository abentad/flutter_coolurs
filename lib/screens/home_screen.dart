import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Color> choices = [];
  late Color correctColor;
  late String correctColorHexString = "";
  late int correctColorIndex;
  int correctCounter = 0;
  int incorrectCounter = 0;

  void createColor() {
    setState(() {
      choices.clear();
    });
    for (int i = 0; i < 4; i++) {
      setState(() {
        correctColorIndex = Random().nextInt(4);
      });
      late int i1 = Random().nextInt(10);
      late int i2 = Random().nextInt(10);
      late int i3 = Random().nextInt(10);
      late int i4 = Random().nextInt(10);
      late int i5 = Random().nextInt(10);
      late int i6 = Random().nextInt(10);
      if (i == correctColorIndex) {
        setState(() {
          correctColorHexString = "#${i1.toString()}${i2.toString()}${i3.toString()}${i4.toString()}${i5.toString()}${i6.toString()}";
        });
      }
      setState(() {
        choices.add(HexColor.fromHex("#${i1.toString()}${i2.toString()}${i3.toString()}${i4.toString()}${i5.toString()}${i6.toString()}"));
      });
    }
    setState(() {
      correctColor = choices[correctColorIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    createColor();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text("Coolurs", style: TextStyle(color: Colors.black, fontSize: 24.0)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                correctCounter = 0;
                incorrectCounter = 0;
              });
              createColor();
            },
            icon: Icon(Icons.refresh),
            color: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
        child: choices.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Text(correctColorHexString == "" ? "" : correctColorHexString, style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(correctCounter.toString(), style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.green)),
                        SizedBox(width: size.width * 0.2),
                        Text(incorrectCounter.toString(), style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      height: size.height * 0.5,
                      child: ListView.builder(
                        itemCount: choices.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 70.0,
                            onPressed: () {
                              if (HexColor.fromHex(correctColorHexString) == choices[index]) {
                                // ignore: unnecessary_statements
                                setState(() {
                                  correctCounter++;
                                });
                                createColor();
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text('Correct', style: TextStyle(color: Colors.green)))));
                              } else {
                                setState(() {
                                  incorrectCounter++;
                                });
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong', style: TextStyle(color: Colors.red))));
                              }
                            },
                            color: choices[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
