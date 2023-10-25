import 'package:flutter/material.dart';
import 'package:medking/screens/splash_screen.dart';
import 'package:medking/screens/register_screen.dart';
import 'package:medking/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the Home Screen!"),
           
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => RegisterScreen()));
                 
                // Navigate to the Register screen
                // You can add navigation logic here
              },
              child: Text("Register"),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=> LoginScreen())
                );
                // Navigate to the Login screen
                // You can add navigation logic here
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
