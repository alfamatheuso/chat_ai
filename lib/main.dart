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