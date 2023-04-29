import 'package:fake_store/constants/typography.dart';
import 'package:flutter/material.dart';

class HeadLines extends StatelessWidget {
  final String title;
  const HeadLines({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(3),
      child: Text(title,
          style: Typo.subhead(context)!
              .copyWith( fontSize: 18),
          overflow: TextOverflow.ellipsis),
    );
  }
}
