class Conversation {
  String? user1Id;
  String? user2Id;
  User1? user1;
  User2? user2;
  String? createdAt;
  String? updatedAt;
  String? id;
  LastMessage? lastMessage;
  String? lastMessageId;

  Conversation(
      {this.user1Id,
      this.user2Id,
      this.user1,
      this.user2,
      this.lastMessage,
      this.lastMessageId,
      this.createdAt,
      this.updatedAt,
      this.id});

  Conversation.fromJson(Map<String, dynamic> json) {
    user1Id = json['user1Id'];
    user2Id = json['user2Id'];
    user1 = json['user1'] != null ? new User1.fromJson(json['user1']) : null;
    user2 = json['user2'] != null ? new User2.fromJson(json['user2']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
     lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    lastMessageId = json['lastMessageId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user1Id'] = this.user1Id;
    data['user2Id'] = this.user2Id;
    if (this.user1 != null) {
      data['user1'] = this.user1!.toJson();
    }
    if (this.user2 != null) {
      data['user2'] = this.user2!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class User1 {
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
  String? avatar;

  User1(
      {this.status,
      this.emailNotif,
      this.verified,
      this.avatar,
      this.sId,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.wallet});

  User1.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    emailNotif = json['emailNotif'];
    verified = json['verified'];
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
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

class User2 {
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

  User2(
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

  User2.fromJson(Map<String, dynamic> json) {
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

class LastMessage {
  bool? read;
  String? sId;
  String? content;
  String? senderId;
  String? recieverId;
  String? type;
  String? sender;
  String? reciever;
  String? conversationId;
  String? conversation;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LastMessage(
      {this.read,
      this.sId,
      this.content,
      this.senderId,
      this.recieverId,
      this.type,
      this.sender,
      this.reciever,
      this.conversationId,
      this.conversation,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LastMessage.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    sId = json['_id'];
    content = json['content'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    type = json['type'];
    sender = json['sender'];
    reciever = json['reciever'];
    conversationId = json['conversationId'];
    conversation = json['conversation'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['senderId'] = this.senderId;
    data['recieverId'] = this.recieverId;
    data['type'] = this.type;
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;
    data['conversationId'] = this.conversationId;
    data['conversation'] = this.conversation;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

