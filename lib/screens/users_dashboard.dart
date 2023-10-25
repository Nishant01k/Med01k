import 'package:flutter/material.dart';

class UsersDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the users Screen!"),
           
            SizedBox(height: 20.0),
            
          ],
        ),
      ),
    );
  }
}
