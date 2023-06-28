import 'package:drug_serialize/constant.dart';
import 'package:drug_serialize/dashboard.dart';
import 'package:drug_serialize/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  static String id = "sign_up";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firestore = FirebaseFirestore.instance;
  var items = [
    'Manufacturer',
    'Distributor',
    'Pharmacy',
    'Hospital',
    'Doctor',
    'Patient'
  ];
  String dropdownvalue = "Manufacturer";
  String? email, password, uid;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  Future<bool> _onWillPop() async {
    print("wil popup");
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() {
          return true;
          // return _onWillPop() ;
        });
      },
      child: Scaffold(
        // appBar: AppBarComp(text: "Mi Card", mCtx: context,),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            AssetImage("images/drug_serialize.jpg"),
                      ),
                      Text(
                        "Drug Serialize",
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 25,
                            color: Colors.teal,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          //Do something with the user input.
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter your email',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DropdownButton(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        iconSize: 30.0,
                        // focusColor: Colors.red,
                        // dropdownColor: Colors.green,
                        hint: Text("Select a item"),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                        isExpanded: true,
                        value: dropdownvalue,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
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
                              if (email != null && password != null) {
                                setState(() {
                                  showProgress = true;
                                });

                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email!, password: password!);
                                  uid = newUser.user!.uid;
                                  print(newUser.user?.uid);

                                  if (newUser != null) {
                                    _firestore
                                        .collection("users")
                                        .doc(uid)
                                        .set({
                                      'email': email,
                                      'password': password,
                                      "type": dropdownvalue
                                    });
                                    Navigator.pushNamed(context, Dashboard.id);
                                    ToastMsg("Signup Successful") ;
                                  }
                                  setState(() {
                                    showProgress = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    showProgress = false;
                                  });
                                  print(e);
                                  ToastMsg("Sign up Unsuccessful.");
                                }
                              }
                            },
                            minWidth: 150.0,
                            height: 42.0,
                            child: Text(
                              'Sign Up',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignIn.id);
                        },
                        child: Container(
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 15,
                                color: Colors.teal,
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
                        backgroundColor: Colors.red,
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
