import 'package:amazon_clone/common/widgets/appBar.dart';
import 'package:amazon_clone/common/widgets/starts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../models/products.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail-screen';

  final Product product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void onSearchBarSubmitted(String query) {
    Navigator.of(context).pushNamed(SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  const Stars(rating: 4),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((e) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                // So that it takes up the full height
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
          ],
        ),
      ),
    );
  }
}
