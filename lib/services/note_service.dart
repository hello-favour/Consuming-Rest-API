import 'package:consuming_rest_api/models/notes_for_list.dart';

class NoteService {
  List<NoteForList> getNotesList() {
    return [
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
  }
}
