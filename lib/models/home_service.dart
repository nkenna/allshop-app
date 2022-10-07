class HomeService {
  bool? verified;
  bool? status;
  String? name;
  String? detail;
  String? businessId;
  String? userId;
  String? categoryId;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? id;

  HomeService(
      {this.verified,
      this.status,
      this.name,
      this.detail,
      this.businessId,
      this.userId,
      this.categoryId,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.id});

  HomeService.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
    name = json['name'];
    detail = json['detail'];
    businessId = json['businessId'];
    userId = json['userId'];
    categoryId = json['categoryId'];
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
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


