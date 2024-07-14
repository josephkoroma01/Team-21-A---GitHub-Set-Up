class DonationDrives {
  int? id;
  int? countryId;
  int? tfsId;
  String? country;
  String? tfsName;
  String? creatorid;
  String? campaignname;
  String? campaigndescription;
  String? phonenumber;
  String? email;
  String? campaignfacility;
  String? campaignlocation;
  String? targeteddistrict;
  String? targetedarea;
  int? targetpopulation;
  String? bloodcomponent;
  int? targetedbloodliters;
  String? daterange;
  String? date;
  String? month;
  String? year;
  String? status;
  Null? createdAt;
  Null? updatedAt;

  DonationDrives(
      {this.id,
      this.countryId,
      this.tfsId,
      this.country,
      this.tfsName,
      this.creatorid,
      this.campaignname,
      this.campaigndescription,
      this.phonenumber,
      this.email,
      this.campaignfacility,
      this.campaignlocation,
      this.targeteddistrict,
      this.targetedarea,
      this.targetpopulation,
      this.bloodcomponent,
      this.targetedbloodliters,
      this.daterange,
      this.date,
      this.month,
      this.year,
      this.status,
      this.createdAt,
      this.updatedAt});

  DonationDrives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    tfsId = json['tfs_id'];
    country = json['country'];
    tfsName = json['tfs_name'];
    creatorid = json['creatorid'];
    campaignname = json['campaignname'];
    campaigndescription = json['campaigndescription'];
    phonenumber = json['phonenumber'];
    email = json['email'];
    campaignfacility = json['campaignfacility'];
    campaignlocation = json['campaignlocation'];
    targeteddistrict = json['targeteddistrict'];
    targetedarea = json['targetedarea'];
    targetpopulation = json['targetpopulation'];
    bloodcomponent = json['bloodcomponent'];
    targetedbloodliters = json['targetedbloodliters'];
    daterange = json['daterange'];
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
    data['tfs_id'] = this.tfsId;
    data['country'] = this.country;
    data['tfs_name'] = this.tfsName;
    data['creatorid'] = this.creatorid;
    data['campaignname'] = this.campaignname;
    data['campaigndescription'] = this.campaigndescription;
    data['phonenumber'] = this.phonenumber;
    data['email'] = this.email;
    data['campaignfacility'] = this.campaignfacility;
    data['campaignlocation'] = this.campaignlocation;
    data['targeteddistrict'] = this.targeteddistrict;
    data['targetedarea'] = this.targetedarea;
    data['targetpopulation'] = this.targetpopulation;
    data['bloodcomponent'] = this.bloodcomponent;
    data['targetedbloodliters'] = this.targetedbloodliters;
    data['daterange'] = this.daterange;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
