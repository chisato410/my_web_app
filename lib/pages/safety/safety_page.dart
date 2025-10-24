import 'package:flutter/material.dart';

class SafetyCheckPage extends StatefulWidget {
  const SafetyCheckPage({super.key});

  @override
  State<SafetyCheckPage> createState() => _SafetyCheckPageState();
}

class _SafetyCheckPageState extends State<SafetyCheckPage> {
  final List<Map<String, dynamic>> members = [
    {'name': '伊藤 美咲', 'initial': '美', 'checked': false},
    {'name': '伊藤 翔太', 'initial': '翔', 'checked': false},
    {'name': '伊藤 うらら', 'initial': 'う', 'checked': false},
    {'name': '伊藤 優馬', 'initial': '優', 'checked': false},
  ];

  void markAllSafe() {
    setState(() {
      for (var member in members) {
        member['checked'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9F7ED),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 12),
          const Text(
            '安否確認',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: markAllSafe,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA7C197),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '無事です',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: members.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = members[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E8B8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(0xFFD6A4E7),
                        child: Text(
                          member['initial'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          member['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            member['checked'] = !member['checked'];
                          });
                        },
                        child: Icon(
                          member['checked']
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: member['checked']
                              ? const Color(0xFFA7C197)
                              : Colors.grey.shade400,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
