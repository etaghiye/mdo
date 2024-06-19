import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdo/helpers/AppTheme.dart';
import 'package:mdo/pages/StartPage.dart';

import 'models/LoginBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: MaterialApp(
        theme: AppTheme.darkThemeMode,
        home: const StartPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
