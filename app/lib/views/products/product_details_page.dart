import 'package:app/api/api_service.dart';
import 'package:app/config/config.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/models/product/product.dart';
import 'package:app/providers.dart';
import 'package:app/views/home/widgets/widget_col_exp.dart';
import 'package:app/views/home/widgets/widget_custom_stepper.dart';
import 'package:app/views/products/widget_related_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  static const String routeName = '/product-details-page-screen';
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  String productId = "";
  int gottenStars = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: _productDetails(ref),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    productId = arguments["productId"];

    super.didChangeDependencies();
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));

    return details.when(
      data: (model) {
        return Column(
          children: [
            _productDetailsUI(model!),
            RelatedProductsWidget(model.relatedProducts!),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
      error: (_, __) => const Center(
        child: Text("Error"),
      ),
      loading: (() => const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }

  Widget _productDetailsUI(Product model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned(
            left: getProportionateScreenWidth(70),
            right: getProportionateScreenWidth(70),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: 300,
              child: Image.network(
                model.fullImagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenWidth(5),
          ),
          Positioned(
            top: getProportionateScreenHeight(800),
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: 700,
              decoration: const BoxDecoration(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            model.productName,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 49, 49, 49),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            model.productShortDescription,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 49, 49, 49),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${Config.currency}${model.productPrice.toString()}",
                            style: TextStyle(
                              color: model.calculateDiscount > 0
                                  ? Colors.red
                                  : Colors.deepPurple,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              decoration: model.productSalePrice > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          Text(
                            (model.calculateDiscount > 0)
                                ? "${Config.currency}${model.productSalePrice.toString()}"
                                : "",
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 244, 74, 74),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "28 kilo, Dhulikhel",
                        style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "(4.0)",
                        style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Category:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 244, 74, 74),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.category.categoryName,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.productDescription,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 68, 65, 65),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Seller Details",
                    style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Name:Aawishkar Tiwari",
                    style: TextStyle(
                      color: Color.fromARGB(255, 68, 65, 65),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "Contact:9864420020",
                    style: TextStyle(
                      color: Color.fromARGB(255, 68, 65, 65),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 15, bottom: 18),
                        child: SizedBox(
                          width: getProportionateScreenWidth(80),
                          height: getProportionateScreenHeight(50),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.favorite,
                              size: 25,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 176, 0, 0),
                              onPrimary: Colors.white,
                              shadowColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: CustomStepper(
                          iconSize: 22.0,
                          lowerLimit: 1,
                          upperLimit: 20,
                          stepValue: 1,
                          value: 1,
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 15),
                        child: SizedBox(
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(50),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_basket,
                              color: Colors.white,
                            ),
                            // ignore: sort_child_properties_last
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
