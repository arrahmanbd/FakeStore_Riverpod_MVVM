import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/toast.dart';
import '../../../widgets/item_count.dart';
import '../../../widgets/mytext.dart';
import '../view_model/home_viewmodel.dart';
import '../../startpage.dart' show HomePage;

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = ref.watch(productProvider).totalPrice;
    final list = ref.watch(productProvider).cartLists;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [const ShowItem(widget: HomePage())],
      ),
      body: list.isEmpty
          ? Center(
              child: Text('Cart is empty',
                  style: MyText.subhead(context)!
                      .copyWith(color: Colors.grey[900]),
                  overflow: TextOverflow.ellipsis),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (c, i) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          color: Colors.grey[100],
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image.network(list[i].image.toString()),
                            ),
                            title: Text(list[i].title.toString()),
                            subtitle: Text('\$'+ list[i].price.toString()),
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text('Total Shopping: \$$amount',
                      style: MyText.headline(context)!
                          .copyWith(color: Colors.grey[900]),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
    );
  }
}
