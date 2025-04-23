import 'package:chat_ai/core/services/api_service.dart';
import 'package:chat_ai/core/services/local_service.dart';
import 'package:mobx/mobx.dart';
part 'config_controller.g.dart';

class ConfigController = _ConfigControllerBase with _$ConfigController;

abstract class _ConfigControllerBase with Store {
  final ApiService apiService;
  final LocalService localService;

  _ConfigControllerBase(this.apiService, this.localService);

  @observable
  ObservableList<String> repositories = ObservableList<String>();

  @observable
  String? selectedOwner;

  @observable
  String repositoryName = '';

  @action
  void setOwner(String owner) => selectedOwner = owner;

  @action
  void setRepository(String repo) => repositoryName = repo;

  @action
  Future<void> fetchRepositories() async {
    if (selectedOwner != null) {
      final repos = await apiService.fetchRepositories(selectedOwner!);
      repositories = ObservableList.of(repos);
    }
  }

  Future<void> saveConfig() async {
    if (selectedOwner != null && repositoryName.isNotEmpty) {
      await localService.saveOwnerAndRepo(selectedOwner!, repositoryName);
    }
  }
}
