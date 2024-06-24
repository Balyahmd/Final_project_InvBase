class ProductModel {
  List<ProductData>? data;

  ProductModel({this.data});

  ProductModel.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      data = <ProductData>[];
      for (var v in json) {
        data!.add(ProductData.fromJson(v));
      }
    }
  }

  int? get categoryId => null;

  get name => null;

  get qty => null;

  get imageUrl => null;

  get id => null;

  List<dynamic> toJson() {
    final List<dynamic> data = <dynamic>[];
    if (this.data != null) {
      data.addAll(this.data!.map((v) => v.toJson()).toList());
    }
    return data;
  }
}

class ProductData {
  int? id;
  String? name;
  int? qty;
  int? categoryId;
  String? imageUrl;
  String? createDate;
  String? updateDate;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Category? category;
  User? user;

  ProductData({
    this.id,
    this.name,
    this.qty,
    this.categoryId,
    this.imageUrl,
    this.createDate,
    this.updateDate,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.user,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category =
        json['Category'] != null ? Category.fromJson(json['Category']) : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (category != null) {
      data['Category'] = category!.toJson();
    }
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.name, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? password;
  String? image;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.password,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
