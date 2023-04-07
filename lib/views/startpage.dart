import 'package:flutter/material.dart';
import '../widgets/item_count.dart';
import '../widgets/mytext.dart';
import 'home/cart/carts.dart';
import 'home/home.dart';
import '../widgets/search_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text('Fake Store API',
            style: MyText.headline(context)!.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis),
        actions: const [
          ShowItem(
            widget: CartPage(),
          )
        ],
      ),
      body: Column(
        children: const  [
          SizedBox(
            height: 80,
            child: SearchPage(),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ProductList(),
          )),
        ],
      ),
    );
  }
}
