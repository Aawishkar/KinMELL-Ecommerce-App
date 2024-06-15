import 'package:app/api/api_service.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/views/upload/services/uploadModal.dart';
import 'package:app/views/upload/widgets/productDetails.dart';
import 'package:app/views/upload/widgets/productImages.dart';
import 'package:app/views/upload/widgets/productPricing_Filed.dart';
import 'package:app/views/upload/widgets/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class UploadScreen extends StatefulWidget {
  static const String routeName = '/uploadpage-screen';
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  moveStepBack(UploadModal value) {
    if (value.activeIndex == 0) {
      Navigator.pushNamed(context, '/homepage-screen');
    } else {
      value.activeIndex--;
      value.changesStep(value.activeIndex);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalVariables().init(context);
    return ChangeNotifierProvider(
      create: (context) => UploadModal(),
      child: Consumer<UploadModal>(builder: ((context, value, child) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    moveStepBack(value);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              title: const Center(child: Text('Upload Product')),
            ),
            resizeToAvoidBottomInset: false,
            body: Align(alignment: Alignment.topLeft, child: Steps()),
          ),
        );
      })),
    );
  }
}

class Steps extends StatefulWidget {
  Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  APIService api = APIService();
  List<Widget> pageList = [
    const ProductImages(),
    const ProductDetails(),
    const ProductPricingDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadModal>(builder: ((context, value, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(8.0),
                right: getProportionateScreenWidth(10.0),
                left: getProportionateScreenWidth(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircularPercentIndicator(
                      animation: true,
                      percent: (value.activeIndex + 1) / value.totalSteps,
                      circularStrokeCap: CircularStrokeCap.butt,
                      radius: 40.0,
                      lineWidth: 3.0,
                      center: Text(
                        '${value.activeIndex + 1} of 3',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: Colors.black,
                    ),
                    StepBarIndicator()
                        .stepBulider(value.currentStep, value.nextStep)
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Container(
                  height: getProportionateScreenHeight(2),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(1.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: GlobalVariables.screenHeight * 0.7580,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                pageList[value.activeIndex],
                SizedBox(
                  height: getProportionateScreenHeight(290),
                ),
                Positioned(
                  top: getProportionateScreenHeight(525),
                  right: getProportionateScreenWidth(110),
                  child: FormHelper.submitButton(
                    value.activeIndex == 2 ? 'Upload Product' : ' Next ',
                    () {
                      value.changesStep(value.activeIndex);

                      if (value.validateAndSave(value.activeIndex)) {
                        value.activeIndex++;

                        value.changesStep(value.activeIndex);
                        setState(() {});
                      }
                    },
                    btnColor: Colors.deepPurple,
                    borderColor: Colors.white,
                    borderRadius: 20,
                    txtColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }));
  }
}
