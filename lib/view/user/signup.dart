import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/view/user/login.dart';
import 'package:machine_test/widgets/cust_container.dart';
import 'package:machine_test/widgets/cust_textfield.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  Future authenticationsignup(
      {required email,
      required name,
      required password,
      required BuildContext context}) async {
    try {
      var ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var docid = ref.user!.uid.toString();
      var data = {
        "email": email,
        "name": name,
        "pasword": password,
      };
      var dbref = FirebaseFirestore.instance
          .collection("Users")
          .doc(docid)
          .set(data);
      Fluttertoast.showToast(msg: "Success");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginscreen(),
          ));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: "failed");
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
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/loginimage.png")
                        )
                        ),
              ),
              const Text(
                "Register",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
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
              cust_textfield(controller: emailcontroller),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Name",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
             cust_textfield(controller: namecontroller),
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
              cust_textfield(controller: passcontroller),
              SizedBox(height: 30,),
              InkWell(
                onTap: () => authenticationsignup(
                    email: emailcontroller.text,
                    name: namecontroller.text,
                    
                    password: passcontroller.text,
                    context: context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: custcontainer(title: "Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

