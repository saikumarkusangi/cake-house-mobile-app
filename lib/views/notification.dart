import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  String deviceTokenTosendNotification = '';
  @override
  void initState() { 
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message){
      print('firebasemessaging instance getinitialmesage');
      if(message != null){
        print('new message');
    }});

  FirebaseMessaging.onMessage.listen((message) {
    print('onmessage listen');
    if(message.notification != null){
      print(message.notification!.body);
       print(message.notification!.title);
       
    }
   });


   

  }

  Future<void> getDeviceToken() async{
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenTosendNotification = token.toString();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
 