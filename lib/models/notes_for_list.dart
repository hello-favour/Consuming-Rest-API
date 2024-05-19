// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteForList {
  final String noteID;
  final String noteTitle;
  final DateTime createDateTime;
  final DateTime latestEditedTime;

  NoteForList({
    required this.noteID,
    required this.noteTitle,
    required this.createDateTime,
    required this.latestEditedTime,
  });
}
