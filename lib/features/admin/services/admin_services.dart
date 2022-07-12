import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class AdminServices {
  // ❌ Sell / add New products ❌
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dmd7ubap5', 'ru5dkwo9');
      List<String> imageUrls = [];

      // * Store the images on the cloudinary within a folder named same as the product
      for (int i = 0; i < images.length; i++) {
        var res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        // * Store the URl to the that image -> This url will be stored on mongoodb
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Sucessfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// ❌ Get all products ❌
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<Product> productsList = [];
    try {
      var res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              /// Now if you see this jsonDecode returns the us the type of Product object (Speciified dynamic)
              /// though fromJson function needs a String
              ///
              /// So to get String we first jsonEncode every dynamic json value at position i
              /// coz jsonEncode returns a String
              productsList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  // ❌ Delete a product ❌
  void deleteProduct(
      BuildContext context, Product product, VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var res = await http.post(
        Uri.parse('$uri/admim/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
