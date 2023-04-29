// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:fake_store/constants/typography.dart';

class ErrorPage extends StatelessWidget {
  final String code;
  final String message;
  Widget action;
  ErrorPage({
    Key? key,
    required this.code,
    required this.message,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Lottie.asset('assets/images/no_internet.json', width: 220, height: 250),
        const SizedBox(
          height: 10,
        ),
        Text(message,
            style: Typo.medium(context).copyWith(color: Colors.grey[900]),
            overflow: TextOverflow.ellipsis),
        const SizedBox(
          height: 45,
        ),
        action
      ],
    );
  }
}
