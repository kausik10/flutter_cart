import 'package:badges/badges.dart' as badges_badges;

import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_cart/cart_model.dart';
import 'package:flutter_shopping_cart/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Products'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            Center(
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
            const SizedBox(
              width: 20.0,
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No items in the cart'),
                    );
                  }
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                          height: 100,
                                          width: 100,
                                          // AssetImage('assets/${productImage[index]}')
                                          image: AssetImage(snapshot
                                              .data![index].productImage
                                              .toString()),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      dbHelper!.delete(snapshot
                                                          .data![index].id!);
                                                      cart.removeCounter();
                                                      cart.removeTotalPrice(
                                                          double.parse(snapshot
                                                              .data![index]
                                                              .productPrice!
                                                              .toString()));
                                                    },
                                                    child: const Icon(
                                                        Icons.delete),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "${snapshot.data![index].unitTag.toString()} \$${snapshot.data![index].productPrice.toString()}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: InkWell(
                                                  child: Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity = snapshot
                                                                .data![index]
                                                                .productQuantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity--;
                                                            int? newPrice =
                                                                price *
                                                                    quantity;
                                                            if (quantity > 0) {
                                                              dbHelper!
                                                                  .updateQuantity(Cart(
                                                                      id: snapshot.data![index].id,
                                                                      productId: snapshot.data![index].productId.toString(),
                                                                      productName: snapshot //snapshot.data![index].productName.toString(),
                                                                          .data![index]
                                                                          .productName!,
                                                                      initialPrice: snapshot.data![index].initialPrice,
                                                                      productPrice: newPrice,
                                                                      productQuantity: quantity,
                                                                      unitTag: snapshot //snapshot.data![index].unitTag.toString(),
                                                                          .data![index]
                                                                          .unitTag!
                                                                          .toString(),
                                                                      productImage: snapshot.data![index].productImage.toString()))
                                                                  .then((value) {
                                                                newPrice = 0;
                                                                quantity = 0;
                                                                cart.removeTotalPrice(
                                                                    double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice
                                                                        .toString()));
                                                              }).onError((error, stackTrace) {
                                                                print(error
                                                                    .toString());
                                                              });
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .productQuantity
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity = snapshot
                                                                .data![index]
                                                                .productQuantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity++;
                                                            int? newPrice =
                                                                price *
                                                                    quantity;

                                                            dbHelper!
                                                                .updateQuantity(Cart(
                                                                    id: snapshot.data![index].id,
                                                                    productId: snapshot.data![index].productId.toString(),
                                                                    productName: snapshot //snapshot.data![index].productName.toString(),
                                                                        .data![index]
                                                                        .productName!,
                                                                    initialPrice: snapshot.data![index].initialPrice,
                                                                    productPrice: newPrice,
                                                                    productQuantity: quantity,
                                                                    unitTag: snapshot //snapshot.data![index].unitTag.toString(),
                                                                        .data![index]
                                                                        .unitTag!
                                                                        .toString(),
                                                                    productImage: snapshot.data![index].productImage.toString()))
                                                                .then((value) {
                                                              newPrice = 0;
                                                              quantity = 0;
                                                              cart.addTotalPrice(
                                                                  double.parse(snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice
                                                                      .toString()));
                                                            }).onError((error, stackTrace) {
                                                              print(error
                                                                  .toString());
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
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
                    );
                  }
                  return const Text("");
                }),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                      ? false
                      : true,
                  child: Column(
                    children: [
                      ReUsableWidget(
                        title: 'Subtotal',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      ReUsableWidget(
                        title: 'Discount 5%',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      ReUsableWidget(
                        title: 'GrandTotal',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReUsableWidget extends StatelessWidget {
  final String title, value;

  const ReUsableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          height: 5,
        ),
        Text(value.toString(), style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
