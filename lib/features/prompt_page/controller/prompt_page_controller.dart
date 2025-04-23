import 'package:mobx/mobx.dart';
part 'prompt_page_controller.g.dart';

class PromptPageController = _PromptPageControllerBase with _$PromptPageController;

abstract class _PromptPageControllerBase with Store {
  final ApiService apiService;
  final LocalService localService;

  _PromptPageControllerBase(this.apiService, this.localService);

  Future<void> sendPrompt(String prompt) async {
    final response = await apiService.sendPrompt(
      prompt,
      localService.owner!,
      localService.repository!,
    );
    if (response == '200') localService.setPromptSuccess(true);
  }
}