import 'package:badges/badges.dart' as badges_badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_cart/cart_model.dart';
import 'package:flutter_shopping_cart/cart_provider.dart';
import 'package:flutter_shopping_cart/cart_screen.dart';
import 'package:flutter_shopping_cart/db_helper.dart';
// import 'package:flutter/widgets.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Banana',
    'Apple',
    'Grapes',
    'Pineapple',
    'Watermelon'
  ];
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'KG', 'KG', 'Dozen', 'KG'];
  List<int> productPrice = [100, 60, 40, 200, 80, 100, 50];
  List<String> productImage = [
    'assets/img/mango.png',
    'assets/img/orange.png',
    'assets/img/banana.png',
    'assets/img/apple.png',
    'assets/img/grapes.png',
    'assets/img/pineapple.png',
    'assets/img/watermelon.png'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Product List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              child: Center(
                child: badges_badges.Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.getCounter().toString(),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            )
          ]),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              // AssetImage('assets/${productImage[index]}')
                              image: AssetImage(productImage[index]),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index].toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${productUnit[index]} \$${productPrice[index]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        dbHelper!
                                            .insert(Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index]
                                                    .toString(),
                                                initialPrice:
                                                    productPrice[index],
                                                productPrice:
                                                    productPrice[index],
                                                productQuantity: 1,
                                                unitTag: productUnit[index]
                                                    .toString(),
                                                productImage:
                                                    productImage[index]
                                                        .toString()))
                                            .then((value) {
                                          cart.addTotalPrice(double.parse(
                                              productPrice[index].toString()));
                                          cart.addCounter();
                                          // ignore: avoid_print
                                          print(
                                              'Product added to cart successfully! ');
                                        }).onError((error, stackTrace) {
                                          // ignore: avoid_print
                                          print("ERROR: $error");
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add to cart',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
