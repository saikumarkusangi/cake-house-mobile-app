
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';import 'package:cake_house_bakery/catergory/appbar.dart';
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      body: CategoryApp());
  }
}