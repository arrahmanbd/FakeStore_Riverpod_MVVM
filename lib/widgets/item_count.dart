import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/app_router.dart';
import '../views/products/product_list_view_model.dart';
import '../constants/typography.dart';

class ShowItem extends ConsumerWidget {
  final Widget widget;
  const ShowItem({super.key, 
    required this.widget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalItem = ref.watch(productProvider).cartLists.length;
    return InkWell(
      onTap: () {
        goTo(context,cart);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            Text(totalItem.toString(),
                style: Typo.subhead(context)!.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}
