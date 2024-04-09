import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:machine_test/view/user/login.dart';
import 'package:machine_test/widgets/cust_container.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key,});
 

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _curretuser;
  String email = "";
  String name = "";
  String pass = "";

  void getdetails() async {
    _curretuser = FirebaseAuth.instance.currentUser;

    if (_curretuser != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_curretuser!.uid)
        .get();
    setState(() {
      name = usersnapshot["name"];
      email = usersnapshot["email"];
      pass = usersnapshot["pasword"];
    });
  }

  void store() async {
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    Preferences.setBool("login", false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          title: const Center(child: Text("profile")),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 120),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?size=338&ext=jpg&ga=GA1.1.735520172.1710547200&semt=ais"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("name"),
                const SizedBox(
                  height: 10,
                ),
                custcontainer(title: name),
                const SizedBox(
                  height: 15,
                ),
                const Text("email"),
                const SizedBox(
                  height: 10,
                ),
                custcontainer(title: email),
                const SizedBox(
                  height: 15,
                ),
                const Text("password"),
                const SizedBox(
                  height: 10,
                ),
                custcontainer(title: pass),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      store();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginscreen(),
                          ));
                    },
                    child: const Text(
                      "logout account",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () async {
                      try {
                        _curretuser = FirebaseAuth.instance.currentUser;
                        await _curretuser!.delete();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Loginscreen(),
                            ));
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      "delete account",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
