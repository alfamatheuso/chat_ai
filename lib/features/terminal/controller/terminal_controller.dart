import 'package:chat_ai/features/terminal/model/terminal_model.dart';
import 'package:mobx/mobx.dart';
part 'terminal_controller.g.dart';

class TerminalController = _TerminalControllerBase with _$TerminalController;

abstract class _TerminalControllerBase with Store {
  @observable
  ObservableList<TerminalLog> logs = ObservableList<TerminalLog>();

  @action
  void addLog(String message) {
    logs.insert(0, TerminalLog(message: message, timestamp: DateTime.now()));
  }

  @action
  void clearLogs() {
    logs.clear();
  }
}
