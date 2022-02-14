//import 'package:ems/models/product.dart';

class StarredProduct {
  String? productId;
  String? userId;
  SProduct? product;
  SUser? user;
  bool? starred;
  String? createdAt;
  String? updatedAt;
  String? id;

  StarredProduct(
      {this.productId,
      this.userId,
      this.product,
      this.user,
      this.starred,
      this.createdAt,
      this.updatedAt,
      this.id});

  StarredProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    userId = json['userId'];
    product =
        json['product'] != null ? new SProduct.fromJson(json['product']) : null;
    user = json['user'] != null ? new SUser.fromJson(json['user']) : null;
    starred = json['starred'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['starred'] = this.starred;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class SProduct {
  dynamic? minPrice;
  dynamic? maxPrice;
  List<String>? onlineLinks;
  String? sId;
  String? name;
  String? detail;
  String? ref;
  String? businessId;
  String? userId;
  String? categoryId;
  String? locationId;
  String? category;
  SBusiness? business;
  String? plazaId;
  String? plaza;
  String? location;
  String? user;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? starred;

  SProduct(
      {this.minPrice,
      this.maxPrice,
      this.onlineLinks,
      this.sId,
      this.name,
      this.detail,
      this.ref,
      this.businessId,
      this.userId,
      this.categoryId,
      this.locationId,
      this.category,
      this.business,
      this.plazaId,
      this.plaza,
      this.location,
      this.user,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.starred});

  SProduct.fromJson(Map<String, dynamic> json) {
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    onlineLinks = json['onlineLinks'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    detail = json['detail'];
    ref = json['ref'];
    businessId = json['businessId'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    locationId = json['locationId'];
    category = json['category'];
    
    business = json['business'] != null
        ? new SBusiness.fromJson(json['business'])
        : null;
    plazaId = json['plazaId'];
    plaza = json['plaza'];
    location = json['location'];
    user = json['user'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    starred = json['starred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['onlineLinks'] = this.onlineLinks;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['ref'] = this.ref;
    data['businessId'] = this.businessId;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['locationId'] = this.locationId;
    data['category'] = this.category;
   
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    data['plazaId'] = this.plazaId;
    data['plaza'] = this.plaza;
    data['location'] = this.location;
    data['user'] = this.user;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['starred'] = this.starred;
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

class SUser {
  bool? status;
  bool? emailNotif;
  bool? verified;
  String? sId;
  String? firstname;
  String? lastname;
  String? phone;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SUser(
      {this.status,
      this.emailNotif,
      this.verified,
      this.sId,
      this.firstname,
      this.lastname,
      this.phone,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    emailNotif = json['emailNotif'];
    verified = json['verified'];
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['emailNotif'] = this.emailNotif;
    data['verified'] = this.verified;
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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

class SBusiness {
  bool? sellOnline;
  bool? acceptCash;
  bool? acceptCard;
  String? sId;
  String? name;
  String? detail;
  String? userId;
  String? plazaId;
  String? categoryId;
  String? category;
  String? plaza;
  String? user;
  String? locationId;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SBusiness(
      {this.sellOnline,
      this.acceptCash,
      this.acceptCard,
      this.sId,
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
      this.iV});

  SBusiness.fromJson(Map<String, dynamic> json) {
    sellOnline = json['sellOnline'];
    acceptCash = json['acceptCash'];
    acceptCard = json['acceptCard'];
   
    sId = json['_id'];
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
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellOnline'] = this.sellOnline;
    data['acceptCash'] = this.acceptCash;
    data['acceptCard'] = this.acceptCard;

    data['_id'] = this.sId;
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
    data['__v'] = this.iV;
    return data;
  }
}
