import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AppBarComp extends StatelessWidget implements PreferredSizeWidget {
  final String text ;
  final BuildContext mCtx ;
  final bool iconShow;
  AppBarComp({required this.text, required this.mCtx, this.iconShow = false }) ;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: new IconButton(
        icon: iconShow ? new Icon(Icons.arrow_back, color: Colors.white) : new Icon(Icons.arrow_back, color: Colors.green) ,
        onPressed: (){
          print("back button") ;
          Navigator.pop(mCtx);
        },
      ),
      title:Text(text),
      backgroundColor: Colors.black26,
    );
  }
}

// class ToastMessage extends StatelessWidget {
//   ToastMessage({ required this.msg}) ;
//   final String msg ;
//
//   @override
//   Widget build(BuildContext context) {
//     return Fluttertoast.showToast(
//         msg: "Fill up the all value",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//   }
// }
Future<bool?> ToastMsg(String msg) {
  return Fluttertoast.showToast(
      msg:msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

// Future<bool> _onWillPop(BuildContext context) async {
//   print("wil popup") ;
//   return (await showDialog(
//     context: context,
//     builder: (context) => new AlertDialog(
//       title: new Text('Are you sure?'),
//       content: new Text('Do you want to exit an App'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: new Text('No'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(true),
//           child: new Text('Yes'),
//         ),
//       ],
//     ),
//   ));
// }





