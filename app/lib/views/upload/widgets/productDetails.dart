import 'package:app/api/api_service.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/utils/keyboard.dart';
import 'package:app/views/upload/services/uploadModal.dart';
import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:app/models/pagination.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    UploadModal.productCategories.add({"val": "1", "label": "Electronics"});
    UploadModal.productCategories.add({"val": "2", "label": "Notes"});

    UploadModal.productCondition.add({"val": "1", "label": "New"});
    UploadModal.productCondition.add({"val": "2", "label": "Used"});
    UploadModal.productCondition
        .add({"val": "3", "label": "Damaged(Can be Repaired)"});
    UploadModal.productColors.add({"val": "1", "label": "Red"});
    UploadModal.productColors.add({"val": "2", "label": "Black"});
    UploadModal.productColors.add({"val": "3", "label": "White"});
    UploadModal.productColors.add({"val": "4", "label": "Blue"});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    UploadModal.productCategories.clear();
    UploadModal.productCondition.clear();
    UploadModal.productColors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadModal>(builder: ((context, value, child) {
      return SizedBox(
        child: Form(
          key: value.step2key,
          child: GestureDetector(
            onTap: (() {
              KeyboardUtil.hideKeyboard(context);
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: GlobalVariables.screenHeight * 0.028),
                FormHelper.dropDownWidget(
                  context,
                  'Select Category *',
                  value.productCat,
                  UploadModal.productCategories,
                  (onValidate) {
                    if (onValidate!.isEmpty) {
                      return '*Required';
                    }
                    return '*Required';
                  },
                  (onChanged) {
                    value.productCat = onChanged!;
                  },
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.category_sharp),
                  prefixIconPaddingLeft: 10,
                  prefixIconColor: Colors.black,
                  borderRadius: 10,
                  hintFontSize: 14,
                  hintColor: Colors.black.withOpacity(0.6),
                  contentPadding: 15,
                  borderColor: Colors.grey.shade400,
                  borderFocusColor: Colors.grey.shade200,
                  optionValue: "val",
                  optionLabel: "label",
                ),
                SizedBox(
                  height: GlobalVariables.screenHeight * 0.02,
                ),
                FormHelper.dropDownWidget(
                  context,
                  'Condition *',
                  value.productStat,
                  UploadModal.productCondition,
                  (onValidate) {
                    if (onValidate!.isEmpty) {
                      return '*Required';
                    }
                    return '*Required';
                  },
                  (onChanged) {
                    value.productStat = onChanged.toString().trim();
                  },
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.category_sharp),
                  prefixIconPaddingLeft: 10,
                  prefixIconColor: Colors.black,
                  borderRadius: 10,
                  hintFontSize: 14,
                  hintColor: Colors.black.withOpacity(0.6),
                  contentPadding: 15,
                  borderColor: Colors.grey.shade400,
                  borderFocusColor: Colors.grey.shade200,
                  optionValue: "val",
                  optionLabel: "label",
                ),
                SizedBox(
                  height: GlobalVariables.screenHeight * 0.02,
                ),
                FormHelper.inputFieldWidget(
                  context,
                  'Location',
                  'Location *',
                  (onValidate) {
                    if (onValidate.isEmpty) return '*Required';

                    return null;
                  },
                  (onSaved) {
                    value.location = onSaved.toString().trim();
                  },
                  initialValue: value.location ?? 'Null',
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.gps_fixed_sharp),
                  borderRadius: 10,
                  contentPadding: 15,
                  fontSize: 14,
                  prefixIconPaddingLeft: 10,
                  prefixIconColor: Colors.black,
                  borderColor: Colors.grey.shade400,
                  hintColor: Colors.black.withOpacity(0.6),
                  backgroundColor: Colors.grey.shade100,
                  borderFocusColor: Colors.grey.shade200,
                  onChange: (val) {
                    value.location = val;
                  },
                ),
                SizedBox(
                  height: GlobalVariables.screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: getProportionateScreenHeight(50),
                    width: GlobalVariables.screenWidth,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   color: Colors.grey.shade200,
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Product Unit',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Slide to change product unit',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          NumberPicker(
                              textStyle: const TextStyle(color: Colors.black),
                              itemHeight: getProportionateScreenHeight(20),
                              itemWidth: getProportionateScreenWidth(100),
                              itemCount: 1,
                              selectedTextStyle:
                                  const TextStyle(color: Colors.black),
                              axis: Axis.horizontal,
                              minValue: 1,
                              maxValue: 50,
                              value: value.productunit,
                              onChanged: ((unit) {
                                value.productunit = unit;
                                setState(() {});
                              }))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: GlobalVariables.screenHeight * 0.028),
                FormHelper.dropDownWidget(
                  context,
                  'Select Color *',
                  value.productColor,
                  UploadModal.productColors,
                  (onValidate) {
                    if (onValidate!.isEmpty) {
                      return '*Required';
                    }
                    return '*Required';
                  },
                  (onChanged) {
                    value.productColor = onChanged!;
                  },
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.category_sharp),
                  prefixIconPaddingLeft: 10,
                  prefixIconColor: Colors.black,
                  borderRadius: 10,
                  hintFontSize: 14,
                  hintColor: Colors.black.withOpacity(0.6),
                  contentPadding: 15,
                  borderColor: Colors.grey.shade400,
                  borderFocusColor: Colors.grey.shade200,
                  optionValue: "val",
                  optionLabel: "label",
                ),
                SizedBox(
                  height: GlobalVariables.screenHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                  },
                  child: FormHelper.inputFieldWidget(
                    context,
                    'Description',
                    '\n\n\n      Product Description *',
                    (onValidate) {
                      if (onValidate.isEmpty) return '*Required';

                      return null;
                    },
                    (onSaved) {
                      value.productDescription = onSaved.toString().trim();
                    },
                    initialValue: value.productDescription ?? 'Null',
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.description_rounded),
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 14,
                    isMultiline: true,
                    multilineRows: 8,
                    prefixIconPaddingLeft: 10,
                    prefixIconColor: Colors.black,
                    borderColor: Colors.grey.shade400,
                    hintColor: Colors.black.withOpacity(0.6),
                    backgroundColor: Colors.grey.shade100,
                    borderFocusColor: Colors.grey.shade200,
                    onChange: (val) {
                      value.productColor = val;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
