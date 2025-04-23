class TerminalPage extends StatelessWidget {
  final TerminalController controller = TerminalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.terminal, color: Colors.white),
            SizedBox(width: 8),
            Text('Terminal'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all, color: Colors.white),
            onPressed: controller.clearLogs,
            tooltip: 'Limpar Logs',
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.deepPurple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            height: 4,
          ),
        ),
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