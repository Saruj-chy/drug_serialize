import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseMsg {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission() ;
    final fCMToken = await _firebaseMessaging.getToken() ;
    print("----------------------------------------------------") ;
    print('Token $fCMToken') ;
  }

}
