import 'package:flutter/material.dart';
import 'animated_entrance.dart';
import 'detail_page.dart';
import 'pagination_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  final List<Map<String, String>> items = const [
    {
      'title': 'Galata Kulesi',
      'image': 'https://arkeofili.com/wp-content/uploads/2020/07/ayasofya1.jpg'
    },
    {
      'title': 'Ayasofya',
      'image': 'https://arkeofili.com/wp-content/uploads/2020/07/ayasofya1.jpg'
    },
    {
      'title': 'Topkapı Sarayı',
      'image': 'https://arkeofili.com/wp-content/uploads/2020/07/ayasofya1.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstanbul Gezi Listesi'),
        actions: [
          //pagination list example page iconButton
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaginationListPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedEntrance(
              duration: const Duration(milliseconds: 1800),
              child: Material(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['title']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DetailPage(item: item),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
