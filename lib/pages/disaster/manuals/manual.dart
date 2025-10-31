import 'package:flutter/material.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({super.key});

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  final Map<String, List<String>> manualData = {
    '避難所に到着したら': ['受付をする', '指定スペースに移動する', '貴重品の管理', '周囲との協力'],
    '避難所での過ごし方': ['挨拶・マナー', '静かな時間の確保', '共同作業のルール'],
    '持ち物管理': ['貴重品', '衣類', '食料の管理'],
    '食料・飲料水の受け取り方法': ['配布時間の確認', '家族分の受け取り', 'ゴミ処理'],
    'トイレ・清掃のルール': ['利用時間', '掃除当番', '備品の使い方'],
    '情報収集・放送の確認方法': ['掲示板', 'ラジオ', 'スマホアプリ'],
    '高齢者・子ども対応': ['介助の方法', '見守り体制'],
    'ペットを連れて避難する場合': ['ペットの居場所', '食事・排泄', '他住民への配慮'],
    '感染症対策（手洗い・消毒・マスク）': ['手洗い', 'マスク管理', '共有物の消毒'],
  };

  final Map<String, bool> _expandedState = {};

  @override
  void initState() {
    super.initState();
    for (var key in manualData.keys) {
      _expandedState[key] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = manualData.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("防災マニュアル"), centerTitle: true),
      body: Stack(
        children: [
          // 📄 スクロール可能リスト
          Padding(
            padding: const EdgeInsets.only(top: 70), // 固定ボタン分下げる
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final items = manualData[category] ?? [];
                final isExpanded = _expandedState[category] ?? false;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ExpansionTile(
                    key: PageStorageKey(category),
                    title: Text(
                      category,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    initiallyExpanded: isExpanded,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedState[category] = expanded;
                      });
                    },
                    children: items.map((item) {
                      return ListTile(
                        title: Text(item),
                        leading: const Icon(Icons.chevron_right),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (_) => _buildDetailSheet(category, item),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),

          // 🔍 固定ボタンエリア
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showSearchModal(context),
                      icon: const Icon(Icons.search),
                      label: const Text("検索"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (context) =>
                              _buildTableOfContents(categories),
                        );
                      },
                      icon: const Icon(Icons.menu_book),
                      label: const Text("目次を見る"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📚 目次モーダル
  Widget _buildTableOfContents(List<String> categories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        children: [
          const Text(
            "目次",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ...categories.map(
            (category) => ListTile(
              title: Text(category),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _expandedState[category] = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // 📘 詳細モーダル
  Widget _buildDetailSheet(String category, String item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item, style: const TextStyle(fontSize: 16)),
            const Divider(height: 20),
            Text(
              "詳細内容サンプル：\nここに「$item」に関する説明文を表示します。",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // 🔎 検索モーダル
  void _showSearchModal(BuildContext context) {
    String query = '';
    List<MapEntry<String, String>> results = [];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void search(String input) {
              query = input.trim();
              results = [];
              if (query.isNotEmpty) {
                for (var entry in manualData.entries) {
                  if (entry.key.contains(query)) {
                    results.add(MapEntry(entry.key, ''));
                  }
                  for (var item in entry.value) {
                    if (item.contains(query)) {
                      results.add(MapEntry(entry.key, item));
                    }
                  }
                }
              }
              setModalState(() {});
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "マニュアル検索",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: 'キーワードを入力（例：避難・受付）',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (results.isEmpty && query.isNotEmpty)
                    const Text(
                      "該当する項目はありません",
                      style: TextStyle(color: Colors.black54),
                    ),
                  if (results.isNotEmpty)
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final category = results[index].key;
                          final item = results[index].value;
                          return ListTile(
                            title: Text(item.isEmpty ? category : item),
                            subtitle: item.isNotEmpty ? Text(category) : null,
                            onTap: () {
                              Navigator.pop(context);
                              if (item.isEmpty) {
                                setState(() {
                                  _expandedState[category] = true;
                                });
                              } else {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (_) =>
                                      _buildDetailSheet(category, item),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
