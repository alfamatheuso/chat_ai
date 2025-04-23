import 'package:chat_ai/features/loading/controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final LoadingController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<LoadingController>(context, listen: false);
    controller.executeCloneOrPull().then((_) => Navigator.pushNamed(context, '/terminal'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2980b9), Color(0xFF3498db)]),
        ),
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
