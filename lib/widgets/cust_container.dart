import 'package:flutter/material.dart';

class custcontainer extends StatelessWidget {
  const custcontainer({
    super.key,required this.title
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 270,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.green),
      child:  Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
