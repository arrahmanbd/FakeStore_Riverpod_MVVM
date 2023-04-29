import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/toast.dart';
import '../../constants/typography.dart';
import '../products/product_list_view_model.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = ref.watch(productProvider).totalPrice;
    final list = ref.watch(productProvider).cartLists;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart (${list.length})',
            style: Typo.headline(context)!.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis),
        // actions: const [ShowItem(widget: HomePage())],
      ),
      body: list.isEmpty
          ? Center(
              child: Text('Cart is empty',
                  style:
                      Typo.subhead(context)!.copyWith(color: Colors.grey[900]),
                  overflow: TextOverflow.ellipsis),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (c, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: Colors.grey[100],
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image.network(list[i].image.toString()),
                            ),
                            title: Text(list[i].title.toString()),
                            subtitle: Text('\$${list[i].price}'),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  ref.read(productProvider).removeCart(list[i]);
                                  showToastMessage('Remove from cart');
                                },
                                child: const Text('Remove')),
                          ),
                        );
                      }),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text('Total Shopping: \$$amount',
                      style: Typo.headline(context)!
                          .copyWith(color: Colors.grey[900]),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
    );
  }
}
