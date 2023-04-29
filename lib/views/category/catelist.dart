import 'package:fake_store/constants/colors.dart';
import 'package:fake_store/extensions/capitalize.dart';
import 'package:fake_store/constants/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cat_viemodel.dart';

class CatList extends ConsumerWidget {
  const CatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cat = ref.watch(catProvider);
    if (cat.isloading) {
      return const CupertinoActivityIndicator();
    }
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cat.catlist.length,
        itemBuilder: (c, i) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            color: AppColors.primaryLight,
            child: Text(cat.catlist[i].toString().toCapitalize(),
                style: Typo.subhead(context)!.copyWith(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis),
          );
        });
  }
}
