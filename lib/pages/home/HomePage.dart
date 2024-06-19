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

  final List<Widget> _tabs = [
    const ApiScreen(),
    const LoginInfoScreen(),
    const RegistrationScreen(),
    const LoginScreen(),
  ];

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
      return _tabs[HomePageScreen.api.index];
    }
    //
    else if (_currentIndex == HomePageScreen.loginInfo.index) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is UnRegistered) {
          return _tabs[HomePageScreen.registration.index];
        }
        //
        else if (state is LoggedOut) {
          return _tabs[HomePageScreen.login.index];
        }
        //
        else if (state is LoggedIn) {
          return _tabs[HomePageScreen.loginInfo.index];
        }

        return const Center(child: Text('Something went wrong'));
      });
    }

    //
    return const Center(child: Text('Something went wrong'));
  }
}
