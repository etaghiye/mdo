import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdo/models/LoginBloc.dart';
import 'package:mdo/pages/home/HomePage.dart';
import 'package:mdo/pages/login/LoginPage.dart';
import 'package:mdo/pages/login/RegistrationPage.dart';

import 'helpers/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => LoginBloc(),
        child: const Homepage(),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.homePage: (_) => const Homepage(),
        Routes.registrationPage: (_) => const RegistrationPage(),
        Routes.loginPage: (_) => const LoginPage(),
      },
    );
  }
}
