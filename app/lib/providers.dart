import 'package:app/api/api_service.dart';
import 'package:app/application/notifier/product_filter_notifier.dart';
import 'package:app/application/notifier/products_notifier.dart';
import 'package:app/application/state/product_state.dart';
import 'package:app/models/categories/category.dart';
import 'package:app/models/pagination.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/product/product_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getProducts(productFilterModel);
  },
);

final productsFilterProvider =
    StateNotifierProvider<ProductsFilterNotifier, ProductFilterModel>(
  (ref) => ProductsFilterNotifier(),
);

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(
    ref.watch(apiService),
    ref.watch(productsFilterProvider),
  ),
);

final productDetailsProvider = FutureProvider.family<Product?, String>(
  (ref, productId) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProductDetails(productId);
  },
);

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProducts(productFilterModel);
});
