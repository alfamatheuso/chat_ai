class LocalService {
  final SharedPreferences prefs;

  LocalService(this.prefs);

  Future<void> saveOwnerAndRepo(String owner, String repository) async {
    await prefs.setString('owner', owner);
    await prefs.setString('repository', repository);
  }

  String? get owner => prefs.getString('owner');
  String? get repository => prefs.getString('repository');

  Future<void> clearData() async {
    await prefs.remove('owner');
    await prefs.remove('repository');
  }
}