import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.text, required this.onTap, this.color})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          primary: Colors.amber[300]),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
