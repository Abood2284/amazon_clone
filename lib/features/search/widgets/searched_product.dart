import 'package:amazon_clone/common/widgets/starts.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:flutter/material.dart';

class SearchedProductWidget extends StatelessWidget {
  final Product product;
  const SearchedProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fitWidth,
            height: 135,
            width: 135,
          ),
          Column(
            children: [
              Container(
                width: 235,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Stars(rating: 4),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Eligible for FREE Shipping',
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Text(
                  'In Stock',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
