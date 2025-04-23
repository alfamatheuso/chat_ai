import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/config');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Observer(builder: (_) {
            return ListView.builder(
              itemCount: chatController.chatMessages.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(chatController.chatMessages[index]),
                );
              },
            );
          })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promptController,
                    decoration: const InputDecoration(hintText: 'Digite seu prompt'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    chatController.sendMessage(promptController.text);
                    promptController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}