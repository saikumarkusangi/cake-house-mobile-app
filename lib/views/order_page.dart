import 'dart:convert';
import 'package:cake_house_bakery/services/current_location.dart';
import 'package:cake_house_bakery/views/final_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cake_house_bakery/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../controllers/cart_provider.dart';
import '../db.dart';
import '../widgets/text_field_form.dart';

class OrderPage extends StatefulWidget {
   OrderPage({super.key,required this.order,required this.token1,required this.token2});
  String order ;
  String token1;
  String token2;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  
TextEditingController _nameController = TextEditingController();

TextEditingController _mobilenumberController = TextEditingController();

TextEditingController _addressController = TextEditingController();

TextEditingController _otherController = TextEditingController();
  
TextEditingController   _messageController = TextEditingController();
TextEditingController   _timeController    = TextEditingController();
 Location currentLocation = Location();
 
  double lat = 0;
 double lng = 0;
 
  void getLocation() async{
    var location = await currentLocation.getLocation();
    setState(() {
      print(location.latitude);
      lat = location.latitude!;
      lng = location.longitude!;
    });
  }
 
 final _form = GlobalKey<FormState>();

 void dispose() {
  
   super.dispose();
    _nameController.dispose();
    _mobilenumberController.dispose();
    _addressController.dispose();
    _otherController.dispose();
  }
 Future<dynamic> post()async{
        var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
       var client = http.Client();
        var _headers = {
          'authorization':'key=AAAA2DurIis:APA91bE7wNr0qnos9RX65efup1uA4wRmXwuraFE6RxTeVxSYXKZ8_6F_DIDC2Zc09BXXajxRWAXHr7xd_Y3H6RNSKijervQg2UC-YYQdaB9X_qOv9Jk90Tvy51X9tOsEzl1eZOd6AFhO',
          'Content-Type':'application/json',
          
        };

      try {
         var response = await client.post(url,body:jsonEncode({
          
    "registration_ids":["${widget.token1}","${widget.token2}"

    ],
    "notification":{
        "body":"Heyy got an new order hurry up!!!",
        "title":"New Order!!!",
        "android_channel_id":"new_order",
        "image":"https://cdn.dribbble.com/users/2760451/screenshots/5719658/notification.gif",
        "sound":true
    
}

        }),headers:_headers);
        
      } catch (e) {
        print(e.toString()); 
      }

        

  }
   
Db db = Db();
late DatabaseReference dbRef;
bool _isloading = false;
@override
void initState() { 
  super.initState();
   dbRef = FirebaseDatabase.instance.ref().child('order');
  setState(() {
      getLocation();
    });
}
  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase('cart');
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartController>(context);
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0,
  iconTheme: IconThemeData(color: Colors.black),
  backgroundColor: Colors.white,
title: Text("Order",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),

),
body: SingleChildScrollView(
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network('https://img.freepik.com/free-vector/order-ahead-concept-illustration_114360-7290.jpg?w=2000'),
        Form(
          key: _form,
          child: Container(
            height: MediaQuery.of(context).size.height/1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldForm(
                  controller: _nameController,
                  hintText: 'Enter your name',
                  ),
                   TextFormField(
                    keyboardType: TextInputType.number,
                       validator:(val){
      
          if(val == null || val.isEmpty || val.length <10  || val.length >10  ){
            return 'Enter valid number';
          }
          return null;
      } ,
              controller: _mobilenumberController,
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
                border:const  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38
            )
                ),
               focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
            width: 2,
                color:Colors.deepOrange
                )
              ) ,
              enabledBorder:const  OutlineInputBorder(
                borderSide: BorderSide(
                color:Colors.black38
                )
              )
              ),
              ),
                 
              TextFieldForm(
              controller: _addressController,
              hintText: 'Enter your address',
              ),
              TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Message on Cake',
                border:const  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38
            )
                ),
               focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
            width: 2,
                color:Colors.deepOrange
                )
              ) ,
              enabledBorder:const  OutlineInputBorder(
                borderSide: BorderSide(
                color:Colors.black38
                )
              )
              ),
              ),
              TextFormField(
              controller: _timeController,
              decoration: InputDecoration(
                hintText: 'Time of delivery',
                border:const  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38
            )
                ),
               focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
            width: 2,
                color:Colors.deepOrange
                )
              ) ,
              enabledBorder:const  OutlineInputBorder(
                borderSide: BorderSide(
                color:Colors.black38
                )
              )
              ),
              ),
              TextFormField(
              controller: _otherController,
              decoration: InputDecoration(
                hintText: 'Anything to say ?',
                border:const  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38
            )
                ),
               focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
            width: 2,
                color:Colors.deepOrange
                )
              ) ,
              enabledBorder:const  OutlineInputBorder(
                borderSide: BorderSide(
                color:Colors.black38
                )
              )
              ),
              ),
             
              
            MaterialButton(
                            textColor: Colors.white,
                            color: Colors.deepOrange,
                            onPressed: ()async {
                          var connection = await Connectivity().checkConnectivity();
                          if(connection == ConnectivityResult.none){
                              noConnection;
                           }else{
                              
                              if(_form.currentState!.validate()){
                        Map<String,String> orders = {
                        'name':_nameController.text,
                        'mobile':_mobilenumberController.text,
                        'address':_addressController.text,
                        'message':_messageController.text,
                        'time': _timeController.text,
                        'other':_otherController.text,
                        'orders':widget.order,
                        'lat':lat.toString(),
                        'lng':lng.toString()
                        };
                        setState(() {
                          _isloading = true;
                        });
                        try { 
                         
                         await dbRef.push().set(orders);
                          setState(() {
                          _isloading = false;
                        });
                        post();
                         showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Your Order Placed 🎉',style: TextStyle(fontSize: 24,color: Colors.black),),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
             
            
              Container(
                height: 80,
                width: 200,

                child: Image.network('https://cdn.dribbble.com/users/3955123/screenshots/7107965/image.gif',fit: BoxFit.cover,)),
                SizedBox(height: 5,),
                  Text('Set timer for 10 mins your order is arriving.',style: TextStyle(fontSize: 18,color: Colors.black),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok',style: TextStyle(fontSize: 24,color: Colors.black),),
            onPressed: () {
            
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => FinalPage())));
            
            },
          ),
        ],
      );
    },
  );
               
                        } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                       ) );
                        }
                    
                           }   
                           }   
                         },
                         
                         minWidth: 50,
                         height: 50,
                         child: _isloading ? (Center(child: CircularProgressIndicator(color: Colors.white,))) :  Text('Confirm Order',style: TextStyle(color: Colors.white,fontSize: 24),))
              ],
            ),
          ),
        ),
      
      ],
    ),
  ),
),
    );
  }
}
 

noConnection(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please check your internet!!'),
                         ));
}