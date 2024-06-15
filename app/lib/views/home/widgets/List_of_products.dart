import 'package:app/constants/globalvariable.dart';
import 'package:app/models/pagination.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/product/product_filter.dart';
import 'package:app/providers.dart';
import 'package:app/views/home/widgets/ProductCard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfProducts extends ConsumerWidget {
  const ListOfProducts({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    GlobalVariables().init(context);
    List<Product> list = List<Product>.empty(growable: true);

    return Container(
      color: const Color(0xfff4f7fa),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: _productsList(ref),
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
    height: getProportionateScreenHeight(270),
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
