import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Check the user's status in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('userRequests')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists && userDoc['status'] == false) {
          // User status is false, show error message and sign out
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Godkjenning av bruker pågår, vennligst vent'),
          ));
          await FirebaseAuth.instance.signOut();
        } else {
          // User status is true, proceed to cache rights and navigate to home page
          await _cacheUserRights(userCredential.user!.uid);
          
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login successful'),
          ));
          Navigator.pushReplacementNamed(context, '/'); // Navigate to home page
        }
      } on FirebaseAuthException catch (e) {
        // Handle login error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to login: ${e.message}'),
        ));
      }
    }
  }

  Future<void> _cacheUserRights(String userId) async {
    try {
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('activeUsers').doc(userId).get();

      if (userDoc.exists) {
        List<String> adminAccesses = List<String>.from(userDoc['adminAccess'] ?? []);

        // Store rights in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('adminAccesses', adminAccesses);
      }
    } catch (e) {
      print('Error fetching user rights: $e');
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Velkommen',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-postadresse',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Passord',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0D47A1)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text('Logg inn'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _resetPassword,
                        child: const Text(
                          'Glemt passord/brukernavn?',
                          style: TextStyle(color: Color(0xFF0D47A1)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register'); // Navigate to the register page
                        },
                        child: const Text(
                          'Har du ikke konto? Registrer deg',
                          style: TextStyle(color: Color(0xFF0D47A1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
