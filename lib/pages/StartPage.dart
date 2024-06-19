import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdo/pages/home/HomePage.dart';

import '../helpers/Enums.dart';
import '../models/LoginBloc.dart';
import 'login/LoginPage.dart';
import 'login/RegistrationPage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is UnRegistered) {
        return _getRegistrationPage();
      }
      //
      else if (state is LoggedIn) {
        return _getHomePage();
      }
      //
      return _getLoginPage(state);
    });
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getRegistrationPage() {
    return RegistrationPage(onRegisterTap: (username, password) {
      context.read<LoginBloc>().setUsername(username);
      context.read<LoginBloc>().setPassword(password);
      context.read<LoginBloc>().add(LoginEvent.register);
    });
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getLoginPage(LoginState state) {
    return LoginPage(
      key: UniqueKey(),
      setError: state is WrongLogin ? true : false,
      onLoginTap: (username, password) {
        context.read<LoginBloc>().setUsername(username);
        context.read<LoginBloc>().setPassword(password);
        context.read<LoginBloc>().add(LoginEvent.logIn);
      },
    );
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getHomePage() {
    return const HomePage();
  }
}
