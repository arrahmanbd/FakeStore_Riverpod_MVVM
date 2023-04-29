// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/headline.dart';
import '../widgets/item_count.dart';
import '../constants/typography.dart';
import '../widgets/search_bar.dart';
import 'cart/carts.dart';
import 'category/catelist.dart';
import 'products/product_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // bool theme = ref.watch(themeProvider).isDark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Fake Store',
            style: Typo.headline(context)!.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis),
        actions: const [
          ShowItem(
            widget: CartPage(),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ref.read(themeProvider).setTheme();
      //     //  final currentValue = theme;
      //     // ref.read(themeProvider.notifier).setThemeDark(!currentValue);
      //   },
      //   child: AnimatedSwitcher(
      //     switchInCurve: Curves.linear,
      //     duration: const Duration(milliseconds: 700),
      //     child: Icon(
      //       key: Key(theme ? "dark" : "light"),
      //       theme ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      //       color: theme ? Colors.white : Colors.black,
      //     ),
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
            child: SearchPage(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HeadLines(title: 'Category'),
                      SizedBox(
                        height: 50,
                        child: CatList(),
                      ),
                      HeadLines(title: 'Friday Sales'),
                      Expanded(child: Padding(
                        padding: EdgeInsets.only(bottom:18.0),
                        child: ProductList(),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
