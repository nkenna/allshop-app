//import 'home_product.dart';

import 'package:ems/models/business.dart';

class HomeStore {
  bool? sellOnline;
  bool? acceptCash;
  bool? acceptCard;
  int? ratingCount;
  int? sumRating;
  int? avgRating;
  String? name;
  String? detail;
  String? userId;
  String? plazaId;
  String? categoryId;
  ImageData? imageData;
  Category? category;
  String? plaza;
  String? user;
  String? locationId;
  String? location;
  String? createdAt;
  String? updatedAt;
  String? id;

  HomeStore(
      {this.sellOnline,
      this.acceptCash,
      this.acceptCard,
      this.ratingCount,
      this.sumRating,
      this.imageData,
      this.avgRating,
      this.name,
      this.detail,
      this.userId,
      this.plazaId,
      this.categoryId,
      this.category,
      this.plaza,
      this.user,
      this.locationId,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.id});

  HomeStore.fromJson(Map<String, dynamic> json) {
    sellOnline = json['sellOnline'];
    acceptCash = json['acceptCash'];
    acceptCard = json['acceptCard'];
    ratingCount = json['ratingCount'];
    sumRating = json['sumRating'];
    avgRating = json['avgRating'];
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    plazaId = json['plazaId'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    plaza = json['plaza'];
    user = json['user'];
    locationId = json['locationId'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imageData = json['imageData'] != null
        ? new ImageData.fromJson(json['imageData'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellOnline'] = this.sellOnline;
    data['acceptCash'] = this.acceptCash;
    data['acceptCard'] = this.acceptCard;
    data['ratingCount'] = this.ratingCount;
    data['sumRating'] = this.sumRating;
    data['avgRating'] = this.avgRating;
    data['name'] = this.name;
    data['detail'] = this.detail;
     if (this.imageData != null) {
      data['imageData'] = this.imageData!.toJson();
    }
    data['userId'] = this.userId;
    data['plazaId'] = this.plazaId;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['plaza'] = this.plaza;
    data['user'] = this.user;
    data['locationId'] = this.locationId;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}


class ImageData {
  String? sId;
  String? imageUrl;
  String? imageName;
  String? imageType;

  ImageData({this.sId, this.imageUrl, this.imageName, this.imageType});

  ImageData.fromJson(Map<String, dynamic> json) {
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
