// create a class ManageAppointmentProvider
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/bhloodtestschedule_model.dart';
import '../models/donationschedule.dart';

class ManageAppoiynmentProvider extends ChangeNotifier {
  List<TestSchedule> _bloodtestAppointments = [];

  List<TestSchedule> get bloodtestAppointments => _bloodtestAppointments;

  List<Schedule> _blooddonationAppointments = [];

  List<Schedule> get blooddonationAppointments => _blooddonationAppointments;

  int? totalBloodTestSchedule;
  int? totalBloodTestScheduleMyself;
  int? totalBloodTestScheduleOthers;
  int? totalBloodTestScheduleResult;
  int? totalBloodDonationReplacement;
  int? totalBloodDonationVolumtary;

  int? userId;

  Future getBloodTestAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloostestschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        BloodTestSchedule data = BloodTestSchedule.fromJson(jsonData);

        List<TestSchedule> schedules = data.schedule!;

        print(data);

        _bloodtestAppointments = schedules;
        totalBloodTestSchedule = _bloodtestAppointments.length;
        totalBloodTestScheduleMyself = _bloodtestAppointments
            .where((item) => item.bloodtestfor == 'Myself')
            .length;
        totalBloodTestScheduleOthers = _bloodtestAppointments
            .where((item) => item.bloodtestfor != 'Myself')
            .length;
        totalBloodTestScheduleResult =
            _bloodtestAppointments.where((item) => item.result == 'Yes').length;
        prefs.setInt('totalschedule', totalBloodTestSchedule!);
        prefs.setInt('BcountMyself', totalBloodTestScheduleMyself!);
        prefs.setInt('BcountOther', totalBloodTestScheduleOthers!);
        prefs.setInt('Bresult', totalBloodTestScheduleResult!);
        notifyListeners();
        return bloodtestAppointments;
      } else {}
    } catch (e) {}
  }

  Future getBloodDonationAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloosdonationschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        DonationSchedule data = DonationSchedule.fromJson(jsonData);

        List<Schedule> schedules = data.schedule!;
        print(data);
        _blooddonationAppointments = schedules;
        totalBloodDonationReplacement = _blooddonationAppointments
            .where((item) => item.donorType == 'Replacement')
            .length;
        totalBloodDonationVolumtary = _blooddonationAppointments
            .where((item) => item.donorType == 'Volunteer')
            .length;
        prefs.setInt('replacement', totalBloodDonationReplacement!);
        prefs.setInt('voluntary', totalBloodDonationVolumtary!);

        notifyListeners();
        return bloodtestAppointments;
      } else {}
    } catch (e) {}
  }
}
