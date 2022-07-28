import 'dart:convert';

import 'package:amazon_clone/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchProductBySearch({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<Product> fetchedProducts = [];
    final userProv = Provider.of<UserProvider>(context, listen: false);
    try {
      var res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProv.user.token,
        },
      );
      print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(jsonDecode(res.body).length);

          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            fetchedProducts.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, '${e}In Search Services');
    }
    return fetchedProducts;
  }
}
