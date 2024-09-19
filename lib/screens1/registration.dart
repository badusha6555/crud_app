import 'package:crud_app/screens/list_student.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMesssage = '';
  bool password = false;

  Future<void> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMesssage = 'Please enter both username and password';
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ListStudent()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: () {},
                  icon: password == true
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              _errorMesssage,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: _register,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
