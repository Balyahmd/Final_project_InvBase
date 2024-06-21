class ProductResponseModel {
  DataResponse? data;

  ProductResponseModel({this.data});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataResponse.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataResponse {
  int? id;
  String? name;
  int? qty;
  int? categoryId;
  String? imageUrl;
  String? createDate;
  String? updateDate;
  String? createdBy;
  String? updatedBy;

  DataResponse({
    this.id,
    this.name,
    this.qty,
    this.categoryId,
    this.imageUrl,
    this.createDate,
    this.updateDate,
    this.createdBy,
    this.updatedBy,
  });

  DataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['qty'] = qty;
    data['categoryId'] = categoryId;
    data['imageUrl'] = imageUrl;
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    return data;
  }
}
