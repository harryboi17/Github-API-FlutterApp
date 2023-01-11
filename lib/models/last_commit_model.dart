class LastCommitModel{
  final String message;
  final String author;
  final DateTime commitAt;

  const LastCommitModel({
    required this.message,
    required this.author,
    required this.commitAt,
  });

  factory LastCommitModel.fromMap(Map<String, dynamic> map) {
    return LastCommitModel(
      message: map['message'] as String,
      author: map['author']['name'] as String,
      commitAt: DateTime.parse(map['author']['date']),
    );
  }
}