import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String studentName = "John Doe"; // Replace with dynamic data if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[100],
              ),
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              studentName, // Display the student's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
