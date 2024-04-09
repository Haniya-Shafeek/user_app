import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/view/admin/userlist.dart';
import 'package:machine_test/view/user/home.dart';

import 'package:machine_test/view/user/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splashcontroller extends ChangeNotifier {
 bool? userlogin; 
  bool? adminlogin;
  FirebaseAuth auth = FirebaseAuth.instance;
   void checklogin(context) async {
    SharedPreferences adPreferences = await SharedPreferences.getInstance();
    adminlogin = adPreferences.getBool("adlogin")??false;
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    userlogin = Preferences.getBool("login");
   if (adminlogin!) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Userdetailsscreen(),
          ));
    } else if (userlogin == false || userlogin == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginscreen(),
          ));
    } else if (userlogin == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));
    }
  }
}
