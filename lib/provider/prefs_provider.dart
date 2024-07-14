import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Home/models/user_model.dart';

class PrefsProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> savePref(User data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', data.email!);
    prefs.setString('name', data.name.toString());
    prefs.setString('uname', data.username.toString());
    prefs.setString('avatar', data.avartar.toString());
    prefs.setString('gender', data.gender.toString());
    prefs.setString('agecategory', data.ageCategory.toString());
    prefs.setString('age', data.age.toString());
    prefs.setString('dob', data.dob.toString());
    prefs.setString('country', data.country.toString());
    prefs.setString('country_id', data.countryId.toString());
    prefs.setString('phonenumber', data.phone.toString());
    prefs.setString('address', data.address.toString());
    prefs.setString('district', data.distict.toString());
    prefs.setString('bloodtype', data.bloodGroup.toString());
    prefs.setString('prevdonation', data.prvdonation.toString());
    prefs.setString('prevdonationamt', data.prvdonationNo.toString());
    prefs.setInt('donationamt', data.noOfDonation!);
    prefs.setString('community', data.community.toString());
    prefs.setInt('id', data.id!);

    _user = data;
    notifyListeners();
  }

  Future<void> getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email == null) {
      return;
    }

    _user = User(
      email: email,
      name: prefs.getString('name') ?? '',
      username: prefs.getString('uname') ?? '',
      avartar: prefs.getString('avatar') ?? '',
      gender: prefs.getString('gender') ?? '',
      ageCategory: prefs.getString('agecategory') ?? '',
      age: prefs.getString('age') ?? '',
      dob: prefs.getString('dob') ?? '',
      country: prefs.getString('country') ?? '',
      countryId: prefs.getString('country_id') ?? '',
      phone: prefs.getString('phonenumber') ?? '',
      address: prefs.getString('address') ?? '',
      distict: prefs.getString('district') ?? '',
      bloodGroup: prefs.getString('bloodtype') ?? '',
      prvdonation: prefs.getString('prevdonation') ?? '',
      prvdonationNo: prefs.getString('prevdonationamt') ?? '',
      noOfDonation: prefs.getInt('donationamt') ?? 0,
      community: prefs.getString('community') ?? '',
      id: prefs.getInt('id') ?? 0,
    );
    notifyListeners();
  }

  Future<void> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
    notifyListeners();
  }

  String userId = '';

  getUserId(Id) {
    userId = Id;
    notifyListeners();
  }
}
