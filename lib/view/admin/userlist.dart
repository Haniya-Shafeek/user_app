import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/view/user/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdetailsscreen extends StatefulWidget {
  const Userdetailsscreen({super.key});

  @override
  State<Userdetailsscreen> createState() => _UserdetailsscreenState();
}

class _UserdetailsscreenState extends State<Userdetailsscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          title: const Center(child: Text("Users")),
          actions: [
            TextButton(
                onPressed: () async {
                  SharedPreferences adPreferences =
                      await SharedPreferences.getInstance();
                  adPreferences.setBool("adlogin", false);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Loginscreen(),
                      ));
                },
                child: const Text("Log out"))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.docs[index].get("email")),
                      Text(snapshot.data!.docs[index].get("name")),
                      Text(snapshot.data!.docs[index].get("pasword")),
                    ],
                  ));
                },
              );
            } else {
              return const Center(
                child: Icon(Icons.error),
              );
            }
          },
        ),
      ),
    );
  }
}
