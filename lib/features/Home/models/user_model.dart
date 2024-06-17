class Users {
  String? message;
  String? token;
  User? user;

  Users({this.message, this.token, this.user});

  Users.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  int? noOfDonation;
  String? dob;
  String? age;
  String? ageCategory;
  String? avartar;
  String? gender;
  String? country;
  String? countryId;
  String? distict;
  String? address;
  String? email;
  String? phone;
  String? prvdonation;
  String? prvdonationNo;
  String? donorId;
  String? bloodGroup;
  String? emailVerifiedAt;
  String? community;
  String? trivia;
  String? status;
  String? date;
  String? month;
  String? year;
  int? otp;
  String? otpExpiresAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.username,
      this.noOfDonation,
      this.dob,
      this.age,
      this.ageCategory,
      this.avartar,
      this.gender,
      this.country,
      this.countryId,
      this.distict,
      this.address,
      this.email,
      this.phone,
      this.prvdonation,
      this.prvdonationNo,
      this.donorId,
      this.bloodGroup,
      this.emailVerifiedAt,
      this.community,
      this.trivia,
      this.status,
      this.date,
      this.month,
      this.year,
      this.otp,
      this.otpExpiresAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    noOfDonation = json['no_of_donations'];
    dob = json['dob'];
    age = json['age'];
    ageCategory = json['ageCategory'];
    avartar = json['avartar'];
    gender = json['gender'];
    country = json['country'];
    countryId = json['country_id'];
    distict = json['distict'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    prvdonation = json['prvdonation'];
    prvdonationNo = json['prvdonationNo'];
    donorId = json['donorId'];
    bloodGroup = json['bloodGroup'];
    emailVerifiedAt = json['email_verified_at'];
    community = json['community'];
    trivia = json['trivia'];
    status = json['status'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    otp = json['otp'];
    otpExpiresAt = json['otp_expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['no_of_donations'] = this.noOfDonation;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['ageCategory'] = this.ageCategory;
    data['avartar'] = this.avartar;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['distict'] = this.distict;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['prvdonation'] = this.prvdonation;
    data['prvdonationNo'] = this.prvdonationNo;
    data['donorId'] = this.donorId;
    data['bloodGroup'] = this.bloodGroup;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['community'] = this.community;
    data['trivia'] = this.trivia;
    data['status'] = this.status;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['otp'] = this.otp;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
