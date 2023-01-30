
import 'package:cake_house_bakery/models/product_model.dart';
import 'package:flutter/material.dart';

import '../services/network_manager.dart';

class ProductController extends ChangeNotifier{
  int length = 4;
  
  bool isLoading = false;
  List<ProductModel> products  =[];
   
   ProductController(){
    fetchProducts();
  }

Future<void> fetchProducts() async {
  isLoading = true;
  notifyListeners();
  products = await NetworkManager.fetchProduct();
  length = products.length;
  isLoading = false;
  notifyListeners();
}

}