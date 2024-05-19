import 'package:consuming_rest_api/models/new_post.dart';
import 'package:consuming_rest_api/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final int? postID;

  const NoteModify({
    Key? key,
    this.postID,
  }) : super(key: key);

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.postID != null;

  PostService get postService => GetIt.I<PostService>();

  String? errorMessage;
  NewPost? post;

  bool isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        isLoading = true;
      });

      postService.getPost(widget.postID!).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An error occurred here";
        } else {
          post = response.data;
          if (post != null) {
            _titleController.text = post!.title;
            _bodyController.text = post!.body;
          }
        }
      }).catchError((error) {
        setState(() {
          isLoading = false;
          errorMessage = "An error occurred";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit note" : "Create note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  if (errorMessage != null) ...[
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                  ],
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Post title",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      hintText: "Post body",
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
