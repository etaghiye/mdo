import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.title});

  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                _getUserNameField(),
                const SizedBox(height: 20),
                _getPasswordField(),
                const SizedBox(height: 40),
                _getRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getUserNameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getRegisterButton() {
    return ElevatedButton(
      onPressed: _register,
      child: const Text('Register'),
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);

      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');

      if (mounted) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    }
  }
}