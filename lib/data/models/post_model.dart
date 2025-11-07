class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int reactions;
  final int views;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
    required this.views,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: _parseInt(json['id']),
      title: _parseString(json['title']),
      body: _parseString(json['body']),
      userId: _parseInt(json['userId']),
      tags: _parseStringList(json['tags']),
      reactions: _parseInt(json['reactions']),
      views: _parseInt(json['views']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is Map) {
      return value['name']?.toString() ??
             value['slug']?.toString() ??
             value['title']?.toString() ??
             value['value']?.toString() ??
             '';
    }
    return value.toString();
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => _parseString(e)).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'tags': tags,
      'reactions': reactions,
      'views': views,
    };
  }
}
