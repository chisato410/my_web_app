// 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'points_provider.dart';

class GoodsHistoryPage extends StatelessWidget {
  const GoodsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<PointsProvider>().history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('交換履歴'),
        backgroundColor: const Color(0xFFD99C63),
      ),
      body: history.isEmpty
          ? const Center(child: Text('まだ交換履歴がありません。'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('交換日: ${item['date']}'),
                    trailing: Text(
                      '-${item['points']} pt',
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
