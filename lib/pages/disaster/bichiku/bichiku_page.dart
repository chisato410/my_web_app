// bichiku_page.dart
import 'package:flutter/material.dart';
import 'bichiku_form.dart';

class BichikuPage extends StatefulWidget {
  const BichikuPage({super.key});

  @override
  State<BichikuPage> createState() => _BichikuPageState();
}

class _BichikuPageState extends State<BichikuPage>
    with SingleTickerProviderStateMixin {
  // 🔸 完全版プリセットカテゴリ
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
      {'name': 'ブランケット', 'date': null},
      {'name': 'タオル', 'date': null},
      {'name': '洗面用具', 'date': null},
      {'name': '歯ブラシ・歯磨き粉', 'date': null},
      {'name': 'マスク', 'date': null},
      {'name': '中身の見えないゴミ袋', 'date': null},
    ],
    '防災用品・安全対策': [
      {'name': '防災用ヘルメット', 'date': null},
      {'name': '懐中電灯', 'date': null},
      {'name': 'ネックライト', 'date': null},
      {'name': '携帯ラジオ', 'date': null},
      {'name': '予備電池・携帯充電器', 'date': null},
      {'name': 'マッチ・蝋燭', 'date': null},
      {'name': '防犯ブザー／ホイッスル', 'date': null},
      {'name': '軍手', 'date': null},
      {'name': 'ペン・ノート', 'date': null},
    ],
    '健康・医療': [
      {'name': '救急用品', 'date': null},
      {'name': '使い捨て懐炉', 'date': null},
      {'name': '生理用品', 'date': null},
      {'name': 'サニタリーショーツ', 'date': null},
      {'name': 'おりものシート', 'date': null},
      {'name': 'デリケートゾーンの洗浄剤', 'date': null},
      {'name': '吸水パッド', 'date': null},
      {'name': '大人用紙パンツ', 'date': null},
      {'name': '持病の薬', 'date': null},
      {'name': 'お薬手帳のコピー', 'date': null},
    ],
    '子ども関連': [
      {'name': '離乳食', 'date': null},
      {'name': '使い捨ての哺乳瓶', 'date': null},
      {'name': '子供用紙おむつ', 'date': null},
      {'name': 'おしり拭き', 'date': null},
      {'name': '携帯用おしり洗浄機', 'date': null},
      {'name': '抱っこ紐', 'date': null},
      {'name': '子供の靴', 'date': null},
    ],
    '高齢者・介護関連': [
      {'name': '介護食', 'date': null},
      {'name': '杖', 'date': null},
      {'name': '入れ歯・洗浄剤', 'date': null},
      {'name': '補聴器', 'date': null},
    ],
  };

  // カスタム項目（ユーザー追加）
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFB4C57E),
          child: const Icon(Icons.add),
          onPressed: () async {
            final result = await showModalBottomSheet<Map<String, dynamic>>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => BichikuForm(
                isEditingPreset: false,
                categories: tabs,
                onSave: (newItem) {},
              ),
            );

            if (result != null &&
                result['name'] != null &&
                result['category'] != null) {
              final selectedCategory = result['category'];
              setState(() {
                customItems.putIfAbsent(selectedCategory, () => []);
                customItems[selectedCategory]!.add({
                  'name': result['name'],
                  'date': result['date'],
                });
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, String category) {
    final List<Map<String, dynamic>> items = [
      ...categories[category]!,
      ...?customItems[category],
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.brown, width: 0.3)),
          ),
          child: ListTile(
            title: Text(item['name']),
            subtitle: item['date'] != null
                ? Text(
                    item['date'] == '期限なし' ? '期限なし' : '期限：${item['date']}',
                    style: const TextStyle(color: Colors.brown),
                  )
                : const Text('期限未設定', style: TextStyle(color: Colors.grey)),
            trailing: const Icon(Icons.edit, color: Colors.brown),
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
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
                      items.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                ),
              );

              if (result != null && result['date'] != null) {
                setState(() {
                  item['date'] = result['date'];
                });
              }
            },
          ),
        );
      },
    );
  }
}
