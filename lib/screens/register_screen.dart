import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medking/screens/home_screen.dart';
import 'package:toast/toast.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('Users');

  Future<void> _registerUser(BuildContext context) async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {

      //need logic
    }

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );

      final User? user = userCredential.user;

  if (user != null) {
    final String uid = user.uid;

    // Store user data in Firebase Realtime Database
    _userRef.child(uid).set({
      'username': username,
      'email': email,
      'password': password,
      'role': 'user',
      // Add more user data as needed
    });

    // Navigate to a new screen or perform any other post-registration actions
    // Example:
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => HomeScreen()));
  }
} catch (e) {
  // Handle registration errors, e.g., email already in use
  print('Error: $e');
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register Here"),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
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
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  _registerUser(context);
                  // Add registration logic here
                  // You can access the field values like _usernameController.text
                  // Validate input, register the user, etc.
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
