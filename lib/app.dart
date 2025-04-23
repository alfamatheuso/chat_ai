import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final bool hasConfig;

  App({required this.hasConfig});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: hasConfig ? '/chat' : '/config',
      routes: {
        '/config': (_) => ConfigPage(),
        '/chat': (_) => ChatPage(),
      },
    );
  }
}