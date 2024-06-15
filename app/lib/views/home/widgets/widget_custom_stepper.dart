import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper(
      {required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      required this.iconSize,
      required this.onChanged,
      required this.value,
      Key? key})
      : super(key: key);

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 18, 18),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
            ),
            onDoubleTap: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;

                widget.onChanged(widget.value);
              });
            },
          ),
          SizedBox(
            width: widget.iconSize,
            child: Text(
              widget.value.toString(),
              style: TextStyle(
                fontSize: widget.iconSize * 0.7,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
            onDoubleTap: () {
              setState(() {
                widget.value = widget.value == widget.upperLimit
                    ? widget.upperLimit
                    : widget.value += widget.stepValue;

                widget.onChanged(widget.value);
              });
            },
          ),
        ],
      ),
    );
  }
}
