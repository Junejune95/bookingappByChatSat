class FAQModel {
  String title;
  String content;
  FAQModel({required this.title, required this.content});
  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(title: json['title'], content: json['content']);
  }
}
