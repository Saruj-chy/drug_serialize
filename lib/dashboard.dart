import 'package:drug_serialize/create_drug.dart';
import 'package:drug_serialize/notificationService/local_notification_service.dart';
import 'package:drug_serialize/sign_in.dart';
import 'package:drug_serialize/update_drug.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'firebase_messaging.dart';


class Dashboard extends StatefulWidget {
  static String id = "dashboard";
  static String admin = "Admin" ;
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth =  FirebaseAuth.instance ;
  final _firestore = FirebaseFirestore.instance;
  late String email, uid, type = "Patient" ;



  @override
  void initState() {
    super.initState();
    // getMessages() ;
    getCurrentUSer() ;

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );


  }




  void getMessages() async {
    final messages = await _firestore.collection("drug_details").get();
    // print(messages.docs) ;
    for (var message in messages.docs) {
      print("-------------================================-----------------") ;
      print(message.data());
    }
  }
  void getCurrentUSer () async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token") ;
    print(fcmToken) ;

    try{
      final user = await _auth.currentUser ;
      // await FirebaseMsg().initNotification() ;
      if(user != null){
        email = user.email! ;
        uid = user.uid ;
        getUsers(uid) ;
      }
    }catch(e){
      print(e);
    }

  }
  void getUsers(String uid) async {
    final usersData = await _firestore.collection("users").doc(uid).get();
    if(usersData.exists){
      var dataObj = usersData.data() as Map;
      setState(() {
        type = dataObj['type'] ;
      });
    }
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit from the App?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              _auth.signOut(),
              Navigator.pushNamed(context, SignIn.id)
            }
            ,
            child: new Text('Signout'),
          ),
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
        onWillPop: (){
          return Future(() {
            // return true ;
            return _onWillPop() ;
          });
        },
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.blue,
            title: Text('Dashboard', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30.0),),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              type==Dashboard.admin ?
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, CreateDrug.id) ;
                  },
                ) : Container()
            ],
          ),
          // backgroundColor: Colors.green,
          body: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("drug_details").orderBy("serial_number", descending: false).snapshots(),
                  builder: (context, snapshot) {
                    List<DrugContainer> drugWidgets = [];
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height/1.2,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    }
                    final drug_details = snapshot.data!.docs.reversed;
                    // print(drug_details) ;

                    for (var drug in drug_details) {
                      var data = drug.data() as Map;
                      final name = data['name'];
                      final price = data['price'];
                      final quantity = data['quantity'];
                      final type = data['type'];
                      final gtin = data['GTIN'];
                      final serial_number = data['serial_number'];
                      final lot_number = data['lot_number'];
                      final expire_date = data['expire_date'];
                      final docId = drug.id ;

                      final messageBubble = DrugContainer(
                        name: name,
                        price: price,
                        quantity: quantity,
                        type: type,
                        gtin: gtin,
                        serial_number: serial_number,
                        lot_number: lot_number,
                        expire_date: expire_date,
                        docId: docId,
                      );
                      drugWidgets.add(messageBubble);
                    }

                    return Expanded(child: ListView(
                      // reverse: true,
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      children: drugWidgets,
                    ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
    );
  }

  
}


class DrugContainer extends StatelessWidget {
  DrugContainer({required this.name, required this.price, required this.quantity, required this.type,
    required this.gtin, required this.serial_number, required this.lot_number, required this.expire_date, required this.docId });
  final String name, price, quantity, type, gtin, serial_number, lot_number, expire_date, docId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$name',
                      style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, UpdateDrug.id) ;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateDrug(
                        uid: docId,
                        ),
                        ),);
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(

                      'price: $price',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'quantity: $price',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(

                      'type: $type',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'GTIN: $gtin',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(

                      'Serial Number: $serial_number',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'LOT Number : $lot_number',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Text(
                'Expire Date: $expire_date',
                style: TextStyle(color: Colors.white, fontSize: 18.0, ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
