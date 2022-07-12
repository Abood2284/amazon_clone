import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/admin_single_prod_grid_view.dart';
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
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    print(products!.length);
    setState(() {});
  }

  // @override
  // void didChangeDependencies() {
  //   adminServices.fetchAllProducts(context).then((value) {
  //     setState(() {
  //       products = value;
  //       print(products!.length);
  //     });
  // });
  // super.didChangeDependencies();
  // }

  void navigateToAddProductScreen() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  void deleteProductFunc(Product product, int index) {
    adminServices.deleteProduct(context, product, () {
      products!.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: AdminSingleProdGridView(
              productDataObject: products!,
              deleteProductFunc: deleteProductFunc,
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
