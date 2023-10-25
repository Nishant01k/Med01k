import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medking/screens/admin_dashboard.dart';
import 'package:medking/screens/doctor_dashboard.dart';
import 'package:medking/screens/users_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  Future<void> _loginUser(BuildContext context) async {
  final String email = _emailController.text.trim();
  final String password = _passwordController.text.trim();

  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user == null) {
      // Handle the case where the user is not authenticated
      return;
    }

    // After a user is authenticated, you can access their UID like this
    String? uid = user.uid;

    if (uid != null) {
      // Fetch user role from the Realtime Database using the UID
      final DatabaseEvent event = await databaseReference.child('Users').child(uid).once();
      final DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? userData = snapshot.value as Map<dynamic, dynamic>?;
      if (userData != null) {
        final String? role = userData['role'];

        if (role != null) {
          if (role == 'admin') {
            // User role logic
            // Fetch and display user-specific data
            print('User Role: User');
            print('User Data: $userData');

            // Redirect to UsersDashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboard(),
              ),
            );
          } else if (role == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UsersDashboard(),
              ),
            );
            // Admin role logic
            // Redirect to AdminDashboard or perform admin-specific actions
            print('User Role: Admin');

          }else if (role == 'doctor'){
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>DoctorDashboard()),
            );
          }
         else {
            print('Unknown Role: $role');
          }
        } else {
          print('Role is not defined in user data.');
        }
      } else {
        print('User data not found');
      }
    } else {
      print('User UID is not available.');
    }
  } catch (e) {
    // Handle login errors, e.g., invalid email or password
    print('Error: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login Here"),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  _loginUser(context);
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
