import 'package:fake_store/model/product_model.dart';
import 'package:fake_store/router/app_router.dart';
import 'package:fake_store/router/export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fake_store/utils/grid_loader.dart';
import 'package:fake_store/widgets/headline.dart';

import '../../constants/typography.dart';
import '../../utils/error_page.dart';
import '../../utils/toast.dart';
import '../../widgets/rating.dart';
import 'product_list_view_model.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var apidata = ref.watch(productProvider);

    if (apidata.isLoading) {
      return const GridLoader();
    }
    if (apidata.isFailer) {
      return ErrorPage(
        //After exception state disposed, this is a problem.
        //Thats means ref.read not working thats why i used ref.refrsh to call the state again
        //But I want to call this fuction inside Error page, unfortunatly it's not works
        //So I created this solution.
        message: apidata.userError.message.toString(),
        action: ElevatedButton(
          onPressed: () async {
            ref.refresh(productProvider);
          },
          child: const Text('Retry'),
        ),
        code: apidata.userError.code.toString(),
      );
    }
    if (apidata.isSearching && apidata.searchResult.isEmpty) {
      return const HeadLines(title: 'Nothing Found');
    }
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(productProvider);
      },
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: apidata.isSearching
            ? apidata.searchResult.length
            : apidata.productLists.length,
        itemBuilder: (c, i) {
          final list =
              apidata.isSearching ? apidata.searchResult : apidata.productLists;
          return Container(
            padding: const EdgeInsets.all(2),
            child: InkWell(
              onTap: () {
                goTo(context, details, args:apidata.productLists[i]);
              },
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
                                style: Typo.subhead(context)!.copyWith(),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Container(width: 5),
                          InkWell(
                            onTap: () {
                              ref.read(productProvider).addToCart(list[i]);
                              showToastMessage('Added to cart');
                            },
                            child: const Icon(Icons.shopping_cart_outlined,
                                color: Colors.blue, size: 20),
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
                              color: Colors.blue,
                              size: 14),
                          const Spacer(),
                          Text('\$' + list[i].price.toString(),
                              style: Typo.subhead(context)!.copyWith(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold)),
                          Container(width: 10),
                        ],
                      ),
                      Container(height: 10),
                    ],
                  )),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
