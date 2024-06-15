import 'package:app/constants/globalvariable.dart';
import 'package:app/models/pagination.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/product/product_filter.dart';
import 'package:app/providers.dart';
import 'package:app/views/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    GlobalVariables().init(context);
    List<Product> list = List<Product>.empty(growable: true);
    // list.add(Product(
    //     productName: "Nike Shoe",
    //     category: Category(
    //       categoryName: "Sneakers",
    //       categoryImage: "/api/uploads/categories/1666187005972-sneakers.png",
    //       categoryId: "634ffefd5c8f0eeaa00aff0b",
    //     ),
    //     productShortDescription: "Nike Colorful Shoe",
    //     productPrice: 78,
    //     productSalePrice: 73,
    //     productImage: "/api/uploads/products/1666413198724-shoes1.jpg",
    //     productSKU: "123",
    //     productType: "simple",
    //     stockStatus: "IN",
    //     productId: "6353728e4cd3aa3060d180f8"));

    return Container(
      color: const Color(0xfff4f7fa),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  top: getProportionateScreenWidth(10),
                ),
                child: Text(
                  "Trending Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: _productsList(ref),
          ),
        ],
      ),
    );
  }
}

Widget _productsList(WidgetRef ref) {
  final products = ref.watch(
    homeProductProvider(
      ProductFilterModel(
        paginationModel: PaginationModel(
          page: 1,
          pageSize: 10,
        ),
      ),
    ),
  );
  return products.when(
    data: (list) {
      return _buildProductList(list!);
    },
    error: (_, __) {
      return const Center(
        child: Text("ERROR"),
      );
    },
    loading: () => CircularProgressIndicator(),
  );
}

Widget _buildProductList(List<Product> products) {
  return Container(
    height: getProportionateScreenHeight(260),
    alignment: Alignment.center,
    child: ListView.builder(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: ((context, index) {
        var data = products[index];
        return GestureDetector(
          onTap: () {},
          child: ProductCard(
            model: data,
          ),
        );
      }),
    ),
  );
}
