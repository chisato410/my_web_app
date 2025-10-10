import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _state = 'quiz';
  final question = "地震が起きたとき、まず最初にとるべき行動は？";
  final options = ["机の下に隠れる", "外に走って出る", "エレベーターを使う", "ガスを止める"];
  final correctIndex = 0;
  int? selectedIndex;

  void _checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      _state = index == correctIndex ? 'correct' : 'wrong';
    });
  }

  void _goExplain() => setState(() => _state = 'explain');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("クイズ")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case 'quiz':
        return _buildQuiz();
      case 'correct':
        return _buildCorrect();
      case 'wrong':
        return _buildWrong();
      case 'explain':
        return _buildExplain();
      default:
        return const SizedBox();
    }
  }

  // --- 各画面ウィジェット ---
  Widget _buildQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("今日のクイズ", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(question),
        const SizedBox(height: 24),
        for (int i = 0; i < options.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ElevatedButton(
              onPressed: () => _checkAnswer(i),
              child: Text(options[i]),
            ),
          ),
      ],
    );
  }

  Widget _buildCorrect() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("正解！", style: TextStyle(fontSize: 32, color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _goExplain, child: const Text("解説を見る")),
        ],
      ),
    );
  }

  Widget _buildWrong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("不正解", style: TextStyle(fontSize: 32, color: Colors.blue)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _goExplain, child: const Text("解説を見る")),
        ],
      ),
    );
  }

  Widget _buildExplain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "解説",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text("地震の揺れを感じたら、まずは自分の身を守る行動をとりましょう。机の下に隠れるのが安全です。"),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ホームに戻る"),
          ),
        ),
      ],
    );
  }
}
