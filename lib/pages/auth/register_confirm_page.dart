import 'package:flutter/material.dart';
import '../../models/user_registration.dart';

class RegisterConfirmPage extends StatelessWidget {
  final UserRegistration user;

  const RegisterConfirmPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("登録内容確認")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("氏名: ${user.fullName}"),
            Text("氏名(カナ): ${user.fullNameKana}"),
            Text("郵便番号: ${user.postalCode}"),
            Text("住所: ${user.address}"),
            Text("電話番号: ${user.phone}"),
            Text("メール: ${user.email}"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("戻る"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("本登録処理を実行")));
                  },
                  child: const Text("登録する"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
