import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      // SnackBarを表示 → 消えるまで待つ
      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text("ログイン成功！"),
              duration: Duration(seconds: 2), // 2秒間表示
            ),
          )
          .closed;

      if (!mounted) return;

      // SnackBarが消えたあとにホーム画面へ遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("ログイン失敗: ${e.message}")));
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("メールアドレスを入力してください")));
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("パスワード再設定メールを送信しました")));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("送信エラー: ${e.message}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/name.png', height: 40),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "メールアドレス"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "パスワード"),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: const Text("ログイン")),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _resetPassword,
                child: const Text("パスワードをお忘れの方はこちら"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text("新規登録はこちら"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
