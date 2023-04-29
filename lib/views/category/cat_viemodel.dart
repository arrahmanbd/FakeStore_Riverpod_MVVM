import 'package:fake_store/constants/urls.dart';
import 'package:fake_store/helper/app_error.dart';
import 'package:fake_store/service/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helper/app_exception.dart';

class CategoryList extends ChangeNotifier {
  List catlist = [];
  bool isloading = true;
  UserError userError = UserError();

  setLoading(bool loading) {
    isloading = loading;
    notifyListeners();
  }

  CategoryList() {
    getCat();
  }
  getCat() async {
    var response = await BaseApi.fetch(CATS);
    try {
      if (response is Success) {
        Iterable cats = response.response as List;
        catlist = cats.toList();
        setLoading(false);
      }
      if (response is Failure) {
        userError = UserError(
            code: response.code, message: response.errorResponse.toString());
        setLoading(true);
      }
    } catch (e) {
      userError = UserError(
          code: response.code, message: response.errorResponse.toString());
    }
  }
}

final catProvider = ChangeNotifierProvider((ref) {
  return CategoryList();
});
