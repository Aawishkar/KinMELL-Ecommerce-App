// ignore_for_file: prefer_const_constructors

import 'package:app/models/product/product.dart';
import 'package:app/views/detail/app_buttons.dart';
import 'package:app/views/home/screens/homepage.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details-screen';

  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  void movetoHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
  }

  int gottenStars = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 70,
              right: 70,
              child: Container(
                width: double.maxFinite,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bag.png"),
                        fit: BoxFit.contain)),
              ),
            ),
            Positioned(
                left: 10,
                top: 30,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => movetoHome(),
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      color: Colors.black,
                    )
                  ],
                )),
            Positioned(
              top: 350,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                height: 700,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 202, 209),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Bag",
                          style: TextStyle(
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$200",
                          style: TextStyle(
                            color: Color.fromARGB(255, 176, 0, 0),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 244, 74, 74),
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "28 kilo, Dhulikhel",
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 65, 65),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: gottenStars > index
                                  ? Colors.orange[600]
                                  : Colors.black,
                            );
                          }),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(4.0)",
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 65, 65),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Category:",
                          style: TextStyle(
                            color: Color.fromARGB(255, 244, 74, 74),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Bags",
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 65, 65),
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "This handy tool helps you create dummy text for all your layout needs. We are gradually adding new functionality and we welcome your suggestions and feedback.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Seller Details",
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Name:Aawishkar Tiwari",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Contact:9864420020",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // AppButtons(
                    //     size: 60,
                    //     color: Colors.black,
                    //     backgroundColor: Colors.white,
                    //     bordercolor: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20, bottom: 18),
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 176, 0, 0),
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,bottom: 15),
                      child: SizedBox(
                        width: 220,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          // ignore: sort_child_properties_last
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 176, 0, 0),
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
