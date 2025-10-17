import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './pages/auth/login_page.dart';
import 'firebase_options.dart'; // flutterfire configure で生成されたもの

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Supabase 初期化
  await Supabase.initialize(
    url: 'https://zpjqejjemivvzyazfgiu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpwanFlamplbWl2dnp5YXpmZ2l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzMzAxOTYsImV4cCI6MjA3MzkwNjE5Nn0.JzAtgJ3WIDxF_PPBo8404E9GIa-j1z5m8iBuC1oBS38',
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true, // ← M3対応UIならこちらを推奨
      ),
      home: const LoginPage(), // ✅ ログインページを最初に表示
    );
  }
}
