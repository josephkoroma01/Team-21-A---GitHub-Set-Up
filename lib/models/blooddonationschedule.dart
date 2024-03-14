class BloodDonationSchAppdata {
  BloodDonationSchAppdata(
      {required this.donortype,
      required this.nextofkin,
      required this.inextofkin,
      required this.pid,
      required this.bloodgroup,
      required this.facility,
      required this.date,
      required this.timeslot,
      required this.refcode,
      required this.status,
      required this.review,
      required this.rating,
      required this.nextdonationdate,
      required this.created_at});

  factory BloodDonationSchAppdata.fromJson(Map<String, dynamic> json) {
    return BloodDonationSchAppdata(
        donortype: json['donor_type'].toString(),
        nextofkin: json['nextofkin'].toString(),
        inextofkin: json['inextofkin'].toString(),
        pid: json['pid'].toString(),
        bloodgroup: json['bgroup'].toString(),
        facility: json['facility'].toString(),
        date: json['date'].toString(),
        timeslot: json['timeslot'].toString(),
        refcode: json['refcode'].toString(),
        status: json['status'].toString(),
        review: json['review'].toString(),
        rating: json['rating'].toString(),
        nextdonationdate: json['nextdonationdate'].toString(),
        created_at: json['created_at']);
  }

  String bloodgroup;
  String created_at;
  String date;
  String donortype;
  String facility;
  String inextofkin;
  String nextdonationdate;
  String nextofkin;
  String pid;
  String rating;
  String refcode;
  String review;
  String status;
  String timeslot;

  Map<String, dynamic> toJson() => {
        'donortype': donortype,
        'nextofkin': nextofkin,
        'inextofkin': inextofkin,
        'pid': pid,
        'bloodgroup': bloodgroup,
        'facility': facility,
        'date': date,
        'timeslot': timeslot,
        'refcode': refcode,
        'status': status,
        'review': review,
        'nextdonationdate': nextdonationdate,
        'rating': rating,
        'created_at': created_at,
      };
}
