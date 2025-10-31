import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'points_provider.dart';
import 'quest_page.dart';

class PointPage extends StatefulWidget {
  const PointPage({super.key});

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  // ✅ missions を Stateful にして、完了状態を反映
  List<Map<String, dynamic>> missions = [
    {'title': '防災イベントに参加してみよう', 'point': 100, 'completed': false},
    {'title': '1日1回 防災クイズに答えよう', 'point': 5, 'completed': false},
    {'title': '備蓄チェックリストを確認', 'point': 10, 'completed': false},
    {'title': '避難場所を調べてみよう', 'point': 100, 'completed': false},
  ];

  void completeMission(int index, PointsProvider pointsProvider) {
    setState(() {
      missions[index]['completed'] = true;
    });

    pointsProvider.addPoints(missions[index]['point'] as int);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '「${missions[index]['title']}」を達成！ +${missions[index]['point']}pt 獲得！',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.orange.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pointsProvider = context.watch<PointsProvider>();
    final currentPoints = pointsProvider.points;

    // 未完了を上、完了済みを下に並べ替え
    List<Map<String, dynamic>> sortedMissions = [...missions];
    sortedMissions.sort((a, b) {
      if (a['completed'] == b['completed']) return 0;
      return a['completed'] ? 1 : -1;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('防災ポイント'),
        backgroundColor: const Color(0xFFD99C63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '防災ポイントとは\n\nアプリ内で防災に関する行動をするとポイントが貯まります。\n貯めたポイントは防災グッズと交換することができます。',
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              '$currentPoints pt',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '現在のポイント',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/goods_exchange');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD99C63),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '防災グッズに交換',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),

            // ✅ ミッション一覧は Expanded + ListView.builder でスクロール可能
            Expanded(
              child: ListView.builder(
                itemCount: sortedMissions.length,
                itemBuilder: (context, index) {
                  final mission = sortedMissions[index];
                  final originalIndex = missions.indexOf(mission);
                  return _buildMissionButton(
                    context,
                    mission['title'],
                    mission['point'],
                    mission['completed'],
                    () => completeMission(originalIndex, pointsProvider),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionButton(
    BuildContext context,
    String title,
    int point,
    bool completed,
    VoidCallback onComplete,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: completed
            ? null
            : () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestPage(title: title, point: point),
                  ),
                );
                if (result == true) onComplete();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: completed ? Colors.grey.shade200 : Colors.white,
          foregroundColor: completed ? Colors.grey : Colors.black,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                completed ? '$title（完了済み）' : title,
                style: TextStyle(
                  decoration: completed ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: completed
                    ? Colors.grey.shade300
                    : Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                completed ? '済' : '+$point pt',
                style: TextStyle(
                  color: completed ? Colors.grey : Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
