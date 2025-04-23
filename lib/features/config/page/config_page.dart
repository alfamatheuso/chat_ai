import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late final ConfigController controller;
  final ownerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Provider.of<ConfigController>(context, listen: false);
    ownerFocusNode.addListener(() {
      if (!ownerFocusNode.hasFocus) {
        controller.fetchRepositories();
      }
    });
  }

  @override
  void dispose() {
    ownerFocusNode.dispose();
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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Configuração', style: TextStyle(fontSize: 22)),
                    SizedBox(height: 20),
                    TextField(
                      focusNode: ownerFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Owner',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: controller.setOwner,
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
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Diretório Local',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: controller.setLocalPath,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      child: Text('Salvar e Continuar'),
                      onPressed: () async {
                        await controller.saveConfig();
                        Navigator.pushReplacementNamed(context, '/prompt');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}