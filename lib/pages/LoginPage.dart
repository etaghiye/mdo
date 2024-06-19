import 'package:flutter/material.dart';
import 'package:mdo/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

// -----------------------------------------------------------------------------
//
//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login'),
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
        //
        else if (value != _userName) {
          return 'Wrong username';
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
        //
        else if (value != _password) {
          return 'Wrong password';
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
      if (mounted) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const Homepage()));
      }
    }
  }

// -----------------------------------------------------------------------------
//
//
  void loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('username') ?? '';
    _password = prefs.getString('password') ?? '';
  }
}
