import 'package:drug_serialize/create_drug.dart';
import 'package:drug_serialize/dashboard.dart';
import 'package:drug_serialize/notificationService/local_notification_service.dart';
import 'package:drug_serialize/sign_in.dart';
import 'package:drug_serialize/sign_up.dart';
import 'package:drug_serialize/splash_screen.dart';
import 'package:drug_serialize/update_drug.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize() ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: SignIn.id,
      routes: {
        SignUp.id: (context) => SignUp(),
        SignIn.id: (context) => SignIn(),
        Dashboard.id: (context) => Dashboard(),
        CreateDrug.id: (context) => CreateDrug(),
        // UpdateDrug.id: (context) => UpdateDrug(),
      },
      home: SplashScreen(),
    );
  }
}

