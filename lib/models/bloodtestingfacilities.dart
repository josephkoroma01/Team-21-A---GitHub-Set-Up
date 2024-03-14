class BloodTestingFacilities {
  BloodTestingFacilities(
      {
      required this.country,
      required this.region,
      required this.address,
      required this.facilityname,
      required this.facilityaddress,
      required this.servicetype,
      required this.price,
      required this.rating, 
      required this.status});

  factory BloodTestingFacilities.fromJson(Map<String, dynamic> json) {
    return BloodTestingFacilities(
        country: json['country'].toString(),
        region: json['region'].toString(),
        address: json['address'].toString(),
        facilityname: json['facilityname'].toString(),
        facilityaddress: json['facilityaddress'].toString(),
        servicetype: json['servicetype'].toString(),
        price: json['price'].toString(),
        rating: json['rating'].toString(),
        status: json['status'].toString(),
        );
  }

  String country;
  String region;
  String address;
  String facilityname;
  String facilityaddress;
  String servicetype;
  String price;
  String rating;
  String status;

  Map<String, dynamic> toJson() => {
        'country': country,
        'region': region,
        'address': address,
        'facilityname': facilityname,
        'facilityaddress': facilityaddress,
        'servicetype': servicetype,
        'price': price,
        'rating': rating, 
        'status': status
      };
}
