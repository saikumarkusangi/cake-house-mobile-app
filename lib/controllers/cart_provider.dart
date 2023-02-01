import 'package:cake_house_bakery/db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
class CartController with ChangeNotifier{
  
  List<Cart> cartItemsList = [];
  
  // addToCart(Cart cart){
  //   cartItemsList.add(cart);
  // }

  int counter = 0;

 

  int totalprice = 0;


   
    Db db = Db();

  late Future<List<Cart>> _cart;
    Future<List<Cart>> get cart => _cart;

    Future<List<Cart>> getData()async{
      _cart = db.getCartList();
      return _cart;
    }
   
    
   

  void _setPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', counter);
    prefs.setInt('total_price', totalprice);
    notifyListeners();
  }


  void _getPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt('cart_item') ?? 0;
    totalprice = prefs.getInt('total_price') ?? 0;
    notifyListeners();
  }

  void addCounter(){
    counter++;
    _setPrefItems();
    notifyListeners();
  }
  
  void removeCounter(){
    counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter(){
   _getPrefItems();
   return counter;
  }


  void addtotalPrice(int price){
    totalprice = totalprice + price;
    _setPrefItems();
    notifyListeners();
  }
  
  void removetotalPrice(int price){
    totalprice = totalprice - price;
    _setPrefItems();
    notifyListeners();
  }

  int gettotalPrice(){
   _getPrefItems();
   return totalprice;
  }


}

