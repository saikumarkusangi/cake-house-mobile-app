import 'package:cached_network_image/cached_network_image.dart';
import 'package:cake_house_bakery/controllers/cart_provider.dart';
import 'package:cake_house_bakery/controllers/product_controller.dart';
import 'package:cake_house_bakery/db.dart';
import 'package:cake_house_bakery/views/order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../models/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  Db db = Db();
  Map orderList = {};
  int _total = 0;
  getTotal() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     _total = prefs.getInt('total_price')!;
  }
  @override
  void initState() { 
    super.initState();
   getTotal();
    
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartController>(context);
  final productProvider = Provider.of<ProductController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: cartProvider.getData(),
          builder: ((context, AsyncSnapshot<List<Cart>> snapshot) {
            
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      orderList[snapshot.data![index].name] =
                          snapshot.data![index].quantity!;
                      return Card(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 150,
                                        width: 120,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor:
                                                    Colors.grey[300]!,
                                                child: Container(
                                                  height: 150,
                                                  width: 120,
                                                  color: Colors.grey[400]!,
                                                ),
                                              ),
                                              imageUrl:
                                                  snapshot.data![index].image!,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://demofree.sirv.com/products/123456/123456.jpg?profile=error-example'),
                                            ))),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.8,
                                            child: Text(
                                              snapshot.data![index].name!,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹ ${snapshot.data![index].price!.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                color: Colors.white,
                                                width: 120,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;
                                                        quantity--;
                                                        int? newPrice =
                                                            price * quantity;
                                                        if (quantity > 0) {
                                                          db
                                                              .updateQuantity(Cart(
                                                                  initialPrice: snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice,
                                                                  image: snapshot
                                                                      .data![
                                                                          index]
                                                                      .image!,
                                                                  name: snapshot
                                                                      .data![
                                                                          index]
                                                                      .name,
                                                                  price:
                                                                      newPrice,
                                                                  id: snapshot
                                                                      .data![
                                                                          index]
                                                                      .id,
                                                                  quantity:
                                                                      quantity,
                                                                  unitTag: snapshot
                                                                      .data![
                                                                          index]
                                                                      .unitTag!))
                                                              .then((value) {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cartProvider
                                                                .removetotalPrice(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!);
                                                          }).catchError((error,
                                                                  stackTrace) {
                                                            print(error
                                                                .toString());
                                                          });
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color:
                                                            Colors.deepOrange,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.deepOrange,
                                                          fontSize: 22),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;
                                                        quantity++;
                                                        int? newPrice =
                                                            price * quantity;
                                                        db
                                                            .updateQuantity(Cart(
                                                                initialPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice,
                                                                image: snapshot
                                                                    .data![
                                                                        index]
                                                                    .image!,
                                                                name: snapshot
                                                                    .data![
                                                                        index]
                                                                    .name,
                                                                price: newPrice,
                                                                id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                quantity:
                                                                    quantity,
                                                                unitTag: snapshot
                                                                    .data![
                                                                        index]
                                                                    .unitTag!))
                                                            .then((value) {
                                                          newPrice = 0;
                                                          quantity = 0;
                                                          cartProvider
                                                              .addtotalPrice(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!);
                                                        }).catchError((error,
                                                                stackTrace) {
                                                          print(
                                                              error.toString());
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color:
                                                            Colors.deepOrange,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          MaterialButton(
                                              textColor: Colors.white,
                                              color: Colors.deepOrange,
                                              onPressed: () {
                                                cartProvider.removetotalPrice(
                                                    snapshot
                                                        .data![index].price!);
                                                db.delete(
                                                    snapshot.data![index].id!);
                                                cartProvider.removeCounter();
                                              },
                                              minWidth: 50,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ])));
                    }),
                  )),
                  Container(
                    color: Colors.deepOrange,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Total Price = ₹ ${cartProvider.totalPrice.toString()}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return OrderPage(
                                    token1:productProvider.products[0].registration_ids!,
                                    token2:productProvider.products[1].registration_ids!,
                                    order: orderList.toString());
                                })));
                              },
                              child: Text(
                                'Order',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              );
            } else {
              Center(
                child: Text(
                  'CART IS EMPTY',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              );
            }
            return Column(
              children: [
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  imageUrl:
                      'https://img.freepik.com/free-vector/order-food-concept-illustration_114360-6860.jpg?w=2000',
                ),
                Center(
                    child: Text('CART IS EMPTY',
                        style: TextStyle(fontSize: 32, color: Colors.black))),
                SizedBox(
                  height: 10,
                ),
                Text('Order now',
                    style: TextStyle(fontSize: 32, color: Colors.black38))
              ],
            );
          }),
        ),
      ),
    );
  }
}
