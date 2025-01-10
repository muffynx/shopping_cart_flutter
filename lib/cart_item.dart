import 'dart:developer'; // Use for logging
import 'package:flutter/material.dart';
import 'package:shopping_cart/item.dart';

class CartItem extends StatefulWidget {
  final Item item;
  final Function(int) onQuantityChanged; // Correctly defined parameter

  const CartItem({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.item.amount;
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      widget.item.amount = quantity;
    });
    widget.onQuantityChanged(quantity);
    log('Quantity updated: $quantity'); // Replace print with log
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.item.price} ฿',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (quantity > 0) {
                  updateQuantity(quantity - 1);
                }
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                updateQuantity(quantity + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}
