import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final bool hasConfig;

  App({required this.hasConfig});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: hasConfig ? '/prompt' : '/config',
      routes: {
        '/config': (_) => ConfigPage(),
        '/prompt': (_) => PromptPage(),
        '/loading': (_) => LoadingPage(),
        '/terminal': (_) => TerminalPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
    );
  }
}