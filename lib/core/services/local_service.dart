import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final SharedPreferences prefs;

  LocalService(this.prefs);

  Future<void> saveOwnerAndRepo(String owner, String repository) async {
    await prefs.setString('owner', owner);
    await prefs.setString('repository', repository);
  }

  String? get owner => prefs.getString('owner');
  String? get repository => prefs.getString('repository');

  Future<void> setPromptSuccess(bool value) async {
    await prefs.setBool('prompt_success', value);
  }

  bool get promptSuccess => prefs.getBool('prompt_success') ?? false;

  Future<void> setLocalPath(String path) async {
    await prefs.setString('local_path', path);
  }

  String? get localPath => prefs.getString('local_path');

  Future<void> clearData() async {
    await prefs.clear();
  }
}
