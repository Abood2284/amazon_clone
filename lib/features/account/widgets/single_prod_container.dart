import 'package:flutter/material.dart';

class SingleProductContainer extends StatelessWidget {
  final String src;
  const SingleProductContainer({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 180,
          child: Image.network(src, fit: BoxFit.contain, width: 180),
        ),
      ),
    );
  }
}
