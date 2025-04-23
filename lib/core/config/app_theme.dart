import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey.shade100,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 26,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}