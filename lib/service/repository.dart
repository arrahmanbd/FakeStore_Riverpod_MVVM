import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fake_store/model/product_model.dart';
import 'package:http/http.dart' as http;
import '../core/api_link.dart';
import '../helper/exception.dart';

class ApiService {
  static final _client = http.Client();
  static final _url = Uri.parse(BASE);

  static Future<List<ProductModel>> fetchProduct() async {
    var response = await _client.get(_url);
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return (list).map((e) => ProductModel.fromJson(e)).toList();
    }
    throw Exception('Failed To Load');
  }



}
