import 'package:cached_network_image/cached_network_image.dart';
import 'package:cake_house_bakery/controllers/product_controller.dart';
import 'package:cake_house_bakery/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_provider.dart';
import '../models/cart_model.dart';

class DetailsPage extends StatefulWidget {
  String image, name, description, offer, unitTag;
  int price, initialPrice;
  int id, quantity;

  DetailsPage(
      {required this.initialPrice,
      required this.id,
      required this.unitTag,
      required this.quantity,
      required this.offer,
      required this.image,
      required this.price,
      required this.name,
      required this.description});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Db? db = Db();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductController>(context);
    final cartProvider = Provider.of<CartController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            Stack(children: [
              Hero(
                  tag: widget.name,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.cover,
                           errorWidget: (context, url, error) => Image.network('https://demofree.sirv.com/products/123456/123456.jpg?profile=error-example'),
               ) ),
              SizedBox(
                  height: 80,
                  child: Image.network(widget.offer.isEmpty
                      ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                      : widget.offer)),
            ]),
            SizedBox(height: 20.0),
            Center(
              child: Text('₹ ${widget.price}',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange)),
            ),
            SizedBox(height: 10.0),
            Container(
              
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(widget.name,
                overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xFF575E67),
                        fontFamily: 'Varela',
                        fontSize: 24.0)),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(widget.description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 144, 146, 146))),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
                child: GestureDetector(
              onTap: (() {
                 print(cartProvider.cartItemsList);
                           if( cartProvider.cartItemsList.any((element) => element.name == widget.name)){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Already added to Bag'),
                         ) );
                                }else{
                               try {
                                 cartProvider.addCounter();
                                 cartProvider.addtotalPrice(widget.price);
                                   cartProvider.cartItemsList.add(
                                   Cart(
                                    initialPrice: widget.initialPrice,
                                    image:widget.image,
                                     name: widget.name, 
                                     price: widget.price, 
                                     id: widget.id, 
                                     quantity: 1, 
                                     unitTag: widget.name
                                     )
                                );
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Added to Bag'),
                         ) );
                               } catch (e) {
                                 print(e); 
                               }}
                // db!
                //     .insert(Cart(
                //         initialPrice: widget.initialPrice,
                //         image: widget.image,
                //         name: widget.name,
                //         price: widget.price,
                //         id: widget.id,
                //         quantity: 1,
                //         unitTag: widget.unitTag))
                //     .then((value) {
                //   cartProvider.addtotalPrice(widget.price);

                //   cartProvider.addCounter();
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text('Added to Bag'),
                //   ));
                // }).onError((error, stackTrace) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text('Already added to Bag'),
                //   ));
                // });
              }),
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.deepOrange),
                  child: Center(
                      child: Text(
                    'ADD TO BAG',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))),
            ))
          ]),
    );
  }
}
