class Message {
  bool? read;
  String? content;
  String? senderId;
  String? recieverId;
  Media? media;
  String? type;
  Sender? sender;
  Reciever? reciever;
  String? conversationId;
  String? conversation;
  String? createdAt;
  String? updatedAt;
  String? id;

  Message(
      {this.read,
      this.content,
      this.senderId,
      this.recieverId,
      this.media,
      this.type,
      this.sender,
      this.reciever,
      this.conversationId,
      this.conversation,
      this.createdAt,
      this.updatedAt,
      this.id});

  Message.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    content = json['content'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    type = json['type'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    reciever = json['reciever'] != null
        ? new Reciever.fromJson(json['reciever'])
        : null;
    conversationId = json['conversationId'];
    conversation = json['conversation'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['content'] = this.content;
    data['senderId'] = this.senderId;
    data['recieverId'] = this.recieverId;
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    data['type'] = this.type;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.reciever != null) {
      data['reciever'] = this.reciever!.toJson();
    }
    data['conversationId'] = this.conversationId;
    data['conversation'] = this.conversation;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Media {
  String? sId;
  String? url;
  String? name;
  String? type;

  Media({this.sId, this.url, this.name, this.type});

  Media.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Sender {
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
  String? wallet;

  Sender(
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
      this.iV,
      this.wallet});

  Sender.fromJson(Map<String, dynamic> json) {
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
    wallet = json['wallet'];
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
    data['wallet'] = this.wallet;
    return data;
  }
}

class Reciever {
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
  String? avatar;

  Reciever(
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
      this.iV,
      this.avatar});

  Reciever.fromJson(Map<String, dynamic> json) {
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
    avatar = json['avatar'];
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
    data['avatar'] = this.avatar;
    return data;
  }
}