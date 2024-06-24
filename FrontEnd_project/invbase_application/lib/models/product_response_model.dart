class ProductResponseModel {
  List<DataResponse> data;

  ProductResponseModel({
    required this.data,
  });

  factory ProductResponseModel.fromJson(List<dynamic> json) {
    return ProductResponseModel(
      data: json.map((e) => DataResponse.fromJson(e)).toList(),
    );
  }
}

class DataResponse {
  int id;
  String name;
  int qty;
  String imageUrl;
  int categoryId;
  int createdBy;
  int updatedBy;

  DataResponse({
    required this.id,
    required this.name,
    required this.qty,
    required this.imageUrl,
    required this.categoryId,
    required this.createdBy,
    required this.updatedBy,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      id: json['id'],
      name: json['name'],
      qty: json['qty'],
      imageUrl: json['imageUrl'],
      categoryId: json['categoryId'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'qty': qty,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }
}
