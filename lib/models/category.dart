class Category {
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? id;

  Category({this.name, this.type, this.createdAt, this.updatedAt, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
