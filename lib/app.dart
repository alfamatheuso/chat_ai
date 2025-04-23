import 'package:chat_ai/features/config/page/config_page.dart';
import 'package:chat_ai/features/loading/page/loading_page.dart';
import 'package:chat_ai/features/prompt_page/page/prompt_page.dart';
import 'package:chat_ai/features/terminal/page/terminal_page.dart';
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
