import 'package:consuming_rest_api/models/notes_for_list.dart';
import 'package:consuming_rest_api/views/note_delete.dart';
import 'package:consuming_rest_api/views/note_modify.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  // const NoteList({super.key});

  final notes = [
    NoteForList(
      noteID: "1",
      noteTitle: "Note 1",
      createDateTime: DateTime.now(),
      latestEditedTime: DateTime.now(),
    ),
    NoteForList(
      noteID: "2",
      noteTitle: "Note 2",
      createDateTime: DateTime.now(),
      latestEditedTime: DateTime.now(),
    ),
    NoteForList(
      noteID: "3",
      noteTitle: "Note 3",
      createDateTime: DateTime.now(),
      latestEditedTime: DateTime.now(),
    ),
  ];

  String formateDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of notes"),
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
      body: ListView.separated(
        itemCount: notes.length,
        separatorBuilder: (BuildContext context, index) => const Divider(
          height: 1,
          color: Colors.green,
        ),
        itemBuilder: (BuildContext context, index) {
          final fetchNotes = notes[index];
          return Dismissible(
            key: ValueKey(fetchNotes.noteID),
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
                    builder: (context) => NoteModify(noteID: fetchNotes.noteID),
                  ),
                );
              },
              title: Text(
                fetchNotes.noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                  "Last edited on ${formateDateTime(fetchNotes.latestEditedTime)}"),
            ),
          );
        },
      ),
    );
  }
}
