class Category {
  final String? name;
  final List<Story>? stories;
  final String? image;
  final bool? status;

  Category({
    required this.name,
    required this.stories,
    required this.image,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      stories: List<Story>.from(
          json['stories'].map((story) => Story.fromJson(story))),
      image: json['image'],
      status: json['status'],
    );
  }
}

class Story {
  final int? id;
  final int? watchedCount;
  final String? videoLink;
  final String storyCategory;
  final String? duration;
  final String? title;
  final String? image;
  final String? videoFile;
  final String? type;
  final String? description;
  final bool? active;
  final DateTime? createdAt;
  final int? video;
  final int? category;
  final int? level;
  final dynamic createdBy;

  Story({
    required this.id,
    required this.watchedCount,
    this.videoLink,
    required this.storyCategory,
    this.duration,
    required this.title,
    this.image,
    this.videoFile,
    required this.type,
    required this.description,
    required this.active,
    required this.createdAt,
    required this.video,
    required this.category,
    required this.level,
    this.createdBy,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      watchedCount: json['watched_count'],
      videoLink: json['video_link'],
      storyCategory: json['story_category'],
      duration: json['duration'],
      title: json['title'],
      image: json['image'],
      videoFile: json['video_file'],
      type: json['type'],
      description: json['description'],
      active: json['active'],
      createdAt: DateTime.parse(json['created_at']),
      video: json['video'],
      category: json['category'],
      level: json['level'],
      createdBy: json['created_by'],
    );
  }
}
