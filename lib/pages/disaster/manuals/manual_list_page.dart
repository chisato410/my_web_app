import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("防災マニュアル")),
      body: const Center(child: Text("防災マニュアルの内容")),
    );
  }
}
