class UserModel {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.sId,
      this.fullName,
      this.email,
      this.password,
      this.phoneNumber,
      this.address,
      this.city,
      this.state,
      this.profileProgress,
      this.id,
      this.updatedOn,
      this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['profileProgress'] = profileProgress;
    data['id'] = id;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}
