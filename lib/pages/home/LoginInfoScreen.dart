import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdo/models/LoginBloc.dart';

class LoginInfoScreen extends StatefulWidget {
  const LoginInfoScreen({super.key});

  @override
  State<LoginInfoScreen> createState() => _LoginInfoScreenState();
}

class _LoginInfoScreenState extends State<LoginInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var username = context.read<LoginBloc>().username;
    var password = context.read<LoginBloc>().password;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Username: $username', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Text('Password: $password', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
