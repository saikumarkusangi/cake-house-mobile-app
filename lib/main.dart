
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:cake_house_bakery/catergory/appbar.dart';
import 'package:cake_house_bakery/controllers/cart_provider.dart';
import 'package:cake_house_bakery/controllers/product_controller.dart';
import 'package:cake_house_bakery/services/current_location.dart';
import 'package:cake_house_bakery/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);


  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
    Future.delayed(const Duration(seconds: 3));
      FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_)=> ProductController()),
        ChangeNotifierProvider(create: (_)=> CartController()),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cake House',
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
        home:  HomePage()
      ),
    );
  }
}
 initialization() async {
    return Builder(
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Color.fromARGB(255, 1, 36, 63),
          child: SizedBox(
            height: MediaQuery.of(context).size.height/2,
            width: double.infinity,
            child:Image.asset('assets/images/logo.jpeg',fit: BoxFit.cover,)
          ),
        );
      }
    );
    
  
  }