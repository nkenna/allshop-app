class Business {
  bool? sellOnline;
  bool? acceptCash;
  bool? acceptCard;
  String? name;
  String? detail;
  String? userId;
  String? plazaId;
  String? categoryId;
  Category? category;
  Plaza? plaza;
  String? user;
  Images? image;
  String? locationId;
  String? createdAt;
  String? updatedAt;
  String? id;

  Business(
      {this.sellOnline,
      this.acceptCash,
      this.acceptCard,
      this.name,
      this.image,
      this.detail,
      this.userId,
      this.plazaId,
      this.categoryId,
      this.category,
      this.plaza,
      this.user,
      this.locationId,
      this.createdAt,
      this.updatedAt,
      this.id});

  Business.fromJson(Map<String, dynamic> json) {
    sellOnline = json['sellOnline'];
    acceptCash = json['acceptCash'];
    acceptCard = json['acceptCard'];
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    plazaId = json['plazaId'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    plaza = json['plaza'] != null ? new Plaza.fromJson(json['plaza']) : null;
    user = json['user'];
    locationId = json['locationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    image = json['imageData'] != null
        ? new Images.fromJson(json['imageData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellOnline'] = this.sellOnline;
    data['acceptCash'] = this.acceptCash;
    data['acceptCard'] = this.acceptCard;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['userId'] = this.userId;
    data['plazaId'] = this.plazaId;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.plaza != null) {
      data['plaza'] = this.plaza!.toJson();
    }
    data['user'] = this.user;
    data['locationId'] = this.locationId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Plaza {
  String? name;
  String? sId;

  Plaza({this.name, this.sId});

  Plaza.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

class Images {
  String? sId;
  String? imageUrl;
  String? imageName;
  String? imageType;

  Images({this.sId, this.imageUrl, this.imageName, this.imageType});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imageUrl = json['imageUrl'];
    imageName = json['imageName'];
    imageType = json['imageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['imageUrl'] = this.imageUrl;
    data['imageName'] = this.imageName;
    data['imageType'] = this.imageType;
    return data;
  }
}