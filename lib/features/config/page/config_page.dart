import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with SingleTickerProviderStateMixin {
  late final ConfigController controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<ConfigController>(context, listen: false);

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2980b9), Color(0xFF3498db)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Configurações', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 24),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Owner',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        value: controller.selectedOwner,
                        items: ['owner1', 'owner2', 'owner3'].map((owner) {
                          return DropdownMenuItem(value: owner, child: Text(owner));
                        }).toList(),
                        onChanged: (value) {
                          controller.setOwner(value!);
                          controller.fetchRepositories();
                        },
                      ),
                      SizedBox(height: 16),
                      Observer(builder: (_) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Repositório',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: controller.repositories.map((repo) {
                            return DropdownMenuItem(value: repo, child: Text(repo));
                          }).toList(),
                          onChanged: (value) => controller.setRepository(value!),
                        );
                      }),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () async {
                          await controller.saveConfig();
                          Navigator.pushReplacementNamed(context, '/chat');
                        },
                        child: Text('Salvar e Continuar', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///*lib/features/chat/page/chat_page.dart*/
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2980b9),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/config');
            },
          )
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
        child: Column(
          children: [
            Expanded(child: Observer(builder: (_) {
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: chatController.chatMessages.length,
                itemBuilder: (_, index) {
                  bool isUserMessage = chatController.chatMessages[index].startsWith('Você:');
                  return Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.white : Colors.amber[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(chatController.chatMessages[index]),
                    ),
                  );
                },
              );
            })),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: promptController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite seu prompt',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (promptController.text.trim().isEmpty) return;
                      chatController.sendMessage(promptController.text.trim());
                      promptController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///*lib/app.dart*/
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final bool hasConfig;

  App({required this.hasConfig});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: hasConfig ? '/chat' : '/config',
      routes: {
        '/config': (_) => ConfigPage(),
        '/chat': (_) => ChatPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
    );
  }
}
