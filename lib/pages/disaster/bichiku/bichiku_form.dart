// bichiku_form.dart
import 'package:flutter/material.dart';

class BichikuForm extends StatefulWidget {
  final String? initialName;
  final String? initialDate;
  final String? initialCategory;
  final bool isEditingPreset;
  final Function(Map<String, dynamic>) onSave;
  final Function()? onDelete;
  final List<String> categories;

  const BichikuForm({
    super.key,
    this.initialName,
    this.initialDate,
    this.initialCategory,
    required this.isEditingPreset,
    required this.onSave,
    this.onDelete,
    required this.categories,
  });

  @override
  State<BichikuForm> createState() => _BichikuFormState();
}

class _BichikuFormState extends State<BichikuForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _newCategoryController; // 🔸 新しいカテゴリ入力用
  String? selectedDate;
  String? selectedCategory;
  bool noExpiry = false;
  bool addingNewCategory = false; // 🔸 「新しいカテゴリを追加中かどうか」

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _newCategoryController = TextEditingController();
    selectedDate = widget.initialDate;
    selectedCategory = widget.initialCategory ?? widget.categories.first;
    noExpiry = widget.initialDate == '期限なし';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _newCategoryController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: now,
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        selectedDate =
            '${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}';
        noExpiry = false;
      });
    }
  }

  Future<void> _deleteItem() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content: const Text('この項目を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              '削除する',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (shouldDelete == true) {
      widget.onDelete?.call();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('項目を削除しました')));
    }
  }

  void _addNewCategory() {
    final newCat = _newCategoryController.text.trim();
    if (newCat.isNotEmpty && !widget.categories.contains(newCat)) {
      setState(() {
        widget.categories.add(newCat); // 🔸 新カテゴリをリストに追加
        selectedCategory = newCat;
        addingNewCategory = false;
        _newCategoryController.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('「$newCat」をジャンルに追加しました')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPreset = widget.isEditingPreset;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPreset ? '期限の登録・編集' : '新しい備蓄品を追加',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 品名入力
            if (!isPreset)
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '品名を入力',
                  border: OutlineInputBorder(),
                ),
              ),

            if (!isPreset) const SizedBox(height: 16),

            // 🔸 カテゴリ選択 or 新規追加
            DropdownButtonFormField<String>(
              value: widget.categories.contains(selectedCategory)
                  ? selectedCategory
                  : widget.categories.first,
              decoration: const InputDecoration(
                labelText: 'ジャンルを選択',
                border: OutlineInputBorder(),
              ),
              items: [
                ...widget.categories.map(
                  (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                ),
                const DropdownMenuItem(
                  value: '新しいジャンルを追加',
                  child: Text('＋ 新しいジャンルを追加'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  if (value == '新しいジャンルを追加') {
                    addingNewCategory = true;
                    selectedCategory = null;
                  } else {
                    addingNewCategory = false;
                    selectedCategory = value;
                  }
                });
              },
            ),

            // 🔸 新しいカテゴリ追加用のテキストフィールド
            if (addingNewCategory) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _newCategoryController,
                decoration: InputDecoration(
                  labelText: '新しいジャンル名',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: _addNewCategory,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // 🔸 日付選択＋期限なしオプション
            Row(
              children: [
                Expanded(
                  child: Text(
                    noExpiry ? '期限なし' : (selectedDate ?? '期限を選択'),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      noExpiry = true;
                      selectedDate = '期限なし';
                    });
                  },
                  child: const Text('期限なしにする'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 🔸 ボタン群
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB4C57E),
                  ),
                  onPressed: () {
                    final name = _nameController.text.isNotEmpty
                        ? _nameController.text
                        : widget.initialName;

                    if (name == null || name.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('品名を入力してください')),
                      );
                      return;
                    }

                    final newItem = {
                      'name': name,
                      'date': noExpiry ? '期限なし' : selectedDate,
                      'category':
                          selectedCategory ??
                          (addingNewCategory
                              ? _newCategoryController.text
                              : widget.categories.first),
                    };

                    widget.onSave(newItem);
                    Navigator.pop(context, newItem);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('$name を登録しました')));
                  },
                  child: const Text('登録する'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                if (isPreset)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: _deleteItem,
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
