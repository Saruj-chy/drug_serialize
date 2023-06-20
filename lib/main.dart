import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginScreen());
}

late final FirebaseAuth _auth ;

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final firebaseUser = Firebase.initializeApp() ;


  String email = "" ;
  String password="" ;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      _auth = FirebaseAuth.instance;
      setState(() {});
    });
  }


  Future<User> handleSignUp(email, password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Login Authentication"), centerTitle: true,),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50,10,50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    onChanged: (value){
                      setState(() {
                        email = value;
                      });
                    },

                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      // hintText: 'Description of progress',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    onChanged: (value){
                      setState(() {
                        password = value;
                      });
                    },

                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      // hintText: 'Description of progress',
                    ),
                  ),

                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.pink,
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(0)
                      ),
                      onPressed: () async {
                        print('object') ;
                        print(email) ;
                        print(password) ;

                        try{
                          // final FirebaseAuth auth = FirebaseAuth.instance;

                          // final newUsers = auth.signInWithEmailAndPassword(email: email, password: password) ;
                          // print(newUsers);
                          // if(newUsers != null){
                          //   Navigator.pushNamed(context, '/screen_4');
                          // }


                          // var user = handleSignUp(email, password) ;
                          // print("user  $user") ;

                          // Navigator.pushNamed(context, '/screen_4');


                          final FirebaseAuth auth = FirebaseAuth.instance;

                          UserCredential result = await auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          final User user = result.user!;
                          var emailStr = user.email;
                          print("user  $user   $emailStr") ;
                          print("result  $result") ;


                        }catch(e){
                          print(e) ;
                        }

                      },

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,5,10,5),
                        child: Text("Submit", style: TextStyle(fontSize: 16), ),
                      )),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result =
    await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }
}


