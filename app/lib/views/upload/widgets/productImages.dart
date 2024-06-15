import 'dart:io';

import 'package:app/constants/globalvariable.dart';
import 'package:app/utils/keyboard.dart';
import 'package:app/views/upload/services/uploadModal.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key});

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  GlobalKey<FormState> productDetailsFormKey = GlobalKey<FormState>();

  selectImages(UploadModal value) async {
    try {
      var pickedimages = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (pickedimages != null &&
          pickedimages.files.isNotEmpty &&
          pickedimages.files.length <= 6) {
        for (int i = 0; i < pickedimages.files.length; i++) {
          value.imagefiles!.add(File(pickedimages.files[i].path!));
        }
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return value.imagefiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadModal>(builder: ((context, value, child) {
      return SizedBox(
        child: GestureDetector(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: GlobalVariables.screenHeight * 0.028),
              Form(
                key: value.step1key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormHelper.inputFieldWidget(
                      context,
                      'Name',
                      'Product Title',
                      (onValidate) {
                        if (onValidate.isEmpty) return '*Required';

                        return null;
                      },
                      (onSaved) {
                        value.productName = onSaved.toString().trim();
                      },
                      initialValue: value.productName ?? 'Null',
                      showPrefixIcon: true,
                      prefixIcon: const Icon(Icons.abc),
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
                        value.productName = val;
                      },
                    ),
                    SizedBox(
                      height: GlobalVariables.screenHeight * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DottedBorder(
                            strokeWidth: 1.5,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            child: value.imagefiles!.isNotEmpty
                                ? Column(
                                    children: [
                                      GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: value.imagefiles!.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Stack(children: [
                                              Image.file(
                                                  File(value
                                                      .imagefiles![index].path),
                                                  fit: BoxFit.fill,
                                                  width:
                                                      getProportionateScreenWidth(
                                                          110),
                                                  height:
                                                      getProportionateScreenWidth(
                                                          110)),
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: InkWell(
                                                  child: const Icon(
                                                    Icons.remove_circle,
                                                    size: 20,
                                                    color: Colors.red,
                                                  ),
                                                  onTap: () {
                                                    value.imagefiles!
                                                        .removeAt(index);

                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ]);
                                          }),
                                      value.imagefiles!.length < 6
                                          ? SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                              child: GestureDetector(
                                                onTap: (() {
                                                  selectImages(value);
                                                }),
                                                child: Card(
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      size:
                                                          getProportionateScreenHeight(
                                                              50),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      selectImages(value);
                                    },
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(100),
                                      width: getProportionateScreenWidth(100),
                                      child: Card(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size:
                                                  getProportionateScreenHeight(
                                                      50),
                                            ),
                                            const Text('Add Images'),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                          ),
                          const Text(
                            '*Maximum of Six Images is allowed',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          value.isImageValid
                              ? Container()
                              : const Text(
                                  '*At least one image required',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const Center(
              //   child: Text(
              //     ' Scroll to Next Step >>',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        ),
      );
    }));
  }

  Widget buildGridView(UploadModal value) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(value.imagefiles!.length, (index) {
        if (value.imagefiles!.isNotEmpty) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  File(value.imagefiles![index].path),
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      value.imagefiles![index].delete();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
              child: DottedBorder(
            radius: const Radius.circular(5),
            color: Colors.black,
            strokeWidth: 3,
            dashPattern: const [8, 2],
            child: GestureDetector(
              onTap: () {
                selectImages(value);
              },
              child: SizedBox(
                height: getProportionateScreenHeight(80),
                width: getProportionateScreenWidth(80),
                child: Center(
                    child: Icon(
                  Icons.add,
                  size: getProportionateScreenHeight(50),
                )),
              ),
            ),
          ));
        }
      }),
    );
  }
}
