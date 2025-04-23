import 'package:flutter/material.dart';

class PromptPage extends StatelessWidget {
  final promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final promptPageController = Provider.of<PromptPageController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar Prompt', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/config');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2980b9), Color(0xFF3498db)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: promptController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Digite o Prompt',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Enviar'),
                  onPressed: () async {
                    await promptPageController.sendPrompt(promptController.text);
                    Navigator.pushReplacementNamed(context, '/loading');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
