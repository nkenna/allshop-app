class Service {
  bool? verified;
  bool? status;
  String? name;
  String? detail;
  String? businessId;
  String? userId;
  String? categoryId;
  Category? category;
  Business? business;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? id;

  Service(
      {this.verified,
      this.status,
      this.name,
      this.detail,
      this.businessId,
      this.userId,
      this.categoryId,
      this.category,
      this.business,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.id});

  Service.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
    name = json['name'];
    detail = json['detail'];
    businessId = json['businessId'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['businessId'] = this.businessId;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
  String? sId;
  String? name;

  Business({this.sId, this.name});

  Business.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class User {
  String? sId;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? avatar;

  User(
      {this.sId,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
