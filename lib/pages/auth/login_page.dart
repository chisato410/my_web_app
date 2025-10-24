import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth; // ← 名前衝突を防ぐ
import '../../data/dummy_users.dart'; // ← 独自Userモデルをimport！
import '../navigation/main_navigation.dart';
import 'register_page.dart';

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
      // Firebase認証でログイン
      await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      // ログイン成功のスナックバー
      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text("ログイン成功！"),
              duration: Duration(seconds: 2),
            ),
          )
          .closed;

      if (!mounted) return;

      // Firebaseのユーザーを取得
      final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("ユーザー情報を取得できませんでした")));
        return;
      }

      // ✅ アプリ用の User モデルを作成（dummy_users.dart の User）
      final appUser = User(
        id: firebaseUser.uid,
        name: firebaseUser.email ?? "未設定ユーザー",
        password: "",
        initial: firebaseUser.email != null && firebaseUser.email!.isNotEmpty
            ? firebaseUser.email![0].toUpperCase()
            : "U",
      );

      // ✅ MainNavigation に渡して遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigation(user: appUser)),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
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
      await firebase_auth.FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("パスワード再設定メールを送信しました")));
    } on firebase_auth.FirebaseAuthException catch (e) {
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
