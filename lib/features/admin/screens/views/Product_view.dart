import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../../models/products.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    // fetchProducts();
  }

  @override
  void didChangeDependencies() {
    adminServices.fetchAllProducts(context).then((value) {
      setState(() {
        products = value;
      });
    });
    super.didChangeDependencies();
  }

  // Future<List<Product>> fetchProducts() async {
  //   return await adminServices.fetchAllProducts(context);
  // }

  void navigateToAddProductScreen() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: const Center(
              child: Text('Prodcuts'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProductScreen,
              tooltip:
                  'Add a product', // On long press it will show this (to help people know what this button does)
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
