import 'package:fake_store/helper/app_exception.dart';
import 'package:fake_store/service/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/urls.dart';
import '../../helper/app_error.dart';
import '../../model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<ProductModel> productLists = [];
  List<ProductModel> cartLists = [];
  List<ProductModel> searchResult = [];
  UserError userError = UserError();

  bool isLoading = true;
  bool isSearching = false;
  bool isFailer = false;

  HomeViewModel() {
    getAllProducts();
  }

//Calculate total
  double get totalPrice => cartLists.fold(
      0, (previousValue, element) => previousValue + element.price!);

  setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  setFailer(bool fail) {
    isFailer = fail;
    notifyListeners();
  }

  setSearch(bool searching) {
    isSearching = searching;
    notifyListeners();
  }

  getAllProducts() async {
    var product = await BaseApi.fetch(PRODUCTS);
    try {
      if (product is Success) {
        Iterable list = product.response as List;
        productLists = list.map((e) => ProductModel.fromJson(e)).toList();
        setLoading(false);
      }
      if (product is Failure) {
        userError = UserError(
            code: product.code, message: product.errorResponse.toString());
        setFailer(true);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void search(String keyword) {
    setSearch(true);
    searchResult.clear();
    for (var ProductModel in productLists) {
      if (ProductModel.title!.toLowerCase().contains(keyword) ||
          ProductModel.title!.toLowerCase().contains(keyword)) {
        searchResult.add(ProductModel);
      }
    }
  }

  void addToCart(ProductModel product) {
    cartLists.add(product);
    notifyListeners();
  }

  void removeCart(ProductModel product) {
    cartLists.remove(product);
    notifyListeners();
  }

  void refresh() async {
    setFailer(false);
    getAllProducts();
  }
}

final productProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel();
});
