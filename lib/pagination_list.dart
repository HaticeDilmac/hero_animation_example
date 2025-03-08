import 'package:flutter/material.dart';

class PaginationListPage extends StatefulWidget {
  const PaginationListPage({super.key});

  @override
  State<PaginationListPage> createState() => _PaginationListPageState();
}

class _PaginationListPageState extends State<PaginationListPage> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true; //Daha fazla veri var mı yok mu kontrol eder
  @override
  void initState() {
    super.initState();
  }

  //from API - pagination support
  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return; //yükleniyorsa çağırma
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination List'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {}),
    );
  }
}
