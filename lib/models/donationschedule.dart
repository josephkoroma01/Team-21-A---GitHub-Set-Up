class DonationSchedule {
  String? message;
  List<Schedule>? schedule;

  DonationSchedule({this.message, this.schedule});

  DonationSchedule.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
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

class Schedule {
  int? countryId;
  int? userId;
  String? country;
  String? donorType;
  String? name;
  String? agecategory;
  String? gender;
  String? address;
  String? phonenumber;
  String? email;
  String? district;
  String? maritalstatus;
  String? occupation;
  String? nextofkin;
  String? inextofkin;
  String? nokcontact;
  String? pid;
  String? pidnumber;
  String? vhbv;
  String? whenhbv;
  String? bgroup;
  String? facility;
  String? date;
  String? newdate;
  String? month;
  String? year;
  String? timeslot;
  String? refcode;
  String? status;
  String? review;
  int? rating;
  String? nextdonationdate;
  String? updatedAt;
  String? createdAt;
  int? id;

  Schedule(
      {this.countryId,
      this.userId,
      this.country,
      this.donorType,
      this.name,
      this.agecategory,
      this.gender,
      this.address,
      this.phonenumber,
      this.email,
      this.district,
      this.maritalstatus,
      this.occupation,
      this.nextofkin,
      this.inextofkin,
      this.nokcontact,
      this.pid,
      this.pidnumber,
      this.vhbv,
      this.whenhbv,
      this.bgroup,
      this.facility,
      this.date,
      this.newdate,
      this.month,
      this.year,
      this.timeslot,
      this.refcode,
      this.status,
      this.review,
      this.rating,
      this.nextdonationdate,
      this.updatedAt,
      this.createdAt,
      this.id});

  Schedule.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    userId = json['user_id'];
    country = json['country'];
    donorType = json['donor_type'];
    name = json['name'];
    agecategory = json['agecategory'];
    gender = json['gender'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    email = json['email'];
    district = json['district'];
    maritalstatus = json['maritalstatus'];
    occupation = json['occupation'];
    nextofkin = json['nextofkin'];
    inextofkin = json['inextofkin'];
    nokcontact = json['nokcontact'];
    pid = json['pid'];
    pidnumber = json['pidnumber'];
    vhbv = json['vhbv'];
    whenhbv = json['whenhbv'];
    bgroup = json['bgroup'];
    facility = json['facility'];
    date = json['date'];
    newdate = json['newdate'];
    month = json['month'];
    year = json['year'];
    timeslot = json['timeslot'];
    refcode = json['refcode'];
    status = json['status'];
    review = json['review'];
    rating = json['rating'];
    nextdonationdate = json['nextdonationdate'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['user_id'] = this.countryId;
    data['country'] = this.country;
    data['donor_type'] = this.donorType;
    data['name'] = this.name;
    data['agecategory'] = this.agecategory;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['email'] = this.email;
    data['district'] = this.district;
    data['maritalstatus'] = this.maritalstatus;
    data['occupation'] = this.occupation;
    data['nextofkin'] = this.nextofkin;
    data['inextofkin'] = this.inextofkin;
    data['nokcontact'] = this.nokcontact;
    data['pid'] = this.pid;
    data['pidnumber'] = this.pidnumber;
    data['vhbv'] = this.vhbv;
    data['whenhbv'] = this.whenhbv;
    data['bgroup'] = this.bgroup;
    data['facility'] = this.facility;
    data['date'] = this.date;
    data['newdate'] = this.newdate;
    data['month'] = this.month;
    data['year'] = this.year;
    data['timeslot'] = this.timeslot;
    data['refcode'] = this.refcode;
    data['status'] = this.status;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['nextdonationdate'] = this.nextdonationdate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
