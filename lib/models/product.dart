class Product {
  dynamic minPrice;
  dynamic maxPrice;
  List<String>? onlineLinks;
  String? name;
  String? detail;
  String? ref;
  bool? starred;
  String? businessId;
  String? userId;
  String? categoryId;
  String? locationId;
  Category? category;
  Business? business;
  Plaza? plaza;
  String? user;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  String? id;
  dynamic ratingCount;
  dynamic sumRating;
  dynamic avgRating;
  List<SocialLinks>? socialLinks;
  



  Product(
      {
        this.starred,
        this.ratingCount,
        this.socialLinks,
        this.sumRating,
        this.avgRating,
        this.minPrice,
      this.maxPrice,
      this.onlineLinks,
      this.name,
      this.detail,
      this.ref,
      this.businessId,
      this.userId,
      this.categoryId,
      this.locationId,
      this.category,
      this.business,
      this.plaza,
      this.user,
      this.images,
      this.createdAt,
      this.updatedAt,
      
      this.id});


  Product.fromJson(Map<String, dynamic> json) {
    ratingCount = json['ratingCount'];
    starred = json['starred'];
    sumRating = json['sumRating'];
    avgRating = json['avgRating'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];

    if (json['socialLinks'] != null) {
      socialLinks = <SocialLinks>[];
      json['socialLinks'].forEach((v) {
        socialLinks!.add(new SocialLinks.fromJson(v));
      });
    }
  
    //onlineLinks = json['onlineLinks'] == null ? List.empty() : json['onlineLinks'].cast<String>();
    name = json['name'];
    detail = json['detail'];
    ref = json['ref'];
    businessId = json['businessId'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    locationId = json['locationId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    plaza = json['plaza'] != null ? new Plaza.fromJson(json['plaza']) : null;
    user = json['user'];
    if (json['images'] != null) {
      images = [];
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
    //data['onlineLinks'] = this.onlineLinks;
    data['name'] = this.name;
    data['detail'] = this.detail;
    if (this.socialLinks != null) {
      data['socialLinks'] = this.socialLinks!.map((v) => v.toJson()).toList();
    }
    data['ref'] = this.ref;
    data['businessId'] = this.businessId;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['locationId'] = this.locationId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.plaza != null) {
      data['plaza'] = this.plaza!.toJson();
    }
    data['user'] = this.user;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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

class Business {
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
  String? address;
  String? contactPhone;
  
  int? iV;

  Business(
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
      this.address,
      this.contactPhone,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Business.fromJson(Map<String, dynamic> json) {
    sellOnline = json['sellOnline'];
    acceptCash = json['acceptCash'];
    acceptCard = json['acceptCard'];
    
    sId = json['_id'];
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    plazaId = json['plazaId'];
       address = json['address'];
    contactPhone = json['contactPhone'];
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

class SocialLinks {
  String? sId;
  String? linkTitle;
  String? linkUrl;

  SocialLinks({this.sId, this.linkTitle, this.linkUrl});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    linkTitle = json['linkTitle'];
    linkUrl = json['linkUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['linkTitle'] = this.linkTitle;
    data['linkUrl'] = this.linkUrl;
    return data;
  }
}