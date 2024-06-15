import 'dart:convert';
import 'package:app/api/shared_service.dart';
import 'package:app/config/config.dart';
import 'package:app/models/auth/login_response.dart';
import 'package:app/models/auth/otp_response_model.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/product/product_filter.dart';

import 'package:http/http.dart' as http;
import '../models/categories/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  // login
  static Future<bool?> login(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  //Signup
  static Future<bool> signup(
    String name,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.signupAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "name": name,
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//getOTP
  static Future<OtpResponseModel> otpSend(String email) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.sendotpAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"email": email},
      ),
    );
    return otpResponseJSON(response.body);
  }

//verifyotp
  static Future<dynamic> otpVerify(
    String email,
    String otpHash,
    String otpCode,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.verifyotpAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "otp": otpCode,
          "hash": otpHash,
        },
      ),
    );

    return (jsonDecode(response.body));
  }

  //reset password
  static Future<dynamic> reset(String email, String password) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.resetpassword);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      print('done');
      return true;
    } else {
      return false;
    }
  }

//Getcatogires
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  // get products
  Future<List<Product>?> getProducts(
    ProductFilterModel productFilterModel,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString(),
    };

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }

    if (productFilterModel.productIds != null) {
      queryString["productsIds"] = productFilterModel.productIds!.join(",");
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, "${Config.productAPI}/$productId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }
}
