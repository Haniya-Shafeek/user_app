import 'package:flutter/material.dart';
import 'package:machine_test/model/usermodel.dart';

class Singlescreen extends StatelessWidget {
  const Singlescreen({super.key, required this.employee});
  final User employee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID: ${employee.id}",style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 10,
            ),
            Text("Name: ${employee.employeeName}",style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 10,
            ),
           Text("Age: ${employee.employeeAge}",style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 10,
            ),
           Text("Salary: ${employee.employeeSalary}",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
