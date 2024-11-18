import 'package:flutter/material.dart';
import 'package:shopping_app/service/app_unity.dart';
import 'package:shopping_app/src/model/item.dart';

class CardProductCard extends StatelessWidget {
  final Item item;
  final Function(Item item) onPressed;

  const CardProductCard(
      {super.key, required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 76,
                width: 76,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    //'assets/image/card_mork1.png'
                    image: AssetImage('assets/images/img_placeholder.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.name}'),
                  Row(
                    children: [
                      Text(AppUnity.fomateNumber(digit: 2).format(item.price)),
                      const Text(' /unit')
                    ],
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              // FilledButton(
              //   onPressed: () {
              //     item.quantity = item.quantity! - 1;
              //   },
              //   style: ElevatedButton.styleFrom(
              //     shape: const CircleBorder(),
              //   ),
              //   child: const Icon(Icons.remove),
              // ),
              Text('${item.quantity}'),
              // FilledButton(
              //   onPressed: () {
              //     item.quantity = item.quantity! + 1;
              //   },
              //   style: ElevatedButton.styleFrom(
              //     shape: const CircleBorder(),
              //   ),
              //   child: const Icon(Icons.add),
              // )
            ],
          )
          // FilledButton(
          //     onPressed: () {
          //       onPressed(item);
          //     },
          //     child: const Text('Add to cart')),
        ],
      ),
    );
  }
}
