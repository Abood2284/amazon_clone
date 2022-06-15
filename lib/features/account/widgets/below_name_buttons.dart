import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class BelowNameButtons extends StatefulWidget {
  const BelowNameButtons({Key? key}) : super(key: key);

  @override
  State<BelowNameButtons> createState() => _BelowNameButtonsState();
}

class _BelowNameButtonsState extends State<BelowNameButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              buttonText: 'Your Orders',
              buttonOnPresses: () {},
            ),
            AccountButton(
              buttonText: 'Turn Seller',
              buttonOnPresses: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              buttonText: 'Log Out',
              buttonOnPresses: () {},
            ),
            AccountButton(
              buttonText: 'Your Wish List',
              buttonOnPresses: () {},
            ),
          ],
        ),
      ],
    );
  }
}
