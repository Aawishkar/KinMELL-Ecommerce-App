import 'package:app/models/pagination.dart';
import 'package:app/models/product/product_filter.dart';
import 'package:riverpod/riverpod.dart';

class ProductsFilterNotifier extends StateNotifier<ProductFilterModel> {
  ProductsFilterNotifier()
      : super(
          ProductFilterModel(
            paginationModel: PaginationModel(
              page: 0,
              pageSize: 10,
            ),
          ),
        );

  void setProductFilter(ProductFilterModel model) {
    state = model;
  }
}
