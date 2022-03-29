class DistinationModel {
  int id;
  String title;
  String image;
  String content;

  DistinationModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });
  factory DistinationModel.fromJson(Map<String, dynamic> json) {
    return DistinationModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        content: json['content']);
  }
}
