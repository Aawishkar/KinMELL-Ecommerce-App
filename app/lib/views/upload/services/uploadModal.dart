import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum Pricingtype { Negotiable, Non_Negotiable }

class UploadModal extends ChangeNotifier {
  String? productName = '';
  String? productCat = '';
  String? productStat = '';
  String? location = '';
  String? contactNumber = '';
  String? productDescription = '';
  String? productPrice = '';
  int productunit = 1;
  String? productColor = '';
  String currentStep = 'Upload Images';
  String nextStep = 'Next Step: Product Details';
  GlobalKey<FormState> step1key = GlobalKey<FormState>();
  GlobalKey<FormState> step2key = GlobalKey<FormState>();
  GlobalKey<FormState> step3key = GlobalKey<FormState>();

  //images data
  final ImagePicker imgpicker = ImagePicker();
  List<File>? imagefiles = [];

  //DropDown List
  static List<dynamic> productCategories = [];
  static List<dynamic> productCondition = [];
  static List<dynamic> productColors = [];
  Pricingtype? pricingtype;

  //StepsInidicator
  int activeIndex = 0;
  int totalSteps = 3;
  bool isImageValid = true;

  changesStep(index) {
    switch (index) {
      case 0:
        currentStep = 'Upload Images';
        nextStep = 'Next Step: Product Details';
        if (imagefiles!.isNotEmpty) {
          isImageValid = true;
        } else {
          isImageValid = false;
        }
        break;
      case 1:
        currentStep = 'Product Details';
        nextStep = 'Next Step: Pricing & Contact';
        break;
      case 2:
        currentStep = ' Pricing & Contact';
        nextStep = '';
        break;
      default:
    }
    //validateAndSave(index);
    notifyListeners();
  }

  bool validateAndSave(int index) {
    switch (index) {
      case 0:
        if (step1key.currentState!.validate() && imagefiles!.isNotEmpty) {
          step1key.currentState!.save();

          return true;
        } else {
          return false;
        }
      case 1:
        if (step2key.currentState!.validate() &&
            productStat!.isNotEmpty &&
            productCat!.isNotEmpty &&
            productColor!.isNotEmpty) {
          step2key.currentState!.save();
          return true;
        } else {
          return false;
        }
      case 2:
        if (step3key.currentState!.validate()) {
          step3key.currentState!.save();
          return true;
        } else {
          return false;
        }
      default:
        return false;
    }
  }
}
