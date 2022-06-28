import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    void navigateToAddProductScreen() {
      Navigator.of(context).pushNamed(AddProductScreen.routeName);
    }

    return Scaffold(
      body: const Center(
        child: Text('Prodcuts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProductScreen,
        tooltip:
            'Add a product', // On long press it will show this (to help people know what this button does)
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
