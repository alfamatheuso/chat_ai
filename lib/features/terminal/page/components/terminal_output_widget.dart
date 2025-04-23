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