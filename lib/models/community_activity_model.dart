class CommunityActivity {
  int? id;
  int? donorGroupId;
  int? createdBy;
  String? title;
  String? description;
  String? location;
  String? activityDate;
  String? createdAt;
  String? updatedAt;

  CommunityActivity(
      {this.id,
      this.donorGroupId,
      this.createdBy,
      this.title,
      this.description,
      this.location,
      this.activityDate,
      this.createdAt,
      this.updatedAt});

  CommunityActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donorGroupId = json['donor_group_id'];
    createdBy = json['created_by'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    activityDate = json['activity_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['donor_group_id'] = this.donorGroupId;
    data['created_by'] = this.createdBy;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['activity_date'] = this.activityDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
