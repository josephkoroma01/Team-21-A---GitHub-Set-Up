class CommunityGroup {
  String? message;
  Group? group;

  CommunityGroup({this.message, this.group});

  CommunityGroup.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class Group {
  String? countryId;
  String? country;
  String? name;
  String? description;
  String? location;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Group(
      {this.countryId,
      this.country,
      this.name,
      this.description,
      this.location,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Group.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    country = json['country'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
