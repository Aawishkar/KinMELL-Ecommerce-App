import 'package:app/config/config.dart';
import 'package:app/views/upload/services/uploadModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../../constants/globalvariable.dart';

class ProductPricingDetails extends StatefulWidget {
  const ProductPricingDetails({super.key});

  @override
  State<ProductPricingDetails> createState() => _ProductPricingDetailsState();
}

class _ProductPricingDetailsState extends State<ProductPricingDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadModal>(builder: ((context, modal, child) {
      return Column(
        children: [
          SizedBox(
            height: GlobalVariables.screenHeight * 0.028,
          ),
          FormHelper.inputFieldWidget(
            context,
            'price',
            'Product Price',
            (onValidate) {
              if (onValidate.isEmpty) return '*Required';

              return null;
            },
            (onSaved) {
              setState(() {
                modal.productPrice = onSaved.toString().trim();
              });
            },
            initialValue: modal.productPrice ?? 'Null',
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.monetization_on_rounded),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            prefixIconColor: Colors.black,
            borderColor: Colors.grey.shade400,
            hintColor: Colors.black.withOpacity(0.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
            isNumeric: true,
            onChange: (val) {
              modal.productPrice = val;
            },
          ),
          SizedBox(
            height: GlobalVariables.screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(15),
                        top: getProportionateScreenHeight(4)),
                    child: Row(
                      children: const [
                        Text(
                          'Pricing Type',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Radio(
                                    value: Pricingtype.Negotiable,
                                    groupValue: modal.pricingtype,
                                    onChanged: (Pricingtype? val) {
                                      setState(() {
                                        modal.pricingtype = val;
                                      });
                                    }),
                                const Expanded(
                                  child: Text('Negotiable'),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Radio(
                                    value: Pricingtype.Non_Negotiable,
                                    groupValue: modal.pricingtype,
                                    onChanged: (Pricingtype? val) {
                                      setState(() {
                                        modal.pricingtype = val;
                                      });
                                    }),
                                const Expanded(
                                  child: Text('Non-Negotiable'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: GlobalVariables.screenHeight * 0.02,
          ),
          FormHelper.inputFieldWidget(
            context,
            'Contact Number',
            'Contact/Phone',
            (onValidate) {
              if (onValidate.isEmpty) return '*Required';

              return null;
            },
            (onSaved) {
              modal.contactNumber = onSaved.toString().trim();
            },
            initialValue: modal.contactNumber ?? 'Null',
            showPrefixIcon: true,
            isNumeric: true,
            prefixIcon: const Icon(Icons.phone),
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
              modal.contactNumber = val;
            },
          ),
        ],
      );
    }));
  }
}
