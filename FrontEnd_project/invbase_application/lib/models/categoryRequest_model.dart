// ignore_for_file: file_names

class CategoryRequestModel {
  int? id;
  String? name;

  CategoryRequestModel({
    this.id,
    this.name,
  });

  CategoryRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = name;
    data['name'] = name;
    return data;
  }
}
