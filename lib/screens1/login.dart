import 'package:crud_app/screens/list_student.dart';
import 'package:crud_app/screens1/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMesssage = '';
  bool password = false;

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMesssage = 'Please enter both username and password';
      });
    } else if (username == savedUsername && password == savedPassword) {
      await prefs.setBool('isLoggedIn', true);
      _navigateToHome();
    } else {
      setState(() {
        _errorMesssage = 'Invalid username or password';
      });
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ListStudent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  onPressed: () {
                    setState(() {
                      password = !password;
                    });
                  },
                  icon: password == true
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              _errorMesssage,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
