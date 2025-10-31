// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

// ページ
import 'pages/auth/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/disaster/quiz/quiz_page.dart';
import 'pages/disaster/bichiku/bichiku_page.dart';
import 'pages/news/news_list_page.dart';
import 'pages/disaster/manuals/manual_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        useMaterial3: true,
      ),
      initialRoute: '/login', // ← ログインから開始
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/quiz': (context) => const QuizPage(),
        '/bichiku': (context) => const BichikuPage(),
        '/news-list': (context) => const NewsListPage(),
        '/manual': (context) => const ManualPage(),
      },
    );
  }
}
