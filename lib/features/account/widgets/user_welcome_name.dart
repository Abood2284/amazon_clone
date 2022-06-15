import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class UserWelcomeName extends StatelessWidget {
  const UserWelcomeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: RichText(
        text: TextSpan(
            text: 'Hello, ',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: user.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ]),
      ),
    );
  }
}
