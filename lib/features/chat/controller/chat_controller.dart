import 'package:chat_ai/core/services/api_service.dart';
import 'package:chat_ai/core/services/local_service.dart';
import 'package:mobx/mobx.dart';
part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ApiService apiService;
  final LocalService localService;

  _ChatControllerBase(this.apiService, this.localService);

  @observable
  ObservableList<String> chatMessages = ObservableList<String>();

  @action
  Future<void> sendMessage(String prompt) async {
    final response = await apiService.sendPrompt(
      prompt,
      localService.owner!,
      localService.repository!,
    );
    chatMessages.add('Você: $prompt');
    chatMessages.add('API: $response');
  }
}
