import 'package:flutter/material.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("備蓄品チェックリスト")),
      body: const Center(child: Text("備蓄品チェックリストの内容")),
    );
  }
}
