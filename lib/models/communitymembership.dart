class CommunityMembership {
  int? id;
  int? donorGroupId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  CommunityMembership(
      {this.id,
      this.donorGroupId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  CommunityMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donorGroupId = json['donor_group_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['donor_group_id'] = this.donorGroupId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
