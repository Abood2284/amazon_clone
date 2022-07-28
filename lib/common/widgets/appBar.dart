import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../../features/search/screens/search_screen.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onSearchBarSubmitted(String query) {
      Navigator.of(context).pushNamed(SearchScreen.routeName, arguments: query);
    }

    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 42,
              margin: const EdgeInsets.only(left: 15),
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: onSearchBarSubmitted,
                  decoration: InputDecoration(
                    // FOr splash effect on tap
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(top: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide(color: Colors.black38, width: 1),
                    ),
                    hintText: 'Search Amazon.in',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
