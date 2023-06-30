import 'dart:io';

import 'package:drug_serialize/constant.dart';
import 'package:drug_serialize/dashboard.dart';
import 'package:drug_serialize/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/services.dart';


class SignIn extends StatefulWidget {
  static String id = "sign_in" ;
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email, password;
  final _auth = FirebaseAuth.instance ;
  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0) ;

        // //trigger leaving and use own data
        // SystemNavigator.pop() ;

        //we need to return a future
        return Future.value(true);
      },
      child: Scaffold(
        // appBar: AppBarComp(text: "Mi Card", mCtx: context,),
        body: SafeArea(

          child: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage("images/drug_serialize.jpg"),
                      ),
                      Text(
                        "Drug Serialize",
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 25,
                            color: Colors.blue,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 100.0,),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          //Do something with the user input.
                          email = value ;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter your email',
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter your password.',
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              if(email != null && password != null){
                                setState(() {
                                  showProgress = true ;
                                });
                                try{
                                  final user = await _auth
                                      .signInWithEmailAndPassword(email: email!,
                                      password: password!) ;

                                  if (user != null){
                                    Navigator.pushNamed(context, Dashboard.id) ;
                                  }

                                }catch(e){
                                  setState(() {
                                    showProgress = false;
                                  });
                                  print(e) ;
                                  ToastMsg("Sign in Unsuccessful.") ;
                                }

                              }
                              else{
                                ToastMsg("Fill up the all fields") ;
                              }


                            },
                            minWidth: 150.0,
                            height: 42.0,
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignUp.id) ;

                        },
                        child: Container(
                          child: Text(
                            "create a new account?",
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 15,
                                color: Colors.blue,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: showProgress,
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: SizedBox(

                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    ),
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
