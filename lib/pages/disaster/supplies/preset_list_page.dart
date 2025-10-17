import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PresetListPage extends StatefulWidget {
  const PresetListPage({super.key});

  @override
  State<PresetListPage> createState() => _PresetListPageState();
}

class _PresetListPageState extends State<PresetListPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPresetItems();
  }

  Future<void> _loadPresetItems() async {
    try {
      final response = await supabase
          .from('preset_items')
          .select('*')
          .order('id');
      setState(() {
        _items = List<Map<String, dynamic>>.from(response);
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error loading preset items: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByCategory(_items);

    return Scaffold(
      appBar: AppBar(
        title: const Text('備蓄品プリセット一覧'),
        backgroundColor: Colors.green.shade700,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: grouped.keys.length,
              itemBuilder: (context, index) {
                final category = grouped.keys.elementAt(index);
                final items = grouped[category]!;

                return ExpansionTile(
                  title: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: items
                      .map(
                        (item) => ListTile(
                          title: Text(item['name']),
                          subtitle: Text(
                            '数量: ${item['default_quantity']} ${item['unit']}',
                          ),
                          leading: const Icon(Icons.inventory_2_outlined),
                        ),
                      )
                      .toList(),
                );
              },
            ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupByCategory(
    List<Map<String, dynamic>> items,
  ) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final item in items) {
      final category = item['category'] ?? 'その他';
      grouped.putIfAbsent(category, () => []).add(item);
    }
    return grouped;
  }
}
