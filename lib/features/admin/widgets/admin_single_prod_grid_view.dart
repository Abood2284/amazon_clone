// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amazon_clone/features/account/widgets/single_prod_container.dart';
import 'package:amazon_clone/models/products.dart';

class AdminSingleProdGridView extends StatelessWidget {
  final List<Product> productDataObject;
  final Function deleteProductFunc;
  const AdminSingleProdGridView({
    Key? key,
    required this.productDataObject,
    required this.deleteProductFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productDataObject.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.21,
            child:
                SingleProductContainer(src: productDataObject[index].images[0]),
          ), // Image is a array of links, we just need the first image
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    productDataObject[index].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('deleting');
                    deleteProductFunc(productDataObject[index], index);
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
