class Plaza {
  String? name;
  String? detail;
  String? userId;
  bool? status;
  bool? adminControl;
  String? locationId;
  User? user;
  String? createdAt;
  String? updatedAt;
  Location? location;
  List<Images>? images;
  String? id;

  Plaza(
      {this.name,
      this.detail,
      this.userId,
      this.status,
      this.adminControl,
      this.locationId,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.images,
      this.id});

  Plaza.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    status = json['status'];
    adminControl = json['adminControl'];
    locationId = json['locationId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['adminControl'] = this.adminControl;
    data['locationId'] = this.locationId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class User {
  bool? status;
  bool? emailNotif;
  bool? verified;
  String? sId;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.status,
      this.emailNotif,
      this.verified,
      this.sId,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    emailNotif = json['emailNotif'];
    verified = json['verified'];
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
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
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? country;
  String? state;
  String? city;
  String? address;
  String? landmark;
  String? type;
  String? userId;
  String? plazaId;
  String? sId;
  Loc? loc;
  String? plaza;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Location(
      {this.country,
      this.state,
      this.city,
      this.address,
      this.landmark,
      this.type,
      this.userId,
      this.plazaId,
      this.sId,
      this.loc,
      this.plaza,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Location.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    landmark = json['landmark'];
    type = json['type'];
    userId = json['userId'];
    plazaId = json['plazaId'];
    sId = json['_id'];
    loc = json['loc'] != null ? new Loc.fromJson(json['loc']) : null;
    plaza = json['plaza'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['plazaId'] = this.plazaId;
    data['_id'] = this.sId;
    if (this.loc != null) {
      data['loc'] = this.loc!.toJson();
    }
    data['plaza'] = this.plaza;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Loc {
  List<double>? coordinates;
  String? sId;
  String? type;

  Loc({this.coordinates, this.sId, this.type});

  Loc.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    sId = json['_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['_id'] = this.sId;
    data['type'] = this.type;
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