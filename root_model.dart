class RootModel {
  final int id;
  final String title;
  final bool isPublished;
  final double rating;

  const RootModel({required this.id, required this.title, required this.isPublished, required this.rating, });

  factory RootModel.fromJson(Map<String, dynamic> json) => RootModel(
    id: json['id'] as int,
    title: json['title'] as String,
    isPublished: json['isPublished'] as bool,
    rating: json['rating'] as double,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isPublished': isPublished,
    'rating': rating,
  };

  RootModel copyWith({
    int? id,
    String? title,
    bool? isPublished,
    double? rating,
  }) => RootModel(
    id: id ?? this.id,
    title: title ?? this.title,
    isPublished: isPublished ?? this.isPublished,
    rating: rating ?? this.rating,
  );

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is RootModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      title == other.title &&
      isPublished == other.isPublished &&
      rating == other.rating &&
      true;

  @override
  int get hashCode =>
    id.hashCode ^
    title.hashCode ^
    isPublished.hashCode ^
    rating.hashCode ^
    0;
}
