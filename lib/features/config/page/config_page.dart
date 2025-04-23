import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late final ConfigController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<ConfigController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuração')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Owner'),
              value: controller.selectedOwner,
              items: ['owner1', 'owner2', 'owner3'].map((owner) {
                return DropdownMenuItem(value: owner, child: Text(owner));
              }).toList(),
              onChanged: (value) {
                controller.setOwner(value!);
                controller.fetchRepositories();
              },
            ),
            Observer(builder: (_) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Repositorio'),
                items: controller.repositories.map((repo) {
                  return DropdownMenuItem(value: repo, child: Text(repo));
                }).toList(),
                onChanged: (value) => controller.setRepository(value!),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.saveConfig();
                Navigator.pushReplacementNamed(context, '/chat');
              },
              child: const Text('Salvar e Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}