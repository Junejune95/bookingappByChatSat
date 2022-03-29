class DestinationModel {
  int id;
  String title;
  String image;
  String content;

  DestinationModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });
  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        content: json['content']);
  }
}
