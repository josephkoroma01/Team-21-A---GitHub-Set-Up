class CommunityDonorRequest {
  int? id;
  int? countryId;
  String? country;
  int? districtId;
  String? district;
  String? phonenumber;
  String? address;
  String? bloodtype;
  String? facility;
  String? ward;
  double? bloodlitres;
  String? date;
  String? month;
  String? year;
  String? status;
  String? createdAt;
  String? updatedAt;

  CommunityDonorRequest(
      {this.id,
      this.countryId,
      this.country,
      this.districtId,
      this.district,
      this.phonenumber,
      this.address,
      this.bloodtype,
      this.facility,
      this.ward,
      this.bloodlitres,
      this.date,
      this.month,
      this.year,
      this.status,
      this.createdAt,
      this.updatedAt});

  CommunityDonorRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    country = json['country'];
    districtId = json['district_id'];
    district = json['district'];
    phonenumber = json['phonenumber'];
    address = json['address'];
    bloodtype = json['bloodtype'];
    facility = json['facility'];
    ward = json['ward'];
    bloodlitres = json['bloodlitres'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['district_id'] = this.districtId;
    data['district'] = this.district;
    data['phonenumber'] = this.phonenumber;
    data['address'] = this.address;
    data['bloodtype'] = this.bloodtype;
    data['facility'] = this.facility;
    data['ward'] = this.ward;
    data['bloodlitres'] = this.bloodlitres;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
