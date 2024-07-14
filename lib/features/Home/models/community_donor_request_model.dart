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

  CommunityDonorRequest({
    this.id,
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
    this.updatedAt,
  });

  factory CommunityDonorRequest.fromJson(Map<String, dynamic> json) {
    return CommunityDonorRequest(
      id: json['id'],
      countryId: json['country_id'],
      country: json['country'],
      districtId: json['district_id'],
      district: json['district'],
      phonenumber: json['phonenumber'],
      address: json['address'],
      bloodtype: json['bloodtype'],
      facility: json['facility'],
      ward: json['ward'],
      bloodlitres: json['bloodlitres'],
      date: json['date'],
      month: json['month'],
      year: json['year'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_id': countryId,
      'country': country,
      'district_id': districtId,
      'district': district,
      'phonenumber': phonenumber,
      'address': address,
      'bloodtype': bloodtype,
      'facility': facility,
      'ward': ward,
      'bloodlitres': bloodlitres,
      'date': date,
      'month': month,
      'year': year,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
