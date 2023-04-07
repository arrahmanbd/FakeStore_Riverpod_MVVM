import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/toast.dart';
import '../../widgets/mytext.dart';
import '../../widgets/rating.dart';
import 'view_model/home_viewmodel.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var apidata = ref.watch(productProvider);
    bool searching = apidata.isSearching;

    if (apidata.isLoading) {
      return Center(
        child: Column(
          children: [
            const Text('Failed to Fetch Data'),
            const SizedBox(
              height: 45,
            ),
          ElevatedButton(
                  onPressed: () {
                    ref.read(productProvider).getAllProducts();
                  },
                  child: const Text('Retry')),
            
          ],
        ),
      );
    }
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount:searching ? apidata.productLists.length : apidata.searchResult.length,
      itemBuilder: (c, i) {
        final list = searching ? apidata.productLists : apidata.searchResult;
        return Container(
          padding: const EdgeInsets.all(2),
          child: Card(
              margin: const EdgeInsets.all(0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.network(list[i].image.toString(),
                        width: double.infinity, fit: BoxFit.cover),
                  ),
                  Container(height: 5),
                  Row(
                    children: <Widget>[
                      Container(width: 10),
                      Expanded(
                        child: Text(list[i].title.toString(),
                            style: MyText.subhead(context)!
                                .copyWith(color: Colors.grey[900]),
                            overflow: TextOverflow.ellipsis),
                      ),
                      Container(width: 5),
                      InkWell(
                        onTap: () {
                          ref.read(productProvider).addToCart(list[i]);
                          showToastMessage('Added to cart');
                        },
                        child: const Icon(Icons.shopping_cart_outlined,
                            color: Colors.deepOrange, size: 20),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Row(
                    children: <Widget>[
                      Container(width: 10),
                      StarRating(
                          starCount: 5,
                          rating: list[i].ratingModel!.rate!.toDouble(),
                          color: Colors.deepOrange,
                          size: 14),
                      const Spacer(),
                      Text('\$' + list[i].price.toString(),
                          style: MyText.subhead(context)!.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                      Container(width: 10),
                    ],
                  ),
                  Container(height: 10),
                ],
              )),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
      ),
    );
  }
}
