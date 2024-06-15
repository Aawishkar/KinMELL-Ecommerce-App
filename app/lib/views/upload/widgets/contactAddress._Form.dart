// import 'package:app/constants/globalvariable.dart';
// import 'package:app/views/upload/services/uploadModal.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';

// class ContactAddressDetails extends StatefulWidget {
//   const ContactAddressDetails({super.key});

//   @override
//   State<ContactAddressDetails> createState() => _ContactAddressDetailsState();
// }

// class _ContactAddressDetailsState extends State<ContactAddressDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UploadModal>(builder: ((context, value, child) {
//       return SizedBox(
//         width: double.infinity,
//         child: Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(1)),
//           child: Column(
//             children: [
//               SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Column(children: [
//                         SizedBox(
//                           height: GlobalVariables.screenHeight * 0.028,
//                         ),
//                         SizedBox(
//                           height: GlobalVariables.screenHeight * 0.028,
//                         ),
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               FormHelper.inputFieldWidget(
//                                 context,
//                                 'Location',
//                                 'City,Street',
//                                 (onValidate) {
//                                   if (onValidate.isEmpty) return '*Required';

//                                   return null;
//                                 },
//                                 (onSaved) {
//                                   setState(() {
//                                     value.location = onSaved.toString().trim();
//                                   });
//                                 },
//                                 initialValue: value.location ?? 'Null',
//                                 showPrefixIcon: true,
//                                 prefixIcon: const Icon(Icons.location_on_sharp),
//                                 borderRadius: 10,
//                                 contentPadding: 15,
//                                 fontSize: 14,
//                                 prefixIconPaddingLeft: 10,
//                                 prefixIconColor: Colors.black,
//                                 borderColor: Colors.grey.shade400,
//                                 hintColor: Colors.black.withOpacity(0.6),
//                                 backgroundColor: Colors.grey.shade100,
//                                 borderFocusColor: Colors.grey.shade200,
//                                 onChange: (val) {
//                                   value.location = val;
//                                 },
//                               ),
//                               SizedBox(
//                                 height: GlobalVariables.screenHeight * 0.01,
//                               ),
//                               SizedBox(
//                                 height: GlobalVariables.screenHeight * 0.01,
//                               ),
//                               // FormHelper.inputFieldWidget(
//                               //   context,
//                               //   'LandMark',
//                               //   'LandMark/Offices/Schools',
//                               //   (onValidate) {
//                               //     if (onValidate.isEmpty) {
//                               //       return '*Required';
//                               //     }

//                               //     return null;
//                               //   },
//                               //   (onSaved) {
//                               //     setState(() {
//                               //       value.landMark = onSaved.toString().trim();
//                               //     });
//                               //   },
//                               //   initialValue: value.landMark ?? 'Null',
//                               //   showPrefixIcon: true,
//                               //   prefixIcon:
//                               //       const Icon(Icons.location_city_rounded),
//                               //   borderRadius: 10,
//                               //   contentPadding: 15,
//                               //   isMultiline: true,
//                               //   multilineRows: 2,
//                               //   fontSize: 14,
//                               //   prefixIconPaddingLeft: 10,
//                               //   prefixIconColor: Colors.black,
//                               //   borderColor: Colors.grey.shade400,
//                               //   hintColor: Colors.black.withOpacity(0.6),
//                               //   backgroundColor: Colors.grey.shade100,
//                               //   borderFocusColor: Colors.grey.shade200,
//                               //   onChange: (val) {
//                               //     value.landMark = val;
//                               //   },
//                               // ),
//                               SizedBox(
//                                 height: GlobalVariables.screenHeight * 0.01,
//                               ),
//                             ]),
//                       ]),
//                       SizedBox(
//                         height: getProportionateScreenHeight(390),
//                       ),
//                       const Center(
//                         child: Text(
//                           ' Scroll to Next Step >>',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       );
//     }));
//   }

//   commonTextField(BuildContext context, String? value, String hintText,
//       String key, IconData icons, bool isMultiline, bool isPhone) {
//     return FormHelper.inputFieldWidget(
//       context,
//       key,
//       hintText,
//       (onValidate) {
//         if (onValidate.isEmpty) return '*Required';

//         return null;
//       },
//       (onSaved) {
//         setState(() {
//           value = onSaved.toString().trim();
//         });
//       },
//       initialValue: value ?? 'Null',
//       isNumeric: isPhone,
//       showPrefixIcon: true,
//       prefixIcon: Icon(icons),
//       borderRadius: 10,
//       contentPadding: 15,
//       fontSize: 14,
//       prefixIconPaddingLeft: 10,
//       prefixIconColor: Colors.black,
//       borderColor: Colors.grey.shade400,
//       hintColor: Colors.black.withOpacity(0.6),
//       backgroundColor: Colors.grey.shade100,
//       borderFocusColor: Colors.grey.shade200,
//       isMultiline: isMultiline,
//       multilineRows: isMultiline ? 5 : 1,
//       onChange: (val) {
//         value = val;
//       },
//     );
//   }
// }
