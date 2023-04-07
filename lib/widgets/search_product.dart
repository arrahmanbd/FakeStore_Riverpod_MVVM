import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/home/view_model/home_viewmodel.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                ref.read(productProvider).search(value.toString());
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                 ref.read(productProvider).search('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
