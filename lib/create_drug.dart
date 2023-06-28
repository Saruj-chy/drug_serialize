import 'package:drug_serialize/constant.dart';
import 'package:drug_serialize/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CreateDrug extends StatefulWidget {
  static String id = "create" ;
  const CreateDrug({Key? key}) : super(key: key);

  @override
  State<CreateDrug> createState() => _CreateDrugState();
}

class _CreateDrugState extends State<CreateDrug> {
  String? name, price, qty, type, gtin, serial, lot_numb, expire_date;
  bool showProgress = false ;

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
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
                          "New Drug",
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 25,
                              color: Colors.teal,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0,),
                        TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            name = value ;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter your drug name',
                            enabled: false,
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
                        ),//drug name
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            price = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter drug price.',
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
                          height: 10.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            qty = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter drug quantity',
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
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            type = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter drug type',
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
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            gtin = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter drug GTIN number.',
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
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            serial = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter drug serial number',
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
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            lot_numb = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter LOT number',
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
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            expire_date = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter expiry date',
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

                                // print("======================================================="+name!) ;
                                // print(name+" "+ price +"  "+ qty +"  "+ type +"  "+ gtin +"  "+ serial +"  "+ lot_numb +"  "+ expire_date);
                                // print( email +"   "+ password ) ;
                                if(name !=null && price !=null && qty != null && type!=null&& gtin!=null && serial !=null && lot_numb != null && expire_date != null )
                                {
                                  setState(() {
                                    showProgress = true ;
                                  });
                                  try{
                                    final doc_id = await _firestore.collection("drug_details").add({
                                      'name': name,
                                      'price': price,
                                      "quantity": qty,
                                      'type': type,
                                      'GTIN': gtin,
                                      "serial_number": serial,
                                      'lot_number': lot_numb,
                                      "expire_date": expire_date
                                    });
                                    print("----===================--  doc_id : ${doc_id.id}") ;
                                    if(doc_id.id != ""){
                                      setState(() {
                                        showProgress = false;
                                      });
                                      ToastMsg("New Drug Added Successful.");
                                      Navigator.pushNamed(context, Dashboard.id) ;
                                    }
                                  }catch(e){
                                    print(e) ;
                                  }
                                }
                                else{
                                  ToastMsg("Fill up the all value") ;

                                  // Fluttertoast.showToast(
                                  //     msg: "Fill up the all value",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.BOTTOM,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.black,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0
                                  // );
                                }


                              },
                              minWidth: 150.0,
                              height: 42.0,
                              child: Text(
                                'Create',
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
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
