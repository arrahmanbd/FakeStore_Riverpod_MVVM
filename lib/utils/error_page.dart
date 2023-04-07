// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String message;
  const Error({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
           Text(message),
          const SizedBox(
            height: 45,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Retry')),
        ],
      ),
    );
  }
}
