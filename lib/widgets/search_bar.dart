import 'package:fake_store/views/products/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(productProvider);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool search = ref.watch(productProvider).isSearching;
    return Container(
      color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          child: ListTile(
              leading: const Icon(Icons.search,color: Color.fromARGB(255, 120, 144, 156),),
              title: TextField(
                autofillHints: const ['Mens', 'Shoes'],
                autofocus: false,
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.blueGrey[400]),
                    border: InputBorder.none),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    ref
                        .read(productProvider)
                        .search(_controller.text.toString());
                  }
                },
              ),
              trailing: !search
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(Icons.cancel,color: Color.fromARGB(255, 120, 144, 156),),
                      onPressed: () {
                        _controller.clear();
                        ref.read(productProvider).search('');
                      },
                    )),
        ),
     
    );
  }
}
