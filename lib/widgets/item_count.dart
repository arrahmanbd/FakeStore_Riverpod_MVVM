import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/home/view_model/home_viewmodel.dart';
import 'mytext.dart';

class ShowItem extends ConsumerWidget {
  final Widget widget;
  const ShowItem({
    required this.widget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalItem = ref.watch(productProvider).cartLists.length;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Icon(Icons.store,color: Colors.white,), Text(totalItem.toString(),
                          style: MyText.subhead(context)!.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis
                      )],
        ),
      ),
    );
  }
}
