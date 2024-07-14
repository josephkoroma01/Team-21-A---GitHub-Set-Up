import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationModel {
  int? id;
  String? countryId;
  String?
      forUser; // Changed 'for' to 'forUser' because 'for' is a reserved keyword.
  String? title;
  String? message;
  Data? data;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.countryId,
    this.forUser,
    this.title,
    this.message,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    forUser = json['for'];
    title = json['title'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['for'] = forUser;
    data['title'] = title;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  String? type;

  Data({this.type});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}

Future<List<NotificationModel>> getNotifications(String country) async {
  String url =
      "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/notification/$country";
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<NotificationModel> notifications =
          jsonData.map((e) => NotificationModel.fromJson(e)).toList();
          return notifications.reversed.toList();
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    print(e);
    throw Exception(e.toString());
  }
}
