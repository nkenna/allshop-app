class HomeProduct {
  dynamic? minPrice;
  dynamic maxPrice;
  dynamic? ratingCount;
  dynamic? sumRating;
  dynamic? avgRating;
  String? name;
  String? detail;
  String? ref;
  String? businessId;
  String? adminId;
  String? categoryId;
  String? locationId;
  String? plazaId;
  String? location;
  String? admin;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  String? id;

  HomeProduct(
      {this.minPrice,
      this.maxPrice,
      this.ratingCount,
      this.sumRating,
      this.avgRating,
      this.name,
      this.detail,
      this.ref,
      this.businessId,
      this.adminId,
      this.categoryId,
      this.locationId,
      this.plazaId,
      this.location,
      this.admin,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.id});

  HomeProduct.fromJson(Map<String, dynamic> json) {
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    ratingCount = json['ratingCount'];
    sumRating = json['sumRating'];
    avgRating = json['avgRating'];
    name = json['name'];
    detail = json['detail'];
    ref = json['ref'];
    businessId = json['businessId'];
    adminId = json['adminId'];
    categoryId = json['categoryId'];
    locationId = json['locationId'];
    plazaId = json['plazaId'];
    location = json['location'];
    admin = json['admin'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['ratingCount'] = this.ratingCount;
    data['sumRating'] = this.sumRating;
    data['avgRating'] = this.avgRating;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['ref'] = this.ref;
    data['businessId'] = this.businessId;
    data['adminId'] = this.adminId;
    data['categoryId'] = this.categoryId;
    data['locationId'] = this.locationId;
    data['plazaId'] = this.plazaId;
    data['location'] = this.location;
    data['admin'] = this.admin;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
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

