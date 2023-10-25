import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medking/screens/home_screen.dart';
import 'package:medking/screens/users_dashboard.dart'; // Replace with your dashboard screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

 void navigateToScreen() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? currentUser = _auth.currentUser;

    //if (currentUser != null) {
      //final String userType = ''; // Retrieve the user type from your database
     // if (userType == 'user') {
       // Navigator.pushReplacement(
         // context,
          //MaterialPageRoute(
            //builder: (context) => UsersDashboard(),
         // ),
        //);
      //} else {
        // Navigate to other dashboard or screen for admins, etc.
      //}
    //} else {
      // User not logged in, navigate to the home screen
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      );
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 100.0),
            SizedBox(height: 16.0),
            Text("My Splash App", style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
