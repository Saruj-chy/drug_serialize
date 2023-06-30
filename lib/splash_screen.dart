import 'dart:async';

import 'package:drug_serialize/dashboard.dart';
import 'package:drug_serialize/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = "splash_screen" ;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth =  FirebaseAuth.instance ;
  final _firestore = FirebaseFirestore.instance;
  late String email, uid, type = "Patient" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      const Duration(seconds: 10),
          () {
        print("push") ;
        // Navigate to your favorite place
            getCurrentUSer() ;
      },

    );

  }

  void getCurrentUSer () async {
    try{
      final user = await _auth.currentUser ;
      if(user != null){
        email = user.email! ;
        uid = user.uid ;
        Navigator.pushNamed(context, Dashboard.id) ;

      }else{
        Navigator.pushNamed(context, SignIn.id) ;
      }

    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                CircleAvatar(
                  radius: 150.0,
                  backgroundImage: AssetImage("images/drug_serialize.jpg"),
                ),
                SizedBox(height: 50,),
                Text(
                  "Drug Serialize",
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 40,
                      color: Colors.teal,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
