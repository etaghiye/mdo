import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdo/helpers/Enums.dart';
import 'package:mdo/pages/home/ApiScreen.dart';
import 'package:mdo/pages/home/LoginInfoScreen.dart';
import 'package:mdo/pages/login/LoginScreen.dart';
import 'package:mdo/pages/login/RegistrationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/LoginBloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

// -----------------------------------------------------------------------------
//
//
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('username');
      prefs.remove('password');
      prefs.remove('registered');
      prefs.remove('loggedIn');
    });
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
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _getScreen(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: 'Api', icon: Icon(Icons.api)),
            BottomNavigationBarItem(label: 'Login', icon: Icon(Icons.login)),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _onItemTapped(int index) {
    _currentIndex = index;
    setState(() {});
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getScreen() {
    if (_currentIndex == HomePageScreen.api.index) {
      return const ApiScreen();
    }
    //
    else if (_currentIndex == HomePageScreen.loginInfo.index) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is UnRegistered) {
          return RegistrationScreen(onRegisterTap: (username, password) {
            context.read<LoginBloc>().setUsername(username);
            context.read<LoginBloc>().setPassword(password);
            context.read<LoginBloc>().add(LoginEvent.register);
          });
        }
        //
        else if (state is LoggedIn) {
          return const LoginInfoScreen();
        }
        //
        return LoginScreen(onLoginTap: (username, password) {
          context.read<LoginBloc>().setUsername(username);
          context.read<LoginBloc>().setPassword(password);
          context.read<LoginBloc>().add(LoginEvent.logIn);
        });
      });
    }

    //
    return const Center(child: Text('Something went wrong'));
  }
}
