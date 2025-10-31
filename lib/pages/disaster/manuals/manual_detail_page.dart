import 'package:flutter/material.dart';

class ManualDetailPage extends StatelessWidget {
  final String title;
  const ManualDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // 仮本文（SQLite導入時には外に出す）
    final content = [
      "受付をする\n到着したら必ず受付を行いましょう。係員に名前・住所・連絡先を伝え、避難所名簿に記入します。",
      "指定スペースに移動する\n案内表示やスタッフの指示に従い、指定スペースに移動します。体調が悪い場合は、係員に申し出ましょう。",
      "貴重品の管理\n財布・スマホ・薬などの貴重品は常に身につけてください。",
      "周囲との協力\n高齢者や子どもの人を助けたり、場所を譲り合って行動しましょう。",
    ];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // タグ部分
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text("避難所マニュアル", style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 12),

              // タイトル
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // 本文（番号付き）
              ...List.generate(content.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}. ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Text(content[index])),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // 下部ボタン
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("一覧に戻る"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 今後ポイント機能など
                      },
                      child: const Text("初期ポイントを獲得"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
