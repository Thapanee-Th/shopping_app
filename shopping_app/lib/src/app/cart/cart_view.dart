import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/service/app_unity.dart';
import 'package:shopping_app/src/app/home/controller/home_controller.dart';
import 'package:shopping_app/src/app/home/widget/shimmer.dart';
import 'package:shopping_app/src/app/cart/widget/card_product_card.dart';
import 'package:shopping_app/src/model/item.dart';

const String cartView = '/cart-view';

class CartView extends StatelessWidget {
  const CartView({super.key});

  // final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                leadingWidth: 40,
                title: const Text('Cart'),
              ),
              body: buildCouponList(context, controller),
              bottomNavigationBar: Container(
                color: const Color(0xFFE8DEF8),
                padding: const EdgeInsets.all(10),
                height: 163,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal"),
                        Text(AppUnity.fomateNumber(digit: 2)
                            .format(controller.subtotal.value)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Promotion discount"),
                        Text(
                          AppUnity.fomateNumber(digit: 2).format(0),
                          style: TextStyle(
                              color: (0).isNegative
                                  ? const Color(0xffFF0000)
                                  : const Color(0xff008926)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppUnity.fomateNumber(digit: 2)
                            .format(controller.subtotal.value)),
                        FilledButton(
                            onPressed: () {
                              // onPressed(item);
                            },
                            child: const Text('Check out')),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  // Builds the coupon list tab
  Widget buildCouponList(BuildContext context, HomeController controller) {
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
                              itemCount: controller.carts.length,
                              itemBuilder: (context, index) {
                                final product = controller.carts[index];

                                return Dismissible(
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Are you sure you want to delete ${product.name}?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    // TODO: Delete the item from DB etc..

                                                    // itemsList.removeAt(index);

                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else {
                                      // TODO: Navigate to edit page;
                                    }
                                    return null;
                                  },
                                  background: slideRightBackground(),
                                  key: Key(controller
                                      .product.value.items![index].id
                                      .toString()),
                                  child: CardProductCard(
                                    item: product,
                                    onPressed: (Item item) {
                                      print('ontab ${item.name}');
                                      controller.addTocard(item);
                                    },
                                  ),
                                );
                              }),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
