import 'home_product.dart';

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
  Images? image;
  String? category;
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
      this.image,
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
    category = json['category'];
    plaza = json['plaza'];
    user = json['user'];
    locationId = json['locationId'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['imageData'] != null
        ? new Images.fromJson(json['imageData'])
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
    data['userId'] = this.userId;
    data['plazaId'] = this.plazaId;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
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


