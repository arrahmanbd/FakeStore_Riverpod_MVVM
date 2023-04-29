import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';

class GridLoader extends StatelessWidget {
  const GridLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (c, index) {
        return Container(
            padding: const EdgeInsets.all(2),
            child: Card(
            margin: const EdgeInsets.all(0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                const AnimatedShimmer(
                  height: 120,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedShimmer(
                          height: 20,
                          width: 120,
                          // borderRadius: const BorderRadius.all(Radius.circular(16)),
                          delayInMilliSeconds: Duration(milliseconds: index * 500),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        AnimatedShimmer(
                          height: 20,
                          width: 180,
                          // borderRadius: const BorderRadius.all(Radius.circular(16)),
                          delayInMilliSeconds: Duration(milliseconds: index * 500),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
      ),
    );
  }
}
