class Facility {
  int? id;
  String? countryId;
  String? country;
  String? rbtc;
  String? rbtcId;
  String? district;
  String? tfsId;
  String? fullname;
  String? name;
  String? address;
  String? communityname;
  String? regionalcode;
  String? testPrice;
  String? status;
  String? date;
  String? month;
  String? year;
  String? createdAt;
  String? updatedAt;

  Facility(
      {this.id,
      this.countryId,
      this.country,
      this.rbtc,
      this.rbtcId,
      this.district,
      this.tfsId,
      this.fullname,
      this.name,
      this.address,
      this.communityname,
      this.regionalcode,
      this.testPrice,
      this.status,
      this.date,
      this.month,
      this.year,
      this.createdAt,
      this.updatedAt});

  Facility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    country = json['country'];
    rbtc = json['rbtc'];
    rbtcId = json['rbtc_id'];
    district = json['district'];
    tfsId = json['tfs_id'];
    fullname = json['fullname'];
    name = json['name'];
    address = json['address'];
    communityname = json['communityname'];
    regionalcode = json['regionalcode'];
    testPrice = json['test_price'];
    status = json['status'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['rbtc'] = this.rbtc;
    data['rbtc_id'] = this.rbtcId;
    data['district'] = this.district;
    data['tfs_id'] = this.tfsId;
    data['fullname'] = this.fullname;
    data['name'] = this.name;
    data['address'] = this.address;
    data['communityname'] = this.communityname;
    data['regionalcode'] = this.regionalcode;
    data['test_price'] = this.testPrice;
    data['status'] = this.status;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
