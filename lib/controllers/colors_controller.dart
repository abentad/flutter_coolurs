import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class ColorsController extends GetxController {
  late List<Color> _choices = [];
  late Color _correctColor;
  late String _correctColorHexString = "";
  late int _correctColorIndex;
  int _correctCounterIndicator = 0;
  int _incorrectCounterIndicator = 0;
  int _wrongAnswerCounter = 0;

  int get correctCounterIndicator => _correctCounterIndicator;
  int get incorrectCounterIndicator => _incorrectCounterIndicator;
  Color get correctColor => _correctColor;
  String get correctColorHexString => _correctColorHexString;
  List<Color> get choices => _choices;
  int get wrongAnswerCounter => _wrongAnswerCounter;

  @override
  void onInit() {
    super.onInit();
    createColor();
  }

  void setWrongAnswerCounter(int newValue) {
    _wrongAnswerCounter = newValue;
    update();
  }

  void setCorrectIndicator(int newValue) {
    _correctCounterIndicator = newValue;
    update();
  }

  void setIncorrectIndicator(int newValue) {
    _incorrectCounterIndicator = newValue;
    update();
  }

  bool isGameOver() {
    if (_incorrectCounterIndicator >= 3) {
      return true;
    }
    return false;
  }

  void createColor() {
    _choices.clear();
    for (int i = 0; i < 4; i++) {
      _correctColorIndex = Random().nextInt(4);
      late int i1 = Random().nextInt(10);
      late int i2 = Random().nextInt(10);
      late int i3 = Random().nextInt(10);
      late int i4 = Random().nextInt(10);
      late int i5 = Random().nextInt(10);
      late int i6 = Random().nextInt(10);
      if (i == _correctColorIndex) {
        _correctColorHexString = "#${i1.toString()}${i2.toString()}${i3.toString()}${i4.toString()}${i5.toString()}${i6.toString()}";
      }
      _choices.add(HexColor.fromHex("#${i1.toString()}${i2.toString()}${i3.toString()}${i4.toString()}${i5.toString()}${i6.toString()}"));
    }
    _correctColor = _choices[_correctColorIndex];
    update();
    print("Colors created." + "\ncorrect color: $_correctColorHexString");
  }
}
