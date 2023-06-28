import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drug_serialize/constant.dart';
import 'package:drug_serialize/dashboard.dart';
import 'package:flutter/material.dart';


class UpdateDrug extends StatefulWidget {
  static String id = "update" ;
  final String uid ;
  const UpdateDrug({Key? key, required this.uid}) : super(key: key);

  @override
  State<UpdateDrug> createState() => _UpdateDrugState();
}

class _UpdateDrugState extends State<UpdateDrug> {
  String? name, price, qty, type, gtin, serial, lot_numb, expire_date;
  bool showProgress = false ;

  final _firestore = FirebaseFirestore.instance ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers(widget.uid) ;
  }

  void getUsers(String uid) async {
    final usersData = await _firestore.collection("drug_details").doc(uid).get();
    if(usersData.exists){
      var dataObj = usersData.data() as Map;
      setState(() {
        name = dataObj['name'] ;
        price = dataObj['price'] ;
        qty = dataObj['quantity'] ;
        type = dataObj['type'] ;
        gtin = dataObj['GTIN'] ;
        serial = dataObj['serial_number'] ;
        lot_numb = dataObj['lot_number'] ;
        expire_date = dataObj['expire_date'] ;
      });
    }
  }

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
                          "Update Drug",
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 25,
                              color: Colors.teal,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0,),
                        //TODO:: name
                        TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            name = value ;
                          },
                          enabled: false,
                          controller:TextEditingController(text: name),
                          decoration: InputDecoration(
                            labelText: 'Enter your drug name',
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                        //TODO:: price
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            price = value;
                          },
                          enabled: false,
                          controller:TextEditingController(text: price),
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
                        //TODO:: quantity
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            qty = value;
                          },
                          enabled: false,
                          controller:TextEditingController(text: qty),
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
                        //TODO:: type
                        TextField(
                          onChanged: (value) {
                            type = value;
                          },
                          enabled: false,
                          controller:TextEditingController(text: type),
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
                        //TODO:: gtin
                        TextField(
                          onChanged: (value) {
                            gtin = value;
                          },
                          enabled: true,
                          controller:TextEditingController(text: gtin),
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
                        //TODO:: serial_number
                        TextField(
                          onChanged: (value) {
                            serial = value;
                          },
                          enabled: true,
                          controller:TextEditingController(text: serial),
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
                        //TODO:: lot number
                        TextField(
                          onChanged: (value) {
                            lot_numb = value;
                          },
                          enabled: true,
                          controller:TextEditingController(text: lot_numb),
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
                        //TODO:: expire date
                        TextField(
                          onChanged: (value) {
                            expire_date = value;
                          },
                          enabled: true,
                          controller:TextEditingController(text: expire_date),
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
                                    // print("----------------uid----------------") ;
                                    // print(widget.uid) ;
                                    final doc_id = await _firestore.collection("drug_details").doc(widget.uid).set({
                                      'name': name,
                                      'price': price,
                                      "quantity": qty,
                                      'type': type,
                                      'GTIN': gtin,
                                      "serial_number": serial,
                                      'lot_number': lot_numb,
                                      "expire_date": expire_date
                                    });
                                    setState(() {
                                      showProgress = false;
                                    });
                                    ToastMsg("Drug Updated Successful.");
                                    Navigator.pushNamed(context, Dashboard.id) ;
                                    // print("----===================--  doc_id : ${doc_id.id}") ;
                                    // if(doc_id.id != ""){
                                    //   setState(() {
                                    //     showProgress = false;
                                    //   });
                                    //   ToastMsg("Drug Updated Successful.");
                                    //   Navigator.pushNamed(context, Dashboard.id) ;
                                    // }
                                  }catch(e){
                                    print(e) ;
                                  }
                                }
                                else{
                                  ToastMsg("Fill up the all value") ;
                                }
                              },
                              minWidth: 150.0,
                              height: 42.0,
                              child: Text(
                                'Update',
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
