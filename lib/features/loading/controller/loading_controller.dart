import 'package:mobx/mobx.dart';
import 'package:process_run/process_run.dart';

class LoadingController {
  final LocalService localService;

  LoadingController(this.localService);

  Future<void> executeClone() async {
    final repositoryUrl = 'https://github.com/${localService.owner}/${localService.repository}.git';
    final directory = localService.localPath!;

    await run('git', ['clone', repositoryUrl], workingDirectory: directory);
  }
}