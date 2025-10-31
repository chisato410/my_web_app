import 'package:flutter/material.dart';

class ManualTocPage extends StatelessWidget {
  final String title; // 例：「避難所に到着したら」
  const ManualTocPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // 仮 目次データ ※後で別ファイルやJSONへ切り出し
    final tocItems = ["受付をする", "指定スペースに移動する", "貴重品の管理", "周囲との協力"];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: tocItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.grey[200],
            title: Text(tocItems[index]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              // TODO: 詳細の中の部分直リンクもできる
              // とりあえず詳細ページに飛ばす
            },
          );
        },
      ),
    );
  }
}
