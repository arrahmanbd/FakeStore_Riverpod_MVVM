import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../helper/app_exception.dart';

class BaseApi {
  //Base Client
  static final _client = http.Client();
  static const Duration _timesup = Duration(seconds: 20);

  //GET
  static Future<dynamic> fetch(String url) async {
    var uri = Uri.parse(url);
    try {
      var response = await _client.get(uri).timeout(_timesup);
      return _processResponse(response);
    } on SocketException {
      return Failure(code: 100, errorResponse: SOCKET_IO_CONNECTION);
    } on HttpException {
      return Failure(code: 101, errorResponse: HTTP_EXCEPTION);
    } on TimeoutException {
      return Failure(code: 102, errorResponse: REQUEST_EXCEPTION);
    } catch (e) {
      return Failure(code: 500, errorResponse: SOCKET_IO_EXCEPTION);
    }
  }

  //POST
  static Future<dynamic> post(String api, dynamic payloadObj) async {
    var uri = Uri.parse(api);
    var payload = payloadObj;
    // var payload = json.encode(payloadObj);
    try {
      var response = await http.post(uri, body: payload).timeout(_timesup);
      return _processResponse(response);
    } on SocketException {
      return Failure(code: 100, errorResponse: SOCKET_IO_CONNECTION);
    } on HttpException {
      return Failure(code: 101, errorResponse: HTTP_EXCEPTION);
    } on TimeoutException {
      return Failure(code: 102, errorResponse: REQUEST_EXCEPTION);
    } catch (e) {
      return Failure(code: 500, errorResponse: SOCKET_IO_EXCEPTION);
    }
  }

  //Exception Handling
  static dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return Success(response: responseJson);
      case 400:
        return Failure(code: 400, errorResponse: BAD_REQUEST);
      case 401:
        return Failure(code: 401, errorResponse: UNAUTHORIZED);
      case 403:
        return Failure(code: 403, errorResponse: FORBIDDEN);
      case 404:
        return Failure(code: 404, errorResponse: NOT_FOUND);
      case 405:
        return Failure(code: 405, errorResponse: METHOD_NOT_ALLOWED);
      case 406:
        return Failure(code: 405, errorResponse: NOT_ACCEPTABLE);
      case 429:
        return Failure(code: 429, errorResponse: TOO_MANY_REQUESTS);
      case 415:
        return Failure(code: 415, errorResponse: UNSUPPORTED_MEDIA_TYPE);
      case 500:
        return Failure(code: 500, errorResponse: INTERNAL_SERVER_ERROR);
      default:
        return Failure(code: 500, errorResponse: UNKNOWN);
    }
  }
}
