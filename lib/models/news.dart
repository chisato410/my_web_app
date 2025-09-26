class NewsItem {
  final String date;
  final String title;
  final String detail;

  NewsItem({required this.date, required this.title, required this.detail});
}

final mockNews = [
  NewsItem(
    date: "2025年6月1日",
    title: "地震情報に関するお知らせ",
    detail: "首都圏で震度4の地震がありました。最新の情報をご確認ください。",
  ),
  NewsItem(
    date: "2025年5月1日",
    title: "台風の接近状況について",
    detail: "台風5号が関東地方に接近中です。避難情報に注意してください。",
  ),
  NewsItem(date: "2025年4月1日", title: "運用開始について", detail: "そなポイアプリの運用を開始しました。"),
];
