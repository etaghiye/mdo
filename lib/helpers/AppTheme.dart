import 'package:flutter/material.dart';

import 'AppPallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    // appBarTheme: AppBarTheme(color: AppPallete.backgroundColor),
  );
}
