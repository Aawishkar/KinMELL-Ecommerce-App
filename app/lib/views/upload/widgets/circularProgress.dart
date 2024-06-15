import 'package:app/constants/globalvariable.dart';
import 'package:flutter/material.dart';

class StepBarIndicator {
  Padding stepBulider(String currentStep, String nextStep) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          bottom: getProportionateScreenHeight(30)),
      child: Column(
        children: [
          Text(
            currentStep,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.left,
          ),
          Text(
            nextStep,
            style:
                const TextStyle(wordSpacing: 0, letterSpacing: 0, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
