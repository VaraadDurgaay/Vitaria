import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vitaria/loginpage.dart';
import 'dart:convert';
import 'otpverify.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _gender;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to handle sign-up API call
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://vitaria.onrender.com/auth/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': _nameController.text,
        'email': _emailController.text,
        'age': int.parse(_ageController.text),
        'gender': _gender,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Sign-up successful, navigate to OTP verification page
      final responseData = json.decode(response.body);
      print('Sign-up successful: $responseData');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Sign-up failed
      print(response.statusCode);
      final errorData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: ${errorData['detail']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0), // Add bottom padding here
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                    Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 10.0), // Reduced bottom padding
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'Assets/images/vitarialogo.png',
                        width: double.infinity,
                        height: 150.0, // Adjusted height
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                     
                      Padding(
                        padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 20.0), 
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'CREATE AN ACCOUNT',
                                    style: TextStyle(
                                      fontFamily: 'Noto Sans JP',
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'Fill out the information below to create your account.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your name...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter email address...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _ageController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your age...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your age';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Enter password...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm password...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  DropdownButtonFormField<String>(
                                    value: _gender,
                                    decoration: InputDecoration(
                                      labelText: 'Select your gender...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.surface,
                                    ),
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _gender = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your gender';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  ElevatedButton(
                                    onPressed: _isLoading ? null : _signUp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0B9B93),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontFamily: 'Inter Tight',
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextButton(
                                    onPressed: () {
                                      // Static navigation to login page
                                      print('Navigate to Login');
                                      Navigator.pushReplacementNamed(context, '/login');
                                    },
                                    child: const Text(
                                      'Already have an account? Login here',
                                      style: TextStyle(
                                        color: Color(0xFF160B86),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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