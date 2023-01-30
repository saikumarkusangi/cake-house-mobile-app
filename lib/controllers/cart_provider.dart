import 'package:cake_house_bakery/db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
class CartController with ChangeNotifier{

  int _counter = 0;

  int get counter => _counter;

  int _totalprice = 0;

  int get totalPrice => _totalprice;
   
    Db db = Db();

  late Future<List<Cart>> _cart;
    Future<List<Cart>> get cart => _cart;

    Future<List<Cart>> getData()async{
      _cart = db.getCartList();
      return _cart;
    }
   
    
   

  void _setPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setInt('total_price', _totalprice);
    notifyListeners();
  }


  void _getPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalprice = prefs.getInt('total_price') ?? 0;
    notifyListeners();
  }

  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }
  
  void removeCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter(){
   _getPrefItems();
   return _counter;
  }


  void addtotalPrice(int price){
    _totalprice = _totalprice + price;
    _setPrefItems();
    notifyListeners();
  }
  
  void removetotalPrice(int price){
    _totalprice = _totalprice - price;
    _setPrefItems();
    notifyListeners();
  }

  int gettotalPrice(){
   _getPrefItems();
   return _totalprice;
  }


}

