
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';import 'package:cake_house_bakery/catergory/appbar.dart';
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Widget build(BuildContext context) {
  
    return Scaffold(
    
      backgroundColor: Colors.white,
      body: CategoryApp());
  }
}