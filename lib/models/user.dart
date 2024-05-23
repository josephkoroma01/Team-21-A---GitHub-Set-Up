class User {
  final String userid;
  final String fullname;
  final String dob;
  final String age;
  final String agecategory;
  final String gender;
  final String avatar;
  final String emailaddress;
  final String homeaddress;
  final String country;
  final String bloodgroup;
  final String prevdonation;
  final String prevdonationamt;
  final String phonenumber;
  final String password;
  final String community;
  final String trivia;
  final String date;
  final String month;
  final String year;

  User(
      {required this.userid,
      required this.fullname,
      required this.dob,
      required this.age,
      required this.agecategory,
      required this.gender,
      required this.avatar,
      required this.emailaddress,
      required this.homeaddress,
      required this.country,
      required this.bloodgroup,
      required this.prevdonation,
      required this.prevdonationamt,
      required this.phonenumber,
      required this.password,
      required this.community,
      required this.trivia,
      required this.date,
      required this.month,
      required this.year});

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'fullname': fullname,
      'dob': dob,
      'age': age,
      'agecategory': agecategory,
      'gender': gender,
      'avatar': avatar,
      'emailaddress': emailaddress,
      'homeaddress': homeaddress,
      'country': country,
      'bloodgroup': bloodgroup,
      'prevdonation': prevdonation,
      'prevdonationamt': prevdonationamt,
      'phonenumber': phonenumber,
      'password': password,
      'community': community,
      'trivia': trivia,
      'date': date,
      'month': month,
      'year': year
    };
  }
}
