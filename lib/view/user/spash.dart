import 'package:flutter/material.dart';
import 'package:machine_test/controller/splash_con.dart';

import 'package:provider/provider.dart';


class Spashscreen extends StatelessWidget {
  const Spashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashprovider = Provider.of<Splashcontroller>(context, listen: true);
    Future.delayed(const Duration(seconds: 4))
        .whenComplete(() => splashprovider.checklogin(context));
    return const Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Text(
            "USERAPP",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ));
  }
}

//final splashprovider = Provider.of<Splashcontrol1er>(context, listen: true);
