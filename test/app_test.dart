import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_chat_app/core/services/api_service.dart';
import 'package:flutter_chat_app/core/services/local_service.dart';
import 'package:flutter_chat_app/features/config/controller/config_controller.dart';
import 'package:flutter_chat_app/features/prompt_page/controller/prompt_page_controller.dart';
import 'package:flutter_chat_app/features/loading/controller/loading_controller.dart';

class MockApiService extends Mock implements ApiService {}

class MockLocalService extends Mock implements LocalService {}

void main() {
  late MockApiService mockApiService;
  late MockLocalService mockLocalService;
  late ConfigController configController;
  late PromptPageController promptPageController;
  late LoadingController loadingController;

  setUp(() {
    mockApiService = MockApiService();
    mockLocalService = MockLocalService();
    configController = ConfigController(mockApiService, mockLocalService);
    promptPageController = PromptPageController(mockApiService, mockLocalService);
    loadingController = LoadingController(mockLocalService);
  });

  group('ConfigController Tests', () {
    test('Deve buscar repositórios corretamente', () async {
      when(mockApiService.fetchRepositories('user')).thenAnswer((_) async => ['repo1', 'repo2']);

      configController.setOwner('user');
      await configController.fetchRepositories();

      expect(configController.repositories, ['repo1', 'repo2']);
      verify(mockApiService.fetchRepositories('user')).called(1);
    });

    test('Deve salvar configuração corretamente', () async {
      configController.setOwner('user');
      configController.setRepository('repo');
      configController.setLocalPath('/local/path');

      await configController.saveConfig();

      verify(mockLocalService.saveOwnerAndRepo('user', 'repo')).called(1);
      verify(mockLocalService.setLocalPath('/local/path')).called(1);
    });
  });

  group('PromptPageController Tests', () {
    test('Deve enviar o prompt corretamente e definir sucesso', () async {
      when(mockLocalService.owner).thenReturn('user');
      when(mockLocalService.repository).thenReturn('repo');
      when(mockApiService.sendPrompt('teste', 'user', 'repo')).thenAnswer((_) async => '200');

      await promptPageController.sendPrompt('teste');

      verify(mockApiService.sendPrompt('teste', 'user', 'repo')).called(1);
      verify(mockLocalService.setPromptSuccess(true)).called(1);
    });
  });

  group('LoadingController Tests', () {
    test('Deve executar o clone do repositório corretamente', () async {
      when(mockLocalService.owner).thenReturn('user');
      when(mockLocalService.repository).thenReturn('repo');
      when(mockLocalService.localPath).thenReturn('/local/path');

      expect(() => loadingController.executeClone(), returnsNormally);
    });
  });
}