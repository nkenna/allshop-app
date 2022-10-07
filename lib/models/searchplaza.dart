class SearchPlaza {
  String? name;
  String? detail;
  String? userId;
  String? adminId;
  bool? status;
  bool? adminControl;
  String? locationId;
  String? user;
  String? createdAt;
  String? updatedAt;
  String? location;
  List<Images>? images;
  String? id;

  SearchPlaza(
      {this.name,
      this.detail,
      this.userId,
      this.adminId,
      this.status,
      this.adminControl,
      this.locationId,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.images,
      this.id});

  SearchPlaza.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    userId = json['userId'];
    adminId = json['adminId'];
    status = json['status'];
    adminControl = json['adminControl'];
    locationId = json['locationId'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    location = json['location'];
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
    data['adminId'] = this.adminId;
    data['status'] = this.status;
    data['adminControl'] = this.adminControl;
    data['locationId'] = this.locationId;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['location'] = this.location;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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