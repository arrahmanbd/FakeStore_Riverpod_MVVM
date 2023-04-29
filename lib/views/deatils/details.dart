import 'dart:math' as math;

import 'package:fake_store/views/products/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fake_store/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../utils/toast.dart';
import '../../constants/typography.dart';
import '../../widgets/rating.dart';

class DetailsPage extends ConsumerStatefulWidget {
 final ProductModel product;
 DetailsPage({
    Key? key,
   required this.product,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends ConsumerState<DetailsPage>
    with TickerProviderStateMixin {
  bool expand1 = true, expand2 = false, expand3 = false;
  late AnimationController controller1, controller2, controller3;
  late Animation<double> animation1, animation1View;
  late Animation<double> animation2, animation2View;
  late Animation<double> animation3, animation3View;

  @override
  void initState() {
    super.initState();
    ref.read(productProvider);
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);

    animation2 = Tween(begin: 0.0, end: 180.0).animate(controller2);
    animation2View = CurvedAnimation(parent: controller2, curve: Curves.linear);

    animation3 = Tween(begin: 0.0, end: 180.0).animate(controller3);
    animation3View = CurvedAnimation(parent: controller3, curve: Curves.linear);

    controller1.addListener(() {
      setState(() {});
    });
    controller2.addListener(() {
      setState(() {});
    });
    controller3.addListener(() {
      setState(() {});
    });

    controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              expandedHeight: 340,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(widget.product.image.toString(),
                          fit: BoxFit.cover, width: double.infinity),
                    ),
                    Container(height: 150)
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(75),
                child: Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints.expand(height: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.product.title.toString(),
                            style: Typo.title(context)!
                                .copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis),
                        Container(height: 5),
                        Text("Himu Shop",
                            style: Typo.body1(context)!
                                .copyWith(color: AppColors.grey_10)),
                        Container(height: 5),
                        Row(
                          children: <Widget>[
                            StarRating(
                                starCount: 5,
                                rating: widget.product.ratingModel!.rate!
                                    .toDouble(),
                                color: Colors.yellow,
                                size: 14),
                            Container(width: 5),
                            Text("381,380",
                                style: Typo.caption(context)!
                                    .copyWith(color: AppColors.grey_10)),
                            const Spacer(),
                            Text('\$${widget.product.price}',
                                style: Typo.title(context)!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Container(width: 15),
                    const Icon(Icons.error_outline,
                        size: 25.0, ),
                    Container(width: 20),
                    Text("Description",
                        style: Typo.medium(context)
                            .copyWith()),
                    const Spacer(),
                    Transform.rotate(
                      angle: animation1.value * math.pi / 180,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.arrow_drop_down,
                           ),
                        onPressed: () {
                          togglePanel1();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: animation1View,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        Flexible(
                            flex: 1,
                            child: Text(widget.product.description.toString(),
                                style: Typo.subhead(context))),
                        Container(width: 20)
                      ],
                    ),
                    Container(height: 15),
                  ],
                ),
              ),
              const Divider(
                  color: AppColors.grey_10, height: 0, thickness: 0.8),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Container(width: 15),
                    const Icon(Icons.chat,
                        size: 25.0, ),
                    Container(width: 20),
                    Column(
                      children: <Widget>[
                        Text("Reviews",
                            style: Typo.subhead(context)!
                                .copyWith()),
                      ],
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: animation1.value * math.pi / 180,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.arrow_drop_down,
                            ),
                        onPressed: () {
                          togglePanel2();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: animation2View,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const StarRating(
                            starCount: 5,
                            rating: 4.0,
                            color: Colors.amber,
                            size: 14),
                        Container(width: 10),
                        const Text("Adams Green"),
                      ],
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const StarRating(
                            starCount: 5,
                            rating: 5.0,
                            color: Colors.amber,
                            size: 14),
                        Container(width: 10),
                        const Text("Anderson Thomas"),
                      ],
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const StarRating(
                            starCount: 5,
                            rating: 5.0,
                            color: Colors.amber,
                            size: 14),
                        Container(width: 10),
                        const Text("Roberts Turner"),
                      ],
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const StarRating(
                            starCount: 5,
                            rating: 4.5,
                            color: Colors.amber,
                            size: 14),
                        Container(width: 10),
                        const Text("Evans Collins"),
                      ],
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const StarRating(
                            starCount: 5,
                            rating: 5,
                            color: Colors.amber,
                            size: 14),
                        Container(width: 10),
                        const Text("Garcia Lewis"),
                      ],
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
              const Divider(
                  color: AppColors.grey_10, height: 0, thickness: 0.8),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Container(width: 15),
                    const Icon(Icons.verified_user,
                        size: 25.0, ),
                    Container(width: 20),
                    Column(
                      children: <Widget>[
                        Text("Warranty",
                            style: Typo.subhead(context)),
                      ],
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: animation1.value * math.pi / 180,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.arrow_drop_down,
                            ),
                        onPressed: () {
                          togglePanel3();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: animation3View,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 65),
                        const Flexible(flex: 1, child: Text('No Warrenty')),
                        Container(width: 20)
                      ],
                    ),
                    Container(height: 15),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      backgroundColor:
                          Colors.blue, // Text Color (Foreground color)
                    ),
                    onPressed: () {
                      ref.read(productProvider).addToCart(widget.product);
                      showToastMessage('Added to cart');
                    },
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 20),
                    label: Text(
                      'Buy Now',
                      style:
                          Typo.button(context)!.copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void togglePanel1() {
    if (!expand1) {
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  void togglePanel2() {
    if (!expand2) {
      controller2.forward();
    } else {
      controller2.reverse();
    }
    expand2 = !expand2;
  }

  void togglePanel3() {
    if (!expand3) {
      controller3.forward();
    } else {
      controller3.reverse();
    }
    expand3 = !expand3;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}
