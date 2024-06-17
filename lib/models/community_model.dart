class CommunityModel {
  int? id;
  int? countryId;
  int? adminId;
  String? country;
  String? name;
  String? description;
  String? location;
  String? status;
  String? createdAt;
  String? updatedAt;

  CommunityModel(
      {this.id,
      this.countryId,
      this.adminId,
      this.country,
      this.name,
      this.description,
      this.location,
      this.status,
      this.createdAt,
      this.updatedAt});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    adminId = json['admin_id'];
    country = json['country'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['admin_id'] = this.adminId;
    data['country'] = this.country;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
