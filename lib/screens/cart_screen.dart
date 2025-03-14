import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final listnableCart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: Text("${listnableCart.itemCount}"),
          )
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: listnableCart,
        builder: (context, child) {
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${listnableCart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: listnableCart.itemCount == 0
                          ? MaterialStatePropertyAll(Colors.orange[400]!)
                          : MaterialStatePropertyAll(Colors.orange[900]!),
                    ),
                    onPressed: listnableCart.itemCount == 0
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 229, 214),
                                content: Text(
                                  "Purchase completed!",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                          color: listnableCart.itemCount == 0
                              ? Colors.grey[100]
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: listnableCart.items.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                cartItem: listnableCart.items.values.toList()[i],
                removeItem: (id) {
                  setState(() {
                    listnableCart.removeItem(id);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
