import 'package:flutter/material.dart';
import 'manual_detail_page.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manuals = [
      "避難所に到着したら",
      "受付をする",
      "避難スペースの利用方法",
      "食料・飲料水の受け取り方法",
      "トイレ・洗面所・衛生のルール",
      "入浴やシャワーの使い方",
      "情報収集・放送の確認方法",
      "ペットを連れて避難する場合",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("防災マニュアル"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 検索画面へ遷移
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("マニュアル一覧"),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // TODO: ジャンル切替画面へ遷移
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("ジャンル検索"),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: manuals.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(manuals[index]),
                  onTap: () {
                    // 🔽 ここで詳細画面へ
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ManualDetailPage(title: manuals[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
