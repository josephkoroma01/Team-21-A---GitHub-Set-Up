class BloodTestSchedule {
  String? message;
  List<TestSchedule>? schedule;

  BloodTestSchedule({this.message, this.schedule});

  BloodTestSchedule.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['schedule'] != null) {
      schedule = <TestSchedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(TestSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestSchedule {
  int? id;
  String? districtId;
  int? countryId;
  int? facilityId;
  int? userId;
  String? country;
  String? district;
  String? bloodtestfor;
  String? name;
  String? agecategory;
  String? gender;
  String? phone;
  String? email;
  String? schedulerphonenumber;
  String? address;
  String? facility;
  String? date;
  String? month;
  String? year;
  String? time;
  String? refcode;
  String? status;
  String? result;
  String? onSite;
  String? bgroup;
  String? rh;
  String? bgrouprh;
  String? phenotype;
  String? kell;
  String? review;
  String? rating;
  String? createdAt;
  String? updatedAt;

  TestSchedule(
      {this.id,
      this.districtId,
      this.countryId,
      this.facilityId,
      this.userId,
      this.country,
      this.district,
      this.bloodtestfor,
      this.name,
      this.agecategory,
      this.gender,
      this.phone,
      this.email,
      this.schedulerphonenumber,
      this.address,
      this.facility,
      this.date,
      this.month,
      this.year,
      this.time,
      this.refcode,
      this.status,
      this.result,
      this.onSite,
      this.bgroup,
      this.rh,
      this.bgrouprh,
      this.phenotype,
      this.kell,
      this.review,
      this.rating,
      this.createdAt,
      this.updatedAt});

  TestSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    countryId = json['country_id'];
    facilityId = json['facility_id'];
    userId = json['user_id'];
    country = json['country'];
    district = json['district'];
    bloodtestfor = json['bloodtestfor'];
    name = json['name'];
    agecategory = json['agecategory'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    schedulerphonenumber = json['schedulerphonenumber'];
    address = json['address'];
    facility = json['facility'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    time = json['time'];
    refcode = json['refcode'];
    status = json['status'];
    result = json['result'];
    onSite = json['onSite'];
    bgroup = json['bgroup'];
    rh = json['rh'];
    bgrouprh = json['bgrouprh'];
    phenotype = json['phenotype'];
    kell = json['kell'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['country_id'] = this.countryId;
    data['facility_id'] = this.facilityId;
    data['user_id'] = this.userId;
    data['country'] = this.country;
    data['district'] = this.district;
    data['bloodtestfor'] = this.bloodtestfor;
    data['name'] = this.name;
    data['agecategory'] = this.agecategory;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['schedulerphonenumber'] = this.schedulerphonenumber;
    data['address'] = this.address;
    data['facility'] = this.facility;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['time'] = this.time;
    data['refcode'] = this.refcode;
    data['status'] = this.status;
    data['result'] = this.result;
    data['onSite'] = this.onSite;
    data['bgroup'] = this.bgroup;
    data['rh'] = this.rh;
    data['bgrouprh'] = this.bgrouprh;
    data['phenotype'] = this.phenotype;
    data['kell'] = this.kell;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
