import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/services/cart_service.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final cartService = context.watch<CartService>();
    final items = cartService.items;

    double subtotal = items.fold(
      0.0,
      (total, item) => total + item.price * item.quantity,
    );
    double discount = items.fold(
      0.0,
      (d, item) => d + item.price * item.discount * item.quantity,
    );
    double total = subtotal - discount;
    int totalItems = items.fold(0, (sum, item) => sum + item.quantity);

    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed:
                  () => cartService.addItem(
                    '1',
                    'Apple iPhone',
                    999.99,
                    discount: 0.1,
                  ),
              child: const Text('Add iPhone'),
            ),
            ElevatedButton(
              onPressed:
                  () => cartService.addItem(
                    '2',
                    'Samsung Galaxy',
                    899.99,
                    discount: 0.15,
                  ),
              child: const Text('Add Galaxy'),
            ),
            ElevatedButton(
              onPressed: () => cartService.addItem('3', 'iPad Pro', 1099.99),
              child: const Text('Add iPad'),
            ),
            ElevatedButton(
              onPressed:
                  () => cartService.addItem(
                    '1',
                    'Apple iPhone',
                    999.99,
                    discount: 0.1,
                  ),
              child: const Text('Add iPhone Again'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Items: $totalItems'),
                  ElevatedButton(
                    onPressed: cartService.clearCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Clear Cart'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
              Text('Total Discount: \$${discount.toStringAsFixed(2)}'),
              const Divider(),
              Text(
                'Total Amount: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        items.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final itemTotal = item.price * item.quantity;

                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: \$${item.price.toStringAsFixed(2)} each'),
                        if (item.discount > 0)
                          Text(
                            'Discount: ${(item.discount * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: Colors.green),
                          ),
                        Text('Item Total: \$${itemTotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed:
                              () => cartService.updateQuantity(
                                item.id,
                                item.quantity - 1,
                              ),
                          icon: const Icon(Icons.remove),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('${item.quantity}'),
                        ),
                        IconButton(
                          onPressed:
                              () => cartService.updateQuantity(
                                item.id,
                                item.quantity + 1,
                              ),
                          icon: const Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () => cartService.removeItem(item.id),
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }
}
