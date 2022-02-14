class User {
  bool? status;
  bool? emailNotif;
  bool? verified;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? id;

  User(
      {this.status,
      this.emailNotif,
      this.verified,
      this.firstname,
      this.lastname,
      this.avatar,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    emailNotif = json['emailNotif'];
    verified = json['verified'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['emailNotif'] = this.emailNotif;
    data['verified'] = this.verified;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}