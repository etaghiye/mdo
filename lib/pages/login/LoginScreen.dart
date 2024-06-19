import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String username, String password) onLoginTap;
  final bool setError;
  const LoginScreen(
      {super.key, required this.onLoginTap, this.setError = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// -----------------------------------------------------------------------------
//
//
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            if (widget.setError)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text('username or password incorrect'),
              ),
            _getRegisterButton(),
          ],
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
      obscureText: true,
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
      onPressed: _login,
      child: const Text('Login'),
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLoginTap(_usernameController.text, _passwordController.text);
    }
  }
}
