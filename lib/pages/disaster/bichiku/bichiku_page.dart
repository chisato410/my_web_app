import 'package:flutter/material.dart';
import 'bichiku_form.dart';

class BichikuPage extends StatefulWidget {
  const BichikuPage({super.key});

  @override
  State<BichikuPage> createState() => _BichikuPageState();
}

class _BichikuPageState extends State<BichikuPage>
    with SingleTickerProviderStateMixin {
  final Map<String, List<Map<String, dynamic>>> categories = {
    '飲食・水分': [
      {'name': '水', 'date': null},
      {'name': '食品', 'date': null},
      {'name': '携帯カトラリー', 'date': null},
    ],
    '衣類・生活用品': [
      {'name': '衣類・下着', 'date': null},
      {'name': 'レインウェア', 'date': null},
      {'name': '紐なしのズック靴', 'date': null},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> customItems = {};

  @override
  Widget build(BuildContext context) {
    final tabs = categories.keys.toList();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('備蓄品管理'),
          backgroundColor: const Color(0xFFDAC8A5),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.brown[900],
            indicatorColor: Colors.brown,
            tabs: [for (final tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [for (final tab in tabs) _buildCategoryList(context, tab)],
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, String category) {
    final items = [...categories[category]!, ...?customItems[category]];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item['name']),
          subtitle: item['date'] != null
              ? Text(
                  '期限：${item['date']}',
                  style: const TextStyle(color: Colors.brown),
                )
              : const Text('期限未設定', style: TextStyle(color: Colors.grey)),
          trailing: const Icon(Icons.edit, color: Colors.brown),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => BichikuForm(
                initialName: item['name'],
                initialDate: item['date'],
                categories: categories.keys.toList(),
                initialCategory: category,
                isEditingPreset: true,
                onSave: (_) {},
                onDelete: () {
                  setState(() {
                    items.removeAt(index); // ← 即削除
                  });
                  Navigator.pop(context); // ← モーダルを閉じる
                },
              ),
            );
          },
        );
      },
    );
  }
}
