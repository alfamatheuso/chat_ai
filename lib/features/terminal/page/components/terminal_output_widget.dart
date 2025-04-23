import 'dart:ui';

import 'package:chat_ai/features/terminal/model/terminal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class TerminalOutputWidget extends StatelessWidget {
  final ObservableList<TerminalLog> logs;

  TerminalOutputWidget({required this.logs});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(12),
      child: Observer(
        builder: (_) => ListView.builder(
          reverse: true,
          itemCount: logs.length,
          itemBuilder: (_, index) {
            final log = logs[index];
            return Text(
              '[${log.timestamp.hour}:${log.timestamp.minute}:${log.timestamp.second}] ${log.message}',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'Courier',
              ),
            );
          },
        ),
      ),
    );
  }
}
