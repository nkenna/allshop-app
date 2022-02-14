class HomePlazaData {
  String? plazaId;
  Loc? loc;
  Plaza? plaza;
  String? createdAt;
  String? updatedAt;
  String? id;

  HomePlazaData(
      {this.plazaId,
      this.loc,
      this.plaza,
      this.createdAt,
      this.updatedAt,
      this.id});

  HomePlazaData.fromJson(Map<String, dynamic> json) {
    plazaId = json['plazaId'];
    loc = json['loc'] != null ? new Loc.fromJson(json['loc']) : null;
    plaza = json['plaza'] != null ? new Plaza.fromJson(json['plaza']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plazaId'] = this.plazaId;
    if (this.loc != null) {
      data['loc'] = this.loc!.toJson();
    }
    if (this.plaza != null) {
      data['plaza'] = this.plaza!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
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

class Plaza {
  String? name;
  String? detail;
  String? userId;
  bool? status;
  bool? adminControl;
  String? locationId;
  String? sId;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? location;
  List<Images>? images;

  Plaza(
      {this.name,
      this.detail,
      this.userId,
      this.status,
      this.adminControl,
      this.locationId,
      this.sId,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.location,
      this.images});

  Plaza.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    status = json['status'];
    adminControl = json['adminControl'];
    locationId = json['locationId'];
    sId = json['_id'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    location = json['location'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['adminControl'] = this.adminControl;
    data['locationId'] = this.locationId;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['location'] = this.location;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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
