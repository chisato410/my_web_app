import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 👈 追加
import './pages/auth/login_page.dart';
import 'firebase_options.dart'; // 👈 flutterfire configure で生成されるファイル

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 Firebase 初期化前に必要
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 これで各環境の設定を読み込む
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '防災アプリ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginPage(), // ✅ 初期画面はログインページ
    );
  }
}
