import 'package:fake_store/service/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fake_store/service/repository.dart';
import 'package:http/http.dart';
import '../../../core/api_link.dart';
import '../../../model/product_model.dart';
import '../../../service/repo_controller.dart';

class HomeViewModel extends ChangeNotifier with BaseController {
  var productLists = <ProductModel>[];
  var cartLists = <ProductModel>[];
  var searchResult = <ProductModel>[];

  bool isLoading = true;
  bool isSearching = true;
  //Call initial Function

  HomeViewModel() {
    getAllProducts();
  }

//Calculate toatal
  double get totalPrice => cartLists.fold(
      0, (previousValue, element) => previousValue + element.price!);

  setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  setSearch(bool searching) {
    isSearching = searching;
    notifyListeners();
  }

  void getAllProducts() async {
    // var product = await ApiService.fetchProduct().catchError(handleError);
    var product = await BaseApi.fetch(PRO);
    // productLists = product;
    print(product);
    setLoading(false);
  }

  void search(String keyword) {
    setSearch(false);
    searchResult.clear();
    for (var ProductModel in productLists) {
      if (ProductModel.title!.toLowerCase().contains(keyword) ||
          ProductModel.title!.toLowerCase().contains(keyword))
        searchResult.add(ProductModel);
    }
    setSearch(false);
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    cartLists.add(product);
    notifyListeners();
  }

  void removeCart(ProductModel product) {
    cartLists.remove(product);
    notifyListeners();
  }
}

final productProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel();
});
