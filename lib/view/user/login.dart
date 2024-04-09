import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/utilities/costants.dart';
import 'package:machine_test/view/admin/userlist.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/view/user/home.dart';

import 'package:machine_test/view/user/signup.dart';
import 'package:machine_test/widgets/cust_container.dart';
import 'package:machine_test/widgets/cust_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailcntrller = TextEditingController();
  final TextEditingController passcntrller = TextEditingController();
  Future authenticatinlogin(
      {required email, required password, required context}) async {
    try {
      var reference = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = reference.user;
      if (user!.uid == appconstants().adminId) {
        SharedPreferences adPreferences = await SharedPreferences.getInstance();
        adPreferences.setBool("adlogin", true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const  Userdetailsscreen();
          },
        ));
      } else {
        SharedPreferences Preferences = await SharedPreferences.getInstance();
        Preferences.setBool("login", true);

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const Homepage();
          },
        ));
      }
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "error", backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                width: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/loginimage.png"))),
              ),
              const Text(
                "Email",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              cust_textfield(controller: emailcntrller),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              cust_textfield(
                controller: passcntrller,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => authenticatinlogin(
                    email: emailcntrller.text,
                    password: passcntrller.text,
                    context: context),
                child: Padding(
                    padding: const EdgeInsets.only(left: 29),
                    child: custcontainer(title: "Log In")),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Text(
                      "you don't have an account?",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signupscreen(),
                          )),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
