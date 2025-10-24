// import 'package:flutter/material.dart';
// import '../../models/news.dart';
// import '../safety/safety_page.dart';
// import '../disaster/download/download_page.dart';
// import '../disaster/supplies/supply_list_page.dart';
// import '../disaster/manuals/manual_list_page.dart';
// import '../points/points_home_page.dart';
// import '../disaster/quiz/quiz_page.dart';

// class HomeContent extends StatefulWidget {
//   const HomeContent({super.key});

//   @override
//   State<HomeContent> createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 100),
//             Image.asset('assets/images/name.png', height: 40),
//             const SizedBox(height: 20),

//             // ---------------- おしらせ ----------------
//             Padding(
//               padding: const EdgeInsets.only(top: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/notice.png',
//                     height: 24,
//                     width: 24,
//                   ),
//                   const SizedBox(width: 8),
//                   const Text(
//                     "おしらせ",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),

//             Column(
//               children: mockNews
//                   .map(
//                     (news) => ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: Text(
//                         news.title,
//                         style: const TextStyle(
//                           color: Color(0xff4880C0),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       subtitle: Text(
//                         news.date,
//                         style: const TextStyle(
//                           color: Color(0xff4880C0),
//                           fontSize: 12,
//                         ),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: Color(0xff4880C0),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => Scaffold(
//                               appBar: AppBar(title: Text(news.title)),
//                               body: Center(child: Text('ニュース詳細ページをここに作成')),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                   .toList(),
//             ),
//             const SizedBox(height: 8),

//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const NewsListPage()),
//                   );
//                 },
//                 child: const Text(
//                   'もっと見る',
//                   style: TextStyle(
//                     color: Color(0xff4880C0),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // ---------------- クイズカード ----------------
//             const FunctionCard(
//               imagePath: "assets/images/quiz.png",
//               destinationPage: QuizPage(),
//               width: 450,
//               height: 90,
//             ),
//             const SizedBox(height: 20),

//             // ---------------- 機能カード群 ----------------
//             Wrap(
//               spacing: 50,
//               runSpacing: 15,
//               children: const [
//                 FunctionCard(
//                   imagePath: "assets/images/card1.png",
//                   destinationPage: DownloadPage(),
//                 ),
//                 FunctionCard(
//                   imagePath: "assets/images/card2.png",
//                   destinationPage: CheckListPage(listId: null),
//                 ),
//                 FunctionCard(
//                   imagePath: "assets/images/card3.png",
//                   destinationPage: ManualPage(),
//                 ),
//                 FunctionCard(
//                   imagePath: "assets/images/card4.png",
//                   destinationPage: PointPage(),
//                 ),
//                 FunctionCard(
//                   imagePath: "assets/images/card5.png",
//                   destinationPage: PointPage(),
//                 ),
//                 FunctionCard(
//                   imagePath: "assets/images/card6.png",
//                   destinationPage: PointPage(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------------- FunctionCard ----------------

// class FunctionCard extends StatefulWidget {
//   final String imagePath;
//   final Widget destinationPage;
//   final double width;
//   final double height;

//   const FunctionCard({
//     super.key,
//     required this.imagePath,
//     required this.destinationPage,
//     this.width = 180,
//     this.height = 110,
//   });

//   @override
//   State<FunctionCard> createState() => _FunctionCardState();
// }

// class _FunctionCardState extends State<FunctionCard> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => widget.destinationPage),
//           );
//         },
//         child: AnimatedScale(
//           scale: _isHovered ? 1.05 : 1.0,
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.easeOut,
//           child: Container(
//             width: widget.width,
//             height: widget.height,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 image: AssetImage(widget.imagePath),
//                 fit: BoxFit.contain,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 4,
//                   spreadRadius: 1,
//                   offset: const Offset(2, 3),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
