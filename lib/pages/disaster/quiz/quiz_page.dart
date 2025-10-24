import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _state = 'quiz';
  final question = "緊急地震速報が鳴った場合、最初にすべきことは何でしょう？";
  final options = [
    "机の下や物が無い場所に逃げる",
    "火を消してガス栓を閉める",
    "走って屋外に避難する",
    "家具が倒れないようにおさえる",
  ];
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("クイズ", style: TextStyle(color: Color(0xFF5C3B28))),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF5C3B28)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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

  // --- 🎯 出題画面 ---
  Widget _buildQuiz() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              margin: const EdgeInsets.only(top: 140, bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFEBCC8D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "今日のクイズ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C3B28),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFF6EFCA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF5C3B28),
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  for (int i = 0; i < options.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE7B190),
                          foregroundColor: const Color(0xFF5C3B28),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _checkAnswer(i),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: Text(
                                (i + 1).toString(),
                                style: const TextStyle(
                                  color: Color(0xFF5C3B28),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                options[i],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
        Positioned(
          bottom: 170,
          left: 24,
          child: Image.asset("assets/images/paw.png", width: 100, height: 100),
        ),
      ],
    );
  }

  // --- 🎯 正解画面 ---
  Widget _buildCorrect() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            decoration: BoxDecoration(
              color: const Color(0xFFE47F7F),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/answer1.png",
                  width: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 220,
                  child: TextButton(
                    onPressed: _goExplain,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Text(
                          "解説を見る →",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF5C3B28),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -70,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset("assets/images/dog.png", width: 180),
            ),
          ),
        ],
      ),
    );
  }

  // --- 🎯 不正解画面 ---
  Widget _buildWrong() => _buildCorrect();

  // --- 🎯 解説画面 ---
  Widget _buildExplain() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6EFCA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF5C3B28),
                                width: 2,
                              ),
                            ),
                          ),
                          child: const Text(
                            "1：机の下や物が無い場所に逃げる",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5C3B28),
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "緊急地震速報が鳴ってから強い揺れが来るまでの時間は、数秒〜数十秒と言われています。そのため、瞬時に身の安全を確保することが何より重要です。",
                    style: TextStyle(color: Color(0xFF5C3B28), height: 1.6),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "大きな家具やガラスなどから離れましょう。物が無い廊下やエレベーターホールの避難も有効です。",
                    style: TextStyle(color: Color(0xFF5C3B28), height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE7B190),
                  foregroundColor: const Color(0xFF5C3B28),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 44,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "ホームに戻る",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),

        // 💡 肉球を Column の後に置くことで上に重なる
        Positioned(
          top: 150,
          right: -10,
          child: Image.asset("assets/images/paw.png", width: 80),
        ),
      ],
    );
  }
}
