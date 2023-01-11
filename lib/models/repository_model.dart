class Repository{
  final String name;
  final String url;
  final String description;
  final String commitUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewers;
  final bool isPublic;

  const Repository({
    required this.name,
    required this.url,
    required this.description,
    required this.commitUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isPublic,
    required this.viewers,
  });

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      name: map['name'] as String,
      url: map['html_url'] as String,
      description: map['description'] ?? ' ',
      commitUrl: map['url']+"/commits" as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isPublic: map['visibility'] == 'public' ? true : false,
      viewers: map['watchers'] ?? 0,
    );
  }
}