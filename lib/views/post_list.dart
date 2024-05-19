import 'package:consuming_rest_api/models/api_response.dart';
import 'package:consuming_rest_api/models/post_data.dart';
import 'package:consuming_rest_api/services/post_service.dart';
import 'package:consuming_rest_api/views/note_delete.dart';
import 'package:consuming_rest_api/views/post_modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  PostService get service => GetIt.I<PostService>();

  APIResponse<List<PostData>>? apiResponse;

  bool _isLoading = false;

  String formateDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }

  _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    apiResponse = await service.getPostsList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Posts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NoteModify(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (apiResponse!.error) {
            return Center(
              child: Text(apiResponse!.errorMessage.toString()),
            );
          }
          return ListView.separated(
            itemCount: apiResponse!.data!.length,
            separatorBuilder: (BuildContext context, index) => const Divider(
              height: 1,
              color: Colors.green,
            ),
            itemBuilder: (BuildContext context, index) {
              final posts = apiResponse!.data![index];
              return Dismissible(
                key: ValueKey(posts.userId),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direct) async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) => const NoteDelete(),
                  );
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 16),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteModify(postID: posts.id),
                      ),
                    );
                  },
                  title: Text(
                    posts.title,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(
                    posts.body,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
