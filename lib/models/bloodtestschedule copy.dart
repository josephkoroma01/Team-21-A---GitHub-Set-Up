class BloodTestSchAppdata {
  BloodTestSchAppdata(
      {required this.bloodtestfor,
      required this.firstname,
      required this.middlename,
      required this.lastname,
      required this.gender,
      required this.phonenumber,
      required this.email,
      required this.address,
      required this.facility,
      required this.date,
      required this.timeslot,
      required this.refcode,
      required this.status,
      required this.created_at});

  factory BloodTestSchAppdata.fromJson(Map<String, dynamic> json) {
    return BloodTestSchAppdata(
        bloodtestfor: json['bloodtestfor'],
        firstname: json['firstname'],
        middlename: json['middlename'],
        lastname: json['lastname'],
        gender: json['gender'],
        phonenumber: json['phonenumber'].toString(),
        email: json['email'],
        address: json['address'],
        facility: json['facility'],
        date: json['date'],
        timeslot: json['timeslot'].toString(),
        refcode: json['refcode'].toString(),
        status: json['status'],
        created_at: json['created_at']);
  }

  String address;
  String bloodtestfor;
  String created_at;
  String date;
  String email;
  String facility;
  String firstname;
  String gender;
  String lastname;
  String middlename;
  String phonenumber;
  String refcode;
  String status;
  String timeslot;

  Map<String, dynamic> toJson() => {
        'bloodtestfor': bloodtestfor,
        'firstname': firstname,
        'middlename': middlename,
        'lastname': lastname,
        'gender': gender,
        'phonenumber': phonenumber,
        'email': email,
        'address': address,
        'facility': facility,
        'date': date,
        'timeslot': timeslot,
        'refcode': refcode,
        'status': status,
        'created_at': created_at,
      };
}