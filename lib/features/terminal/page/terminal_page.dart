class TerminalPage extends StatelessWidget {
  final TerminalController controller = TerminalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminal'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: controller.clearLogs,
          ),
        ],
      ),
      body: TerminalOutputWidget(logs: controller.logs),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.addLog('Comando executado com sucesso.');
        },
      ),
    );
  }
}