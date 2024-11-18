import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/app/cart/cart_view.dart';

import 'package:shopping_app/src/app/home/controller/home_controller.dart';
import 'package:shopping_app/src/app/home/widget/shimmer.dart';
import 'package:shopping_app/src/app/home/widget/product_card.dart';
import 'package:shopping_app/src/model/item.dart';

const String homeView = '/home-view';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          var cartCount = 0;
          if (controller.product.value.items != null) {
            var productCart = controller.product.value.items!
                .where((element) => element.quantity! > 0)
                .toList();
            cartCount =
                productCart.fold(0, (int sum, item) => sum + item.quantity!);
          }
          if (controller.items.isNotEmpty) {
            var productCart = controller.items
                .where((element) => element.quantity! > 0)
                .toList();
            cartCount +=
                productCart.fold(0, (int sum, item) => sum + item.quantity!);
          }

          return Scaffold(
            body: buildCouponList(context, controller),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                print(value);
                if (value == 0) {}
                if (value == 1) {
                  Get.toNamed(cartView);
                }
              },
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.stars_rounded),
                  label: 'Shopping',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.stars_rounded),
                  label: 'Cart (${cartCount ?? 0})',
                ),
              ],
            ),
          );
        });
  }

  // Builds the coupon list tab
  Widget buildCouponList(BuildContext context, HomeController controller) {
    return Obx(() {
      return SafeArea(
        bottom: false,
        // padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Shimmer(
          linearGradient: shimmerGradient,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommend Product',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 340,
                  width: Get.width,
                  child: controller.isLoading.value
                      ? ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return _buildListItem();
                          },
                        )
                      : controller.items.isEmpty
                          ? Column(
                              children: [
                                const Icon(Icons.cancel,
                                    color: Colors.red, size: 65),
                                const Text('Something went wrong'),
                                FilledButton(
                                    onPressed: () {
                                      controller.refreshData();
                                    },
                                    child: const Text('Refresh'))
                              ],
                            )
                          : ListView.builder(
                              itemCount: controller.items.length,
                              itemBuilder: (context, index) {
                                final product = controller.items[index];
                                final List<int> cart = controller.cartList
                                    .where((e) => e == product.id)
                                    .toList();
                                // print('${cart.toJson()} ${product.id}');
                                return ProductCard(
                                  item: product,
                                  addToCard: (Item item) {
                                    print('ontab ${item.name}');
                                    controller.addTocard(item);
                                  },
                                );
                              },
                            ),
                ),
                Text(
                  'Latest Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: SizedBox(
                    height: 340,
                    width: Get.width,
                    child: controller.isLoading.value
                        ? ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return _buildListItem();
                            },
                          )
                        : controller.product.value.items!.isEmpty
                            ? Column(
                                children: [
                                  const Icon(Icons.cancel,
                                      color: Colors.red, size: 65),
                                  const Text('Something went wrong'),
                                  FilledButton(
                                      onPressed: () {
                                        controller.refreshData();
                                      },
                                      child: const Text('Refresh'))
                                ],
                              )
                            : ListView.builder(
                                itemCount:
                                    controller.product.value.items!.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      controller.product.value.items![index];
                                  return ProductCard(
                                    item: product,
                                    addToCard: (Item item) {
                                      print('ontab ${item.name}');
                                      controller.addTocard(item);
                                    },
                                  );
                                },
                              ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildListItem() {
    return const ShimmerLoading(
      isLoading: true,
      child: CardListItem(),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 40,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
