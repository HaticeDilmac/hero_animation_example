import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationListPage extends StatefulWidget {
  const PaginationListPage({super.key});

  @override
  State<PaginationListPage> createState() => _PaginationListPageState();
}

class _PaginationListPageState extends State<PaginationListPage> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;  
  int _page = 1; //Current page number (Starting with 1).
  final int _limit =
      10; //Determines how many posts will be retrieved in each API request.

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _scrollController
        .addListener(_scrollListener); //Listens for scroll movements
  }

  //from API - pagination support
  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return;  
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit'));

    if (response.statusCode == 200) {
      //if api call is successfully
      List<Map<String, dynamic>> newPosts =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      setState(() {
        _posts.addAll(newPosts); //decode list add post list
        _isLoading = false;
        _page++; //new paga number add
//If the API sends less data than the limit, we know there is no more data and stop the upload.
        if (newPosts.length < _limit) {
          _hasMore = false; //more data not found
        }
      });
    } else {
      setState(() {
        _isLoading = false; //if data is not success , isloading state false
        throw Exception('Failed to load posts');
      });
    }
  }

//Checks when the end of the page is reached
  void _scrollListener() {
    //_scrollController.position.pixels => Returns the users current scroll position
    //_scrollController.position.maxScrollExtent => Returns the bottom border of the page
    //if the user is 200px above the bottom border, we automatically load new data :)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination List'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: _posts.length + 1, //but loading
          itemBuilder: (context, index) {
            if (index == _posts.length) {
              return _hasMore
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(
                      child: Text('All Data finished'),
                    );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(_posts[index]['title']),
                  subtitle: Text(_posts[index]['body']),
                ),
              ),
            );
          }),
    );
  }
}
