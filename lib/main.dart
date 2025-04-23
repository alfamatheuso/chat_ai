import 'package:chat_ai/app.dart';
import 'package:chat_ai/core/services/api_service.dart';
import 'package:chat_ai/core/services/local_service.dart';
import 'package:chat_ai/features/chat/controller/chat_controller.dart';
import 'package:chat_ai/features/config/controller/config_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final localService = LocalService(prefs);

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => ApiService()),
      Provider(create: (_) => localService),
      Provider(create: (context) => ConfigController(context.read(), localService)),
      Provider(create: (context) => ChatController(context.read(), localService)),
    ],
    child: App(hasConfig: localService.owner != null && localService.repository != null),
  ));
}
