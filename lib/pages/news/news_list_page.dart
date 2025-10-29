// lib/pages/news/news_list_page.dart
import 'package:flutter/material.dart';
import '../../models/news.dart';
import 'news_detail_page.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('おしらせ一覧'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockNews.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final news = mockNews[index];
          return ListTile(
            title: Text(
              news.title,
              style: const TextStyle(
                color: Color(0xff4880C0),
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(news.date),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xff4880C0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewsDetailPage(news: news)),
              );
            },
          );
        },
      ),
    );
  }
}
