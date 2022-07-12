// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:flutter/material.dart';

import '../../../../constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-screen';
  final String categoryName;
  const CategoryDealsScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final homeService = HomeServices();
  List<Product>? categoryProd;
  @override
  void initState() {
    super.initState();
    fetchProdCategoryWise();
  }

  fetchProdCategoryWise() async {
    categoryProd = await homeService.fetchCategoryWiseProducts(
      context: context,
      category: widget.categoryName,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(widget.categoryName),
        ),
      ),
      body: categoryProd == null || categoryProd!.isEmpty
          ? const Center(
              child: Text('No Products available yet in this category😣'),
            )
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.categoryName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProd!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1.4),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                    categoryProd![index].images[0]),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 15),
                            child: Text(
                              categoryProd![index].name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
