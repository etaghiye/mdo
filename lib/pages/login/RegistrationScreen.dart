import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/Enums.dart';
import '../../models/LoginBloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      onPressed: _onRegisterTap,
      child: const Text('Register'),
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _onRegisterTap() async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().setUsername(_usernameController.text);
      context.read<LoginBloc>().setPassword(_passwordController.text);
      context.read<LoginBloc>().add(LoginEvent.register);
    }
  }
}