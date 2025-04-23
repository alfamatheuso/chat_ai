import 'dart:io';
import 'package:chat_ai/core/services/local_service.dart';
import 'package:mobx/mobx.dart';
import 'package:process_run/process_run.dart';

class LoadingController {
  final LocalService localService;

  LoadingController(this.localService);

  Future<void> executeCloneOrPull() async {
    final owner = localService.owner!;
    final repository = localService.repository!;
    final localPath = localService.localPath!;
    final repoPath = '$localPath/$repository';

    final repositoryUrl = 'https://github.com/$owner/$repository.git';

    final repoDir = Directory(repoPath);
    final isRepoExists = await repoDir.exists();

    if (!isRepoExists) {
      await run('git clone $repositoryUrl', workingDirectory: localPath);
      await run('git checkout -b branch-auxiliar', workingDirectory: repoPath);
    } else {
      await run('git pull', workingDirectory: repoPath);
    }
  }
}
