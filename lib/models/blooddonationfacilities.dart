class BloodDonationFacilities {
  BloodDonationFacilities(
      {
      required this.country,
      required this.district,
      required this.address,
      required this.name,
      required this.communityname,
      required this.status});

  factory BloodDonationFacilities.fromJson(Map<String, dynamic> json) {
    return BloodDonationFacilities(
        country: json['country'].toString(),
        district: json['district'].toString(),
        address: json['address'].toString(),
        name: json['name'].toString(),
        communityname: json['communityname'].toString(),
        status: json['status'].toString(),
        );
  }

  String country;
  String district;
  String address;
  String name;
  String communityname;
  String status;

  Map<String, dynamic> toJson() => {
        'country': country,
        'district': district,
        'name': name,
        'address': address,
        'communityname': communityname,
        'status': status
      };
}
