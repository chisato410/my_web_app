import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckListPage extends StatefulWidget {
  final int? listId; // ← 整数ID
  const CheckListPage({super.key, required this.listId});

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  /// 備蓄アイテムを読み込み
  Future<void> _loadItems() async {
    final data = await supabase
        .from('stock_items')
        .select()
        .eq('list_id', widget.listId as Object)
        .order('id');
    setState(() => items = List<Map<String, dynamic>>.from(data));
  }

  /// チェック状態を切り替え
  Future<void> _toggleCheck(int index, bool? value) async {
    final item = items[index];
    await supabase
        .from('stock_items')
        .update({'is_checked': value})
        .eq('id', item['id']);
    _loadItems();
  }

  /// 数量を1増やす
  Future<void> _incrementQuantity(int index) async {
    final item = items[index];
    final newQty = (item['quantity'] ?? 0) + 1;
    await supabase
        .from('stock_items')
        .update({'quantity': newQty})
        .eq('id', item['id']);
    _loadItems();
  }

  /// 数量を1減らす
  Future<void> _decrementQuantity(int index) async {
    final item = items[index];
    final currentQty = item['quantity'] ?? 0;
    if (currentQty > 1) {
      await supabase
          .from('stock_items')
          .update({'quantity': currentQty - 1})
          .eq('id', item['id']);
      _loadItems();
    }
  }

  /// 新しいアイテムを追加
  Future<void> _addItemDialog() async {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController qtyCtrl = TextEditingController(text: '1');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('備蓄アイテムを追加'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'アイテム名'),
            ),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '数量'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final qty = int.tryParse(qtyCtrl.text) ?? 1;
              if (name.isEmpty) return;

              await supabase.from('stock_items').insert({
                'list_id': widget.listId,
                'name': name,
                'quantity': qty,
                'is_checked': false,
                'is_preset': false,
              });
              Navigator.pop(context);
              _loadItems();
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('備蓄チェックリスト')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('数量: ${item['quantity']}'),
            leading: Checkbox(
              value: item['is_checked'] ?? false,
              onChanged: (v) => _toggleCheck(i, v),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _decrementQuantity(i),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _incrementQuantity(i),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
