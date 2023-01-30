import 'dart:convert';
import 'package:cake_house_bakery/models/product_model.dart';
import "package:dio/dio.dart";

import '../consts/constants.dart';


class NetworkManager {    

static var dio = Dio();

static Future<List<ProductModel>> fetchProduct() async{
  
  var response = await dio.get(uri);
  
  if (response.statusCode == 200) 
  {
    final List<dynamic> data =  response.data;
    return data.map((item) => ProductModel.fromJson(item)).toList();
    
  }else{
    throw Exception('Something went wrong!!!');
  }
 
}


}