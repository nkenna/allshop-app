class Category {
  List<SubCategories>? subCategories;
  String? name;
  String? type;
  String? parentCategoryId;
  ParentCategory? parentCategory;
  String? createdAt;
  String? updatedAt;
  String? id;

  Category(
      {this.subCategories,
      this.name,
      this.type,
      this.parentCategoryId,
      this.parentCategory,
      this.createdAt,
      this.updatedAt,
      this.id});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    name = json['name'];
    type = json['type'];
    parentCategoryId = json['parentCategoryId'];
    parentCategory = json['parentCategory'] != null
        ? new ParentCategory.fromJson(json['parentCategory'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['type'] = this.type;
    data['parentCategoryId'] = this.parentCategoryId;
    if (this.parentCategory != null) {
      data['parentCategory'] = this.parentCategory!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class SubCategories {
  String? sId;
  String? name;
  String? type;
  String? parentCategoryId;
  String? parentCategory;
  String? createdAt;
  String? updatedAt;

  SubCategories(
      {this.sId,
      this.name,
      this.type,
      this.parentCategoryId,
      this.parentCategory,
      this.createdAt,
      this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    parentCategoryId = json['parentCategoryId'];
    parentCategory = json['parentCategory'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['parentCategoryId'] = this.parentCategoryId;
    data['parentCategory'] = this.parentCategory;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ParentCategory {
  String? sId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  ParentCategory(
      {this.sId, this.name, this.type, this.createdAt, this.updatedAt});

  ParentCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
