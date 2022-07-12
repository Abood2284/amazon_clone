import 'package:amazon_clone/features/home/screens/views/category_deals_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class TopCatgoriesContainerWidget extends StatelessWidget {
  const TopCatgoriesContainerWidget({Key? key}) : super(key: key);

  void navigateToDynamicCategoryView(
      BuildContext context, String categoryViewName) {
    Navigator.pushNamed(
      context,
      CategoryDealsScreen.routeName,
      arguments: categoryViewName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75, // every item is going to have width or extent till 75
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToDynamicCategoryView(
                context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
