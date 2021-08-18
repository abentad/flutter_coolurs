import 'package:coolurs/controllers/colors_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final ColorsController _colorsController = Get.find<ColorsController>();

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
              _colorsController.setCorrectIndicator(0);
              _colorsController.setIncorrectIndicator(0);
              _colorsController.createColor();
            },
            icon: Icon(Icons.refresh),
            color: Colors.red,
            iconSize: 26.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              GetBuilder<ColorsController>(
                builder: (controller) => Text(
                  controller.correctColorHexString == "" ? "" : controller.correctColorHexString,
                  style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<ColorsController>(
                    builder: (controller) =>
                        Text(controller.correctCounterIndicator.toString(), style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.green)),
                  ),
                  SizedBox(width: size.width * 0.2),
                  GetBuilder<ColorsController>(
                    builder: (controller) =>
                        Text(controller.incorrectCounterIndicator.toString(), style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.red)),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                height: size.height * 0.58,
                child: GetBuilder<ColorsController>(
                  builder: (controller) => ListView.builder(
                    itemCount: controller.choices.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        height: 80.0,
                        onPressed: () {
                          if (controller.correctColor == controller.choices[index]) {
                            controller.setCorrectIndicator(controller.correctCounterIndicator + 1);
                            controller.createColor();
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text('Correct', style: TextStyle(color: Colors.green)))));
                          } else {
                            controller.setIncorrectIndicator(controller.incorrectCounterIndicator + 1);
                            controller.setWrongAnswerCounter(controller.wrongAnswerCounter + 1);

                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong', style: TextStyle(color: Colors.red))));
                          }
                          if (controller.wrongAnswerCounter == 3) {
                            Get.defaultDialog(
                              title: "You Lost",
                              middleText: "Game over",
                              // backgroundColor: Colors.green,
                              // titleStyle: TextStyle(color: Colors.red),
                              // middleTextStyle: TextStyle(color: Colors.redAccent),
                              textCancel: "close",
                              textConfirm: "Retry",
                              onConfirm: () {
                                _colorsController.setCorrectIndicator(0);
                                _colorsController.setIncorrectIndicator(0);
                                _colorsController.setWrongAnswerCounter(0);
                                _colorsController.createColor();
                                Get.back();
                              },
                            );
                          }
                        },
                        color: controller.choices[index],
                      ),
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
