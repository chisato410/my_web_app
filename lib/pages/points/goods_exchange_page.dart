// lib/pages/points/goods_exchange_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'points_provider.dart';
import 'exchange_complete_dialog.dart';

class GoodsExchangePage extends StatelessWidget {
  const GoodsExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pointsProvider = context.watch<PointsProvider>();
    final currentPoints = pointsProvider.points;

    final List<Map<String, dynamic>> goodsList = [
      {'name': '非常食 3日分', 'points': 300, 'image': 'assets/images/goods.jpg'},
      {'name': '懐中電灯', 'points': 300, 'image': 'assets/images/goods.jpg'},
      {'name': '防災ブランケット', 'points': 200, 'image': 'assets/images/goods.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポイント交換'),
        backgroundColor: const Color(0xFFD99C63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '$currentPoints pt',
              style: const TextStyle(
                fontSize: 36,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('現在のポイント', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: goodsList.length,
                itemBuilder: (context, index) {
                  final item = goodsList[index];
                  final canExchange = currentPoints >= item['points'];

                  return Card(
                    child: ListTile(
                      // 横幅固定でエラー回避
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(item['image'], fit: BoxFit.cover),
                      ),
                      title: Text(item['name']),
                      subtitle: Text('交換ポイント：${item['points']} pt'),
                      trailing: ElevatedButton(
                        onPressed: canExchange
                            ? () async {
                                pointsProvider.subtractPoints(
                                  item['points'],
                                  item['name'],
                                );
                                await showExchangeCompleteDialog(
                                  context,
                                  item['name'],
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD99C63),
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: const Text('交換'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
