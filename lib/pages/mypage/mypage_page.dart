import 'package:flutter/material.dart';
import '../../data/dummy_users.dart';

class MyPage extends StatelessWidget {
  final User user;
  const MyPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CircleAvatar(radius: 30, child: Text(user.initial)),
          const SizedBox(height: 8),
          Text(user.name, style: const TextStyle(fontSize: 18)),
          const Divider(),
          ListTile(
            title: const Text('登録情報の変更'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/editProfile'),
          ),
        ],
      ),
    );
  }
}
