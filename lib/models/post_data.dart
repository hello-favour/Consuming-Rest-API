class PostData {
  final int userId;
  final int id;
  final String title;
  final String body;
  PostData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostData.fromJson(Map<String, dynamic> map) {
    return PostData(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}
