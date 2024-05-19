class PostInsert {
  final int userId;
  final String title;
  final String body;

  PostInsert({
    required this.userId,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  factory PostInsert.fromJson(Map<String, dynamic> map) {
    return PostInsert(
      userId: map['userId'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}
