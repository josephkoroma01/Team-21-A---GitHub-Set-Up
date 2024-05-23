import 'package:lifebloodworld/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<bool> doesRowExist(
      String tableName, String columnName, String value) async {
    Database _db = await database();
    final result = await _db
        .rawQuery('SELECT * FROM $tableName WHERE $columnName = ?', [value]);
    return result.isNotEmpty;
  }

  Future<bool> doesUserRowExist(String value, String secvalue) async {
    Database _db = await database();
    final result = await _db.rawQuery(
        "SELECT * FROM nurse WHERE emailaddress = '$value' AND password='$secvalue'");
    return result.isNotEmpty;
  }

  Future<List<Map<String, Object?>>> getNumber(
      String tableName, String columnName, String value) async {
    Database _db = await database();
    final result = await _db
        .rawQuery('SELECT * FROM $tableName WHERE $columnName = ?', [value]);
    return result;
  }

  Future<bool> checkNumber(
      String tableName, String columnName, String value) async {
    Database _db = await database();
    final result = await _db
        .rawQuery('SELECT * FROM $tableName WHERE $columnName = ?', [value]);
    return result.isNotEmpty;
  }

  Future<bool> doesStatusExist(String tableName, String requestid, String month,
      String year, String status) async {
    Database _db = await database();
    final result = await _db.rawQuery(
      "SELECT * FROM $tableName WHERE requestid = '$requestid' AND status = '$status' AND year = '$year' AND month = '$month'",
    );
    return result.isNotEmpty;
  }

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'clinician.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE user(id INTEGER foregroundColor KEY AUTOINCREMENT, userid TEXT, fullname TEXT, dob TEXT, age TEXT, agecategory TEXT, gender TEXT, avatar TEXT, emailaddress TEXT, homeaddress TEXT, country TEXT, bloodgroup TEXT, prevdonation TEXT, prevdonationamt TEXT, phonenumber TEXT, password TEXT, community TEXT, trivia TEXT, date TEXT, month TEXT, year TEXT)");
        await db.execute(
            "CREATE TABLE blooddonationappointment(id INTEGER foregroundColor KEY AUTOINCREMENT, appointmentid TEXT, fullname TEXT, dob TEXT, age TEXT, agecategory TEXT, gender TEXT, emailaddress TEXT, homeaddress TEXT, phonenumber TEXT, maritalstatus TEXT, occupation TEXT, inextofkin TEXT, nokcontact TEXT, pid TEXT, pidnumber TEXT, vhbv TEXT, whenhbv TEXT, bgroup TEXT, facility TEXT, facilityaddress TEXT, date TEXT, newdate TEXT, time TEXT, refcode TEXT, status TEXT, review TEXT, rating TEXT, nextdonationdate TEXT, month TEXT, year TEXT)");
        await db.execute(
            "CREATE TABLE bloodgroupappointment(id INTEGER foregroundColor KEY AUTOINCREMENT, appointmentid TEXT, bloodtestfor TEXT, fullname TEXT, dob TEXT, age TEXT, agecategory TEXT, gender TEXT, emailaddress TEXT, homeaddress TEXT, phonenumber TEXT, schedulerphonenumber TEXT, facility TEXT, facilityaddress TEXT, date TEXT, time TEXT, refcode TEXT, status TEXT, result TEXT, bgroup TEXT, rh TEXT, bgrouprh TEXT, phenotype TEXT, kell TEXT, review TEXT, rating TEXT, month TEXT, year TEXT)");
        await db.execute(
            "CREATE TABLE donationcampaigndonor(id INTEGER foregroundColor KEY AUTOINCREMENT, fullname TEXT, dob TEXT, age TEXT, agecategory TEXT, donorphonenumber TEXT, donoremail TEXT, maritalstatus TEXT, occupation TEXT, nextofkin TEXT, inextofkin TEXT, nokcontact TEXT, pid TEXT, pidnumber TEXT, vhbv TEXT, whenhbv TEXT, bgroup TEXT, campaignid TEXT, campaignname TEXT, campaigncreator TEXT, campaigndescription TEXT, campaigncontact TEXT, campaignemail TEXT, facility TEXT, campaignfacility TEXT, campaignlocation TEXT, campaigndistrict TEXT, campaigndate TEXT, campaigndatecreated TEXT, campaignstatus TEXT, date TEXT, month TEXT, year TEXT, refcode TEXT, status TEXT, review TEXT, rating TEXT)");
        return;
      },
      version: 1,
    );
  }

  Future<int> insertUser(User user) async {
    int userid = 0;
    Database _db = await database();
    await _db
        .insert('user', user.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      userid = value;
    });
    return userid;
  }

  Future<void> updatePatientStatus(String patientid, String status) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE patient SET status = '$status' WHERE patientid = '$patientid'");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  // Future<List<Team>> getTeamData(String name) async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> nursekMap =
  //       await _db.rawQuery("SELECT * FROM team WHERE name = '$name'");
  //   return List.generate(nursekMap.length, (index) {
  //     return Team(
  //         rbtc_id: nursekMap[index]['rbtc_id'].toString(),
  //         tfs_id: nursekMap[index]['tfs_id'].toString(),
  //         tfs_name: nursekMap[index]['tfs_name'].toString(),
  //         leadtype: nursekMap[index]['leadtype'].toString(),
  //         name: nursekMap[index]['name'].toString(),
  //         department: nursekMap[index]['department'].toString(),
  //         teamname: nursekMap[index]['teamname'].toString(),
  //         team: nursekMap[index]['team'].toString(),
  //         phonenumber: nursekMap[index]['phonenumber'].toString(),
  //         date: nursekMap[index]['date'].toString(),
  //         month: nursekMap[index]['month'].toString(),
  //         year: nursekMap[index]['year'].toString(),
  //         status: nursekMap[index]['status'].toString());
  //   });
  // }

  // Future<List<Nurse>> getNurseData(String emailaddress, String password) async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> nursekMap = await _db.rawQuery(
  //       "SELECT * FROM nurse WHERE emailaddress = '$emailaddress' AND password = '$password'");
  //   return List.generate(nursekMap.length, (index) {
  //     return Nurse(
  //         rbtc_id: nursekMap[index]['rbtc_id'].toString(),
  //         tfs_id: nursekMap[index]['tfs_id'].toString(),
  //         tfs_name: nursekMap[index]['tfs_name'].toString(),
  //         nurselevel: nursekMap[index]['nurselevel'].toString(),
  //         name: nursekMap[index]['name'].toString(),
  //         gender: nursekMap[index]['gender'].toString(),
  //         phonenumber: nursekMap[index]['phonenumber'].toString(),
  //         emailaddress: nursekMap[index]['emailaddress'].toString(),
  //         password: nursekMap[index]['password'].toString(),
  //         ward: nursekMap[index]['ward'].toString(),
  //         wardname: nursekMap[index]['wardname'].toString(),
  //         tablead: nursekMap[index]['tablead'].toString(),
  //         tableadphonenumber: nursekMap[index]['tableadphonenumber'].toString(),
  //         tabphonenumber: nursekMap[index]['tabphonenumber'].toString(),
  //         date: nursekMap[index]['date'].toString(),
  //         month: nursekMap[index]['month'].toString(),
  //         year: nursekMap[index]['year'].toString(),
  //         status: nursekMap[index]['status'].toString());
  //   });
  // }

  // Future<List<Labstaff>> getLabstaff() async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> labstaffkMap =
  //       await _db.rawQuery("SELECT * FROM labstaff");
  //   return List.generate(labstaffkMap.length, (index) {
  //     return Labstaff(
  //         rbtc_id: labstaffkMap[index]['tfs_id'].toString(),
  //         tfs_id: labstaffkMap[index]['tfs_id'].toString(),
  //         tfs_name: labstaffkMap[index]['tfs_name'].toString(),
  //         name: labstaffkMap[index]['name'].toString(),
  //         gender: labstaffkMap[index]['gender'].toString(),
  //         phonenumber: labstaffkMap[index]['phonenumber'].toString(),
  //         emailaddress: labstaffkMap[index]['emailaddress'].toString(),
  //         date: labstaffkMap[index]['date'].toString(),
  //         month: labstaffkMap[index]['month'].toString(),
  //         year: labstaffkMap[index]['year'].toString(),
  //         status: labstaffkMap[index]['status'].toString());
  //   });
  // }

  // Future<List<Doctor>> getDoctorNumber(String doctorname) async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> doctorkMap =
  //       await _db.rawQuery("SELECT * FROM doctor WHERE name='$doctorname'");
  //   return List.generate(doctorkMap.length, (index) {
  //     return Doctor(
  //         rbtc_id: doctorkMap[index]['rbtc_id'].toString(),
  //         tfs_id: doctorkMap[index]['tfs_id'].toString(),
  //         tfs_name: doctorkMap[index]['tfs_name'].toString(),
  //         doctorlevel: doctorkMap[index]['name'].toString(),
  //         specialty: doctorkMap[index]['name'].toString(),
  //         team: doctorkMap[index]['name'].toString(),
  //         name: doctorkMap[index]['name'].toString(),
  //         gender: doctorkMap[index]['gender'].toString(),
  //         phonenumber: doctorkMap[index]['phonenumber'].toString(),
  //         emailaddress: doctorkMap[index]['emailaddress'].toString(),
  //         date: doctorkMap[index]['date'].toString(),
  //         month: doctorkMap[index]['month'].toString(),
  //         year: doctorkMap[index]['year'].toString(),
  //         status: doctorkMap[index]['status'].toString());
  //   });
  // }

  // Future<List<PreTransfusionChecks>> getPreTransfusionChecks(
  //     String value, String bagvalue) async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> compatibilitykMap = await _db.rawQuery(
  //       "SELECT * FROM pretransfusionchecks WHERE requestid = '$value' AND bagid = '$bagvalue'");
  //   return List.generate(compatibilitykMap.length, (index) {
  //     return PreTransfusionChecks(
  //         rbtc_id: compatibilitykMap[index]['rbtc_id'].toString(),
  //         tfs_id: compatibilitykMap[index]['tfs_id'].toString(),
  //         tfs_name: compatibilitykMap[index]['tfs_name'].toString(),
  //         ward: compatibilitykMap[index]['ward'].toString(),
  //         reason: compatibilitykMap[index]['reason'].toString(),
  //         duration: compatibilitykMap[index]['duration'].toString(),
  //         gender: compatibilitykMap[index]['gender'].toString(),
  //         presidingdoctor:
  //             compatibilitykMap[index]['presidingdoctor'].toString(),
  //         cunitnumber: compatibilitykMap[index]['cunitnumber'].toString(),
  //         patientid: compatibilitykMap[index]['patientid'].toString(),
  //         requestid: compatibilitykMap[index]['requestid'].toString(),
  //         bagid: compatibilitykMap[index]['bagid'].toString(),
  //         consent: compatibilitykMap[index]['consent'].toString(),
  //         cpatientid: compatibilitykMap[index]['cpatientid'].toString(),
  //         bdtransfusion: compatibilitykMap[index]['bdtransfusion'].toString(),
  //         bloodtfcon: compatibilitykMap[index]['bloodtfcon'].toString(),
  //         compatibility: compatibilitykMap[index]['compatibility'].toString(),
  //         cannula: compatibilitykMap[index]['cannula'].toString(),
  //         nurse1: compatibilitykMap[index]['nurse1'].toString(),
  //         nurse2: compatibilitykMap[index]['nurse2'].toString(),
  //         healthstaff: compatibilitykMap[index]['healthstaff'].toString(),
  //         date: compatibilitykMap[index]['date'].toString(),
  //         time: compatibilitykMap[index]['time'].toString(),
  //         month: compatibilitykMap[index]['month'].toString(),
  //         year: compatibilitykMap[index]['year'].toString(),
  //         status: compatibilitykMap[index]['status'].toString(),
  //         uploaded: compatibilitykMap[index]['uploaded'].toString());
  //   });
  // }

  // Future<List<Patient>> getPatients(String value, bool search) async {
  //   Database _db = await database();
  //   if (search == true) {
  //     List<Map<String, dynamic>> patientkMap = await _db.rawQuery(
  //         "SELECT * FROM patient WHERE name LIKE '%$value%' OR  surname LIKE '%$value%' OR patientid LIKE '%$value%' OR  gender LIKE '%$value%' OR phonenumber LIKE '%$value%' OR diagnosis LIKE '%$value%' OR status LIKE '%$value%' ORDER by id DESC");
  //     return List.generate(patientkMap.length, (index) {
  //       return Patient(
  //           rbtc_id: patientkMap[index]['rbtc_id'].toString(),
  //           tfs_id: patientkMap[index]['tfs_id'].toString(),
  //           tfs_name: patientkMap[index]['tfs_name'].toString(),
  //           ward: patientkMap[index]['ward'].toString(),
  //           type: patientkMap[index]['type'].toString(),
  //           surname: patientkMap[index]['surname'].toString(),
  //           name: patientkMap[index]['name'].toString(),
  //           gender: patientkMap[index]['gender'].toString(),
  //           phonenumber: patientkMap[index]['phonenumber'].toString(),
  //           weight: patientkMap[index]['weight'].toString(),
  //           patientid: patientkMap[index]['patientid'].toString(),
  //           psr: patientkMap[index]['psr'].toString(),
  //           abo: patientkMap[index]['abo'].toString(),
  //           rh: patientkMap[index]['rh'].toString(),
  //           aborh: patientkMap[index]['aborh'].toString(),
  //           phenotype: patientkMap[index]['phenotype'].toString(),
  //           kell: patientkMap[index]['kell'].toString(),
  //           age: patientkMap[index]['age'].toString(),
  //           agecategory: patientkMap[index]['agecategory'].toString(),
  //           patienttype: patientkMap[index]['patienttype'].toString(),
  //           diagnosis: patientkMap[index]['diagnosis'].toString(),
  //           hb: patientkMap[index]['hb'].toString(),
  //           previoustransfusion:
  //               patientkMap[index]['previoustransfusion'].toString(),
  //           previoustransfusiondate:
  //               patientkMap[index]['previoustransfusiondate'].toString(),
  //           previoustransfusionreaction:
  //               patientkMap[index]['previoustransfusionreaction'].toString(),
  //           previoustransfusionreactiondesc: patientkMap[index]
  //                   ['previoustransfusionreactiondesc']
  //               .toString(),
  //           previouspregnancies:
  //               patientkMap[index]['previouspregnancies'].toString(),
  //           para: patientkMap[index]['para'].toString(),
  //           gravida: patientkMap[index]['gravida'].toString(),
  //           ppother: patientkMap[index]['ppother'].toString(),
  //           department: patientkMap[index]['department'].toString(),
  //           teamname: patientkMap[index]['teamname'].toString(),
  //           team: patientkMap[index]['team'].toString(),
  //           healthstaff: patientkMap[index]['healthstaff'].toString(),
  //           reaction: patientkMap[index]['reaction'].toString(),
  //           date: patientkMap[index]['date'].toString(),
  //           time: patientkMap[index]['time'].toString(),
  //           month: patientkMap[index]['month'].toString(),
  //           year: patientkMap[index]['year'].toString(),
  //           status: patientkMap[index]['status'].toString(),
  //           uploaded: patientkMap[index]['uploaded'].toString());
  //     });
  //   } else {
  //     List<Map<String, dynamic>> patientkMap =
  //         await _db.rawQuery('SELECT * FROM patient ORDER BY id DESC');
  //     return List.generate(patientkMap.length, (index) {
  //       return Patient(
  //           rbtc_id: patientkMap[index]['rbtc_id'].toString(),
  //           tfs_id: patientkMap[index]['tfs_id'].toString(),
  //           tfs_name: patientkMap[index]['tfs_name'].toString(),
  //           ward: patientkMap[index]['ward'].toString(),
  //           type: patientkMap[index]['type'].toString(),
  //           surname: patientkMap[index]['surname'].toString(),
  //           name: patientkMap[index]['name'].toString(),
  //           gender: patientkMap[index]['gender'].toString(),
  //           phonenumber: patientkMap[index]['phonenumber'].toString(),
  //           weight: patientkMap[index]['weight'].toString(),
  //           patientid: patientkMap[index]['patientid'].toString(),
  //           psr: patientkMap[index]['psr'].toString(),
  //           abo: patientkMap[index]['abo'].toString(),
  //           rh: patientkMap[index]['rh'].toString(),
  //           aborh: patientkMap[index]['aborh'].toString(),
  //           phenotype: patientkMap[index]['phenotype'].toString(),
  //           kell: patientkMap[index]['kell'].toString(),
  //           age: patientkMap[index]['age'].toString(),
  //           agecategory: patientkMap[index]['agecategory'].toString(),
  //           patienttype: patientkMap[index]['patienttype'].toString(),
  //           diagnosis: patientkMap[index]['diagnosis'].toString(),
  //           hb: patientkMap[index]['hb'].toString(),
  //           previoustransfusion:
  //               patientkMap[index]['previoustransfusion'].toString(),
  //           previoustransfusiondate:
  //               patientkMap[index]['previoustransfusiondate'].toString(),
  //           previoustransfusionreaction:
  //               patientkMap[index]['previoustransfusionreaction'].toString(),
  //           previoustransfusionreactiondesc: patientkMap[index]
  //                   ['previoustransfusionreactiondesc']
  //               .toString(),
  //           previouspregnancies:
  //               patientkMap[index]['previouspregnancies'].toString(),
  //           para: patientkMap[index]['para'].toString(),
  //           gravida: patientkMap[index]['gravida'].toString(),
  //           ppother: patientkMap[index]['ppother'].toString(),
  //           department: patientkMap[index]['department'].toString(),
  //           teamname: patientkMap[index]['teamname'].toString(),
  //           team: patientkMap[index]['team'].toString(),
  //           healthstaff: patientkMap[index]['healthstaff'].toString(),
  //           reaction: patientkMap[index]['reaction'].toString(),
  //           date: patientkMap[index]['date'].toString(),
  //           time: patientkMap[index]['time'].toString(),
  //           month: patientkMap[index]['month'].toString(),
  //           year: patientkMap[index]['year'].toString(),
  //           status: patientkMap[index]['status'].toString(),
  //           uploaded: patientkMap[index]['uploaded'].toString());
  //     });
  //   }
  // }

  // Future<List<Patient>> getPatientData(String patientid) async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> patientkMap = await _db
  //       .rawQuery("SELECT * FROM patient WHERE patientid = '$patientid'");
  //   return List.generate(patientkMap.length, (index) {
  //     return Patient(
  //         rbtc_id: patientkMap[index]['rbtc_id'].toString(),
  //         tfs_id: patientkMap[index]['tfs_id'].toString(),
  //         tfs_name: patientkMap[index]['tfs_name'].toString(),
  //         ward: patientkMap[index]['ward'].toString(),
  //         type: patientkMap[index]['type'].toString(),
  //         surname: patientkMap[index]['surname'].toString(),
  //         name: patientkMap[index]['name'].toString(),
  //         gender: patientkMap[index]['gender'].toString(),
  //         phonenumber: patientkMap[index]['phonenumber'].toString(),
  //         weight: patientkMap[index]['weight'].toString(),
  //         patientid: patientkMap[index]['patientid'].toString(),
  //         psr: patientkMap[index]['psr'].toString(),
  //         abo: patientkMap[index]['abo'].toString(),
  //         rh: patientkMap[index]['rh'].toString(),
  //         aborh: patientkMap[index]['aborh'].toString(),
  //         phenotype: patientkMap[index]['phenotype'].toString(),
  //         kell: patientkMap[index]['kell'].toString(),
  //         age: patientkMap[index]['age'].toString(),
  //         agecategory: patientkMap[index]['agecategory'].toString(),
  //         patienttype: patientkMap[index]['patienttype'].toString(),
  //         diagnosis: patientkMap[index]['diagnosis'].toString(),
  //         hb: patientkMap[index]['hb'].toString(),
  //         previoustransfusion:
  //             patientkMap[index]['previoustransfusion'].toString(),
  //         previoustransfusiondate:
  //             patientkMap[index]['previoustransfusiondate'].toString(),
  //         previoustransfusionreaction:
  //             patientkMap[index]['previoustransfusionreaction'].toString(),
  //         previoustransfusionreactiondesc:
  //             patientkMap[index]['previoustransfusionreactiondesc'].toString(),
  //         previouspregnancies:
  //             patientkMap[index]['previouspregnancies'].toString(),
  //         para: patientkMap[index]['para'].toString(),
  //         gravida: patientkMap[index]['gravida'].toString(),
  //         ppother: patientkMap[index]['ppother'].toString(),
  //         department: patientkMap[index]['department'].toString(),
  //         teamname: patientkMap[index]['teamname'].toString(),
  //         team: patientkMap[index]['team'].toString(),
  //         healthstaff: patientkMap[index]['healthstaff'].toString(),
  //         reaction: patientkMap[index]['reaction'].toString(),
  //         date: patientkMap[index]['date'].toString(),
  //         time: patientkMap[index]['time'].toString(),
  //         month: patientkMap[index]['month'].toString(),
  //         year: patientkMap[index]['year'].toString(),
  //         status: patientkMap[index]['status'].toString(),
  //         uploaded: patientkMap[index]['uploaded'].toString());
  //   });
  // }

  // Future<List<Patient>> getReactionPatient() async {
  //   Database _db = await database();

  //   List<Map<String, dynamic>> patientkMap =
  //       await _db.rawQuery("SELECT * FROM patient WHERE reaction = 'Yes'");
  //   return List.generate(patientkMap.length, (index) {
  //     return Patient(
  //         rbtc_id: patientkMap[index]['rbtc_id'].toString(),
  //         tfs_id: patientkMap[index]['tfs_id'].toString(),
  //         tfs_name: patientkMap[index]['tfs_name'].toString(),
  //         ward: patientkMap[index]['ward'].toString(),
  //         type: patientkMap[index]['type'].toString(),
  //         surname: patientkMap[index]['surname'].toString(),
  //         name: patientkMap[index]['name'].toString(),
  //         gender: patientkMap[index]['gender'].toString(),
  //         phonenumber: patientkMap[index]['phonenumber'].toString(),
  //         weight: patientkMap[index]['weight'].toString(),
  //         patientid: patientkMap[index]['patientid'].toString(),
  //         psr: patientkMap[index]['psr'].toString(),
  //         abo: patientkMap[index]['abo'].toString(),
  //         rh: patientkMap[index]['rh'].toString(),
  //         aborh: patientkMap[index]['aborh'].toString(),
  //         phenotype: patientkMap[index]['phenotype'].toString(),
  //         kell: patientkMap[index]['kell'].toString(),
  //         age: patientkMap[index]['age'].toString(),
  //         agecategory: patientkMap[index]['agecategory'].toString(),
  //         patienttype: patientkMap[index]['patienttype'].toString(),
  //         diagnosis: patientkMap[index]['diagnosis'].toString(),
  //         hb: patientkMap[index]['hb'].toString(),
  //         previoustransfusion:
  //             patientkMap[index]['previoustransfusion'].toString(),
  //         previoustransfusiondate:
  //             patientkMap[index]['previoustransfusiondate'].toString(),
  //         previoustransfusionreaction:
  //             patientkMap[index]['previoustransfusionreaction'].toString(),
  //         previoustransfusionreactiondesc:
  //             patientkMap[index]['previoustransfusionreactiondesc'].toString(),
  //         previouspregnancies:
  //             patientkMap[index]['previouspregnancies'].toString(),
  //         para: patientkMap[index]['para'].toString(),
  //         gravida: patientkMap[index]['gravida'].toString(),
  //         ppother: patientkMap[index]['ppother'].toString(),
  //         department: patientkMap[index]['department'].toString(),
  //         teamname: patientkMap[index]['teamname'].toString(),
  //         team: patientkMap[index]['team'].toString(),
  //         healthstaff: patientkMap[index]['healthstaff'].toString(),
  //         reaction: patientkMap[index]['reaction'].toString(),
  //         date: patientkMap[index]['date'].toString(),
  //         time: patientkMap[index]['time'].toString(),
  //         month: patientkMap[index]['month'].toString(),
  //         year: patientkMap[index]['year'].toString(),
  //         status: patientkMap[index]['status'].toString(),
  //         uploaded: patientkMap[index]['uploaded'].toString());
  //   });
  // }

  // Future<List<Request>> getRequestdocs(String value) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> requestkMap = await _db
  //       .rawQuery("SELECT * FROM btfrequestform WHERE requestid = '$value'");
  //   return List.generate(requestkMap.length, (index) {
  //     return Request(
  //         requestid: requestkMap[index]['requestid'].toString(),
  //         rbtc_id: requestkMap[index]['rbtc_id'].toString(),
  //         tfs_id: requestkMap[index]['tfs_id'].toString(),
  //         tfs_name: requestkMap[index]['tfs_name'].toString(),
  //         ward: requestkMap[index]['ward'].toString(),
  //         requesttype: requestkMap[index]['requesttype'].toString(),
  //         type: requestkMap[index]['type'].toString(),
  //         surname: requestkMap[index]['surname'].toString(),
  //         name: requestkMap[index]['name'].toString(),
  //         gender: requestkMap[index]['gender'].toString(),
  //         phonenumber: requestkMap[index]['phonenumber'].toString(),
  //         weight: requestkMap[index]['weight'].toString(),
  //         patientid: requestkMap[index]['patientid'].toString(),
  //         age: requestkMap[index]['age'].toString(),
  //         patienttype: requestkMap[index]['patienttype'].toString(),
  //         diagnosis: requestkMap[index]['diagnosis'].toString(),
  //         hb: requestkMap[index]['hb'].toString(),
  //         investigationRequested: requestkMap[index]['investigationRequested'],
  //         wholeblood: requestkMap[index]['wholeblood'].toString(),
  //         wholebloodml: requestkMap[index]['wholebloodml'],
  //         prcc: requestkMap[index]['prcc'].toString(),
  //         prccml: requestkMap[index]['prccml'].toString(),
  //         ffp: requestkMap[index]['ffp'].toString(),
  //         ffpml: requestkMap[index]['ffpml'].toString(),
  //         platelets: requestkMap[index]['platelets'].toString(),
  //         plateletsml: requestkMap[index]['plateletsml'].toString(),
  //         wholebloodmlissued:
  //             requestkMap[index]['wholebloodmlissued'].toString(),
  //         prccmlissued: requestkMap[index]['prccmlissued'].toString(),
  //         ffpmlissued: requestkMap[index]['ffpmlissued'].toString(),
  //         plateletsmlissued: requestkMap[index]['plateletsmlissued'].toString(),
  //         department: requestkMap[index]['department'].toString(),
  //         teamname: requestkMap[index]['teamname'].toString(),
  //         team: requestkMap[index]['team'].toString(),
  //         nameofOrderingDoctor:
  //             requestkMap[index]['nameofOrderingDoctor'].toString(),
  //         doctorNumber: requestkMap[index]['doctorNumber'].toString(),
  //         healthstaff: requestkMap[index]['healthstaff'].toString(),
  //         tableadphonenumber:
  //             requestkMap[index]['tableadphonenumber'].toString(),
  //         tabphonenumber: requestkMap[index]['tabphonenumber'].toString(),
  //         date: requestkMap[index]['date'].toString(),
  //         time: requestkMap[index]['time'].toString(),
  //         month: requestkMap[index]['month'].toString(),
  //         year: requestkMap[index]['year'].toString(),
  //         transfusionstatus: requestkMap[index]['transfusionstatus'].toString(),
  //         requeststatus: requestkMap[index]['requeststatus'].toString(),
  //         uploaded: requestkMap[index]['uploaded'].toString());
  //   });
  // }

  // Future<List<Request>> getRequest(String value, bool search) async {
  //   Database _db = await database();
  //   if (search == true) {
  //     List<Map<String, dynamic>> requestkMap = await _db.rawQuery(
  //         "SELECT * FROM btfrequestform WHERE requestid LIKE '%$value%' OR name LIKE '%$value%' OR  surname LIKE '%$value%' OR patientid LIKE '%$value%' OR  gender LIKE '%$value%' OR phonenumber LIKE '%$value%' OR diagnosis LIKE '%$value%' OR requeststatus LIKE '%$value%' ORDER by id DESC");
  //     return List.generate(requestkMap.length, (index) {
  //       return Request(
  //           requestid: requestkMap[index]['requestid'].toString(),
  //           rbtc_id: requestkMap[index]['rbtc_id'].toString(),
  //           tfs_id: requestkMap[index]['tfs_id'].toString(),
  //           tfs_name: requestkMap[index]['tfs_name'].toString(),
  //           ward: requestkMap[index]['ward'].toString(),
  //           requesttype: requestkMap[index]['requesttype'].toString(),
  //           type: requestkMap[index]['type'].toString(),
  //           surname: requestkMap[index]['surname'].toString(),
  //           name: requestkMap[index]['name'].toString(),
  //           gender: requestkMap[index]['gender'].toString(),
  //           phonenumber: requestkMap[index]['phonenumber'].toString(),
  //           weight: requestkMap[index]['weight'].toString(),
  //           patientid: requestkMap[index]['patientid'].toString(),
  //           age: requestkMap[index]['age'].toString(),
  //           patienttype: requestkMap[index]['patienttype'].toString(),
  //           diagnosis: requestkMap[index]['diagnosis'].toString(),
  //           hb: requestkMap[index]['hb'].toString(),
  //           investigationRequested: requestkMap[index]
  //               ['investigationRequested'],
  //           wholeblood: requestkMap[index]['wholeblood'].toString(),
  //           wholebloodml: requestkMap[index]['wholebloodml'],
  //           prcc: requestkMap[index]['prcc'].toString(),
  //           prccml: requestkMap[index]['prccml'].toString(),
  //           ffp: requestkMap[index]['ffp'].toString(),
  //           ffpml: requestkMap[index]['ffpml'].toString(),
  //           platelets: requestkMap[index]['platelets'].toString(),
  //           plateletsml: requestkMap[index]['plateletsml'].toString(),
  //           wholebloodmlissued:
  //               requestkMap[index]['wholebloodmlissued'].toString(),
  //           prccmlissued: requestkMap[index]['prccmlissued'].toString(),
  //           ffpmlissued: requestkMap[index]['ffpmlissued'].toString(),
  //           plateletsmlissued:
  //               requestkMap[index]['plateletsmlissued'].toString(),
  //           department: requestkMap[index]['department'].toString(),
  //           teamname: requestkMap[index]['teamname'].toString(),
  //           team: requestkMap[index]['team'].toString(),
  //           nameofOrderingDoctor:
  //               requestkMap[index]['nameofOrderingDoctor'].toString(),
  //           doctorNumber: requestkMap[index]['doctorNumber'].toString(),
  //           healthstaff: requestkMap[index]['healthstaff'].toString(),
  //           tableadphonenumber:
  //               requestkMap[index]['tableadphonenumber'].toString(),
  //           tabphonenumber: requestkMap[index]['tabphonenumber'].toString(),
  //           date: requestkMap[index]['date'].toString(),
  //           time: requestkMap[index]['time'].toString(),
  //           month: requestkMap[index]['month'].toString(),
  //           year: requestkMap[index]['year'].toString(),
  //           transfusionstatus:
  //               requestkMap[index]['transfusionstatus'].toString(),
  //           requeststatus: requestkMap[index]['requeststatus'].toString(),
  //           uploaded: requestkMap[index]['uploaded'].toString());
  //     });
  //   } else {
  //     List<Map<String, dynamic>> requestkMap =
  //         await _db.rawQuery('SELECT * FROM btfrequestform ORDER BY id DESC');
  //     return List.generate(requestkMap.length, (index) {
  //       return Request(
  //           requestid: requestkMap[index]['requestid'].toString(),
  //           rbtc_id: requestkMap[index]['rbtc_id'].toString(),
  //           tfs_id: requestkMap[index]['tfs_id'].toString(),
  //           tfs_name: requestkMap[index]['tfs_name'].toString(),
  //           ward: requestkMap[index]['ward'].toString(),
  //           requesttype: requestkMap[index]['requesttype'].toString(),
  //           type: requestkMap[index]['type'].toString(),
  //           surname: requestkMap[index]['surname'].toString(),
  //           name: requestkMap[index]['name'].toString(),
  //           gender: requestkMap[index]['gender'].toString(),
  //           phonenumber: requestkMap[index]['phonenumber'].toString(),
  //           weight: requestkMap[index]['weight'].toString(),
  //           patientid: requestkMap[index]['patientid'].toString(),
  //           age: requestkMap[index]['age'].toString(),
  //           patienttype: requestkMap[index]['patienttype'].toString(),
  //           diagnosis: requestkMap[index]['diagnosis'].toString(),
  //           hb: requestkMap[index]['hb'].toString(),
  //           investigationRequested: requestkMap[index]
  //               ['investigationRequested'],
  //           wholeblood: requestkMap[index]['wholeblood'].toString(),
  //           wholebloodml: requestkMap[index]['wholebloodml'],
  //           prcc: requestkMap[index]['prcc'].toString(),
  //           prccml: requestkMap[index]['prccml'].toString(),
  //           ffp: requestkMap[index]['ffp'].toString(),
  //           ffpml: requestkMap[index]['ffpml'].toString(),
  //           platelets: requestkMap[index]['platelets'].toString(),
  //           plateletsml: requestkMap[index]['plateletsml'].toString(),
  //           wholebloodmlissued:
  //               requestkMap[index]['wholebloodmlissued'].toString(),
  //           prccmlissued: requestkMap[index]['prccmlissued'].toString(),
  //           ffpmlissued: requestkMap[index]['ffpmlissued'].toString(),
  //           plateletsmlissued:
  //               requestkMap[index]['plateletsmlissued'].toString(),
  //           department: requestkMap[index]['department'].toString(),
  //           teamname: requestkMap[index]['teamname'].toString(),
  //           team: requestkMap[index]['team'].toString(),
  //           nameofOrderingDoctor:
  //               requestkMap[index]['nameofOrderingDoctor'].toString(),
  //           doctorNumber: requestkMap[index]['doctorNumber'].toString(),
  //           healthstaff: requestkMap[index]['healthstaff'].toString(),
  //           tableadphonenumber:
  //               requestkMap[index]['tableadphonenumber'].toString(),
  //           tabphonenumber: requestkMap[index]['tabphonenumber'].toString(),
  //           date: requestkMap[index]['date'].toString(),
  //           time: requestkMap[index]['time'].toString(),
  //           month: requestkMap[index]['month'].toString(),
  //           year: requestkMap[index]['year'].toString(),
  //           transfusionstatus:
  //               requestkMap[index]['transfusionstatus'].toString(),
  //           requeststatus: requestkMap[index]['requeststatus'].toString(),
  //           uploaded: requestkMap[index]['uploaded'].toString());
  //     });
  //   }
  // }

  // Future<List<Request>> getBldAdminRequest(String value, bool search) async {
  //   Database _db = await database();
  //   if (search == true) {
  //     List<Map<String, dynamic>> requestkMap = await _db.rawQuery(
  //         "SELECT * FROM btfrequestform WHERE (requestid LIKE '%$value%' OR name LIKE '%$value%' OR  surname LIKE '%$value%' OR patientid LIKE '%$value%' OR  gender LIKE '%$value%' OR phonenumber LIKE '%$value%' OR diagnosis LIKE '%$value%') AND transfusionstatus = 'Partially Infusion' ORDER by id DESC");
  //     return List.generate(requestkMap.length, (index) {
  //       return Request(
  //           requestid: requestkMap[index]['requestid'].toString(),
  //           rbtc_id: requestkMap[index]['rbtc_id'].toString(),
  //           tfs_id: requestkMap[index]['tfs_id'].toString(),
  //           tfs_name: requestkMap[index]['tfs_name'].toString(),
  //           ward: requestkMap[index]['ward'].toString(),
  //           requesttype: requestkMap[index]['requesttype'].toString(),
  //           type: requestkMap[index]['type'].toString(),
  //           surname: requestkMap[index]['surname'].toString(),
  //           name: requestkMap[index]['name'].toString(),
  //           gender: requestkMap[index]['gender'].toString(),
  //           phonenumber: requestkMap[index]['phonenumber'].toString(),
  //           weight: requestkMap[index]['weight'].toString(),
  //           patientid: requestkMap[index]['patientid'].toString(),
  //           age: requestkMap[index]['age'].toString(),
  //           patienttype: requestkMap[index]['patienttype'].toString(),
  //           diagnosis: requestkMap[index]['diagnosis'].toString(),
  //           hb: requestkMap[index]['hb'].toString(),
  //           investigationRequested: requestkMap[index]
  //               ['investigationRequested'],
  //           wholeblood: requestkMap[index]['wholeblood'].toString(),
  //           wholebloodml: requestkMap[index]['wholebloodml'],
  //           prcc: requestkMap[index]['prcc'].toString(),
  //           prccml: requestkMap[index]['prccml'].toString(),
  //           ffp: requestkMap[index]['ffp'].toString(),
  //           ffpml: requestkMap[index]['ffpml'].toString(),
  //           platelets: requestkMap[index]['platelets'].toString(),
  //           plateletsml: requestkMap[index]['plateletsml'].toString(),
  //           wholebloodmlissued:
  //               requestkMap[index]['wholebloodmlissued'].toString(),
  //           prccmlissued: requestkMap[index]['prccmlissued'].toString(),
  //           ffpmlissued: requestkMap[index]['ffpmlissued'].toString(),
  //           plateletsmlissued:
  //               requestkMap[index]['plateletsmlissued'].toString(),
  //           department: requestkMap[index]['department'].toString(),
  //           teamname: requestkMap[index]['teamname'].toString(),
  //           team: requestkMap[index]['team'].toString(),
  //           nameofOrderingDoctor:
  //               requestkMap[index]['nameofOrderingDoctor'].toString(),
  //           doctorNumber: requestkMap[index]['doctorNumber'].toString(),
  //           healthstaff: requestkMap[index]['healthstaff'].toString(),
  //           tableadphonenumber:
  //               requestkMap[index]['tableadphonenumber'].toString(),
  //           tabphonenumber: requestkMap[index]['tabphonenumber'].toString(),
  //           date: requestkMap[index]['date'].toString(),
  //           time: requestkMap[index]['time'].toString(),
  //           month: requestkMap[index]['month'].toString(),
  //           year: requestkMap[index]['year'].toString(),
  //           transfusionstatus:
  //               requestkMap[index]['transfusionstatus'].toString(),
  //           requeststatus: requestkMap[index]['requeststatus'].toString(),
  //           uploaded: requestkMap[index]['uploaded'].toString());
  //     });
  //   } else {
  //     List<Map<String, dynamic>> requestkMap = await _db.rawQuery(
  //         "SELECT * FROM btfrequestform WHERE transfusionstatus = 'Partially Infusion' ORDER BY id DESC");
  //     return List.generate(requestkMap.length, (index) {
  //       return Request(
  //           requestid: requestkMap[index]['requestid'].toString(),
  //           rbtc_id: requestkMap[index]['rbtc_id'].toString(),
  //           tfs_id: requestkMap[index]['tfs_id'].toString(),
  //           tfs_name: requestkMap[index]['tfs_name'].toString(),
  //           ward: requestkMap[index]['ward'].toString(),
  //           requesttype: requestkMap[index]['requesttype'].toString(),
  //           type: requestkMap[index]['type'].toString(),
  //           surname: requestkMap[index]['surname'].toString(),
  //           name: requestkMap[index]['name'].toString(),
  //           gender: requestkMap[index]['gender'].toString(),
  //           phonenumber: requestkMap[index]['phonenumber'].toString(),
  //           weight: requestkMap[index]['weight'].toString(),
  //           patientid: requestkMap[index]['patientid'].toString(),
  //           age: requestkMap[index]['age'].toString(),
  //           patienttype: requestkMap[index]['patienttype'].toString(),
  //           diagnosis: requestkMap[index]['diagnosis'].toString(),
  //           hb: requestkMap[index]['hb'].toString(),
  //           investigationRequested: requestkMap[index]
  //               ['investigationRequested'],
  //           wholeblood: requestkMap[index]['wholeblood'].toString(),
  //           wholebloodml: requestkMap[index]['wholebloodml'],
  //           prcc: requestkMap[index]['prcc'].toString(),
  //           prccml: requestkMap[index]['prccml'].toString(),
  //           ffp: requestkMap[index]['ffp'].toString(),
  //           ffpml: requestkMap[index]['ffpml'].toString(),
  //           platelets: requestkMap[index]['platelets'].toString(),
  //           plateletsml: requestkMap[index]['plateletsml'].toString(),
  //           wholebloodmlissued:
  //               requestkMap[index]['wholebloodmlissued'].toString(),
  //           prccmlissued: requestkMap[index]['prccmlissued'].toString(),
  //           ffpmlissued: requestkMap[index]['ffpmlissued'].toString(),
  //           plateletsmlissued:
  //               requestkMap[index]['plateletsmlissued'].toString(),
  //           department: requestkMap[index]['department'].toString(),
  //           teamname: requestkMap[index]['teamname'].toString(),
  //           team: requestkMap[index]['team'].toString(),
  //           nameofOrderingDoctor:
  //               requestkMap[index]['nameofOrderingDoctor'].toString(),
  //           doctorNumber: requestkMap[index]['doctorNumber'].toString(),
  //           healthstaff: requestkMap[index]['healthstaff'].toString(),
  //           tableadphonenumber:
  //               requestkMap[index]['tableadphonenumber'].toString(),
  //           tabphonenumber: requestkMap[index]['tabphonenumber'].toString(),
  //           date: requestkMap[index]['date'].toString(),
  //           time: requestkMap[index]['time'].toString(),
  //           month: requestkMap[index]['month'].toString(),
  //           year: requestkMap[index]['year'].toString(),
  //           transfusionstatus:
  //               requestkMap[index]['transfusionstatus'].toString(),
  //           requeststatus: requestkMap[index]['requeststatus'].toString(),
  //           uploaded: requestkMap[index]['uploaded'].toString());
  //     });
  //   }
  // }

  // Future<List<Observation>> getObservation(
  //     String value, String bagvalue) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db.rawQuery(
  //       "SELECT * FROM observation WHERE requestid = '$value' AND bagid = '$bagvalue' ");
  //   return List.generate(taskMap.length, (index) {
  //     return Observation(
  //       rbtc_id: taskMap[index]['rbtc_id'].toString(),
  //       tfs_id: taskMap[index]['tfs_id'].toString(),
  //       tfs_name: taskMap[index]['tfs_name'].toString(),
  //       observationid: taskMap[index]['observationid'].toString(),
  //       requestid: taskMap[index]['requestid'].toString(),
  //       gender: taskMap[index]['gender'].toString(),
  //       patientid: taskMap[index]['patientid'].toString(),
  //       bagid: taskMap[index]['bagid'].toString(),
  //       ward: taskMap[index]['ward'].toString(),
  //       sbp: taskMap[index]['sbp'].toString(),
  //       dbp: taskMap[index]['dbp'].toString(),
  //       pulse: taskMap[index]['pulse'].toString(),
  //       temp: taskMap[index]['temp'].toString(),
  //       resp: taskMap[index]['resp'].toString(),
  //       reaction: taskMap[index]['reaction'].toString(),
  //       general: taskMap[index]['general'].toString(),
  //       generalrxn: taskMap[index]['generalrxn'].toString(),
  //       derma: taskMap[index]['derma'].toString(),
  //       dermarxn: taskMap[index]['dermarxn'].toString(),
  //       cresp: taskMap[index]['cresp'].toString(),
  //       cresprxn: taskMap[index]['cresprxn'].toString(),
  //       renal: taskMap[index]['renal'].toString(),
  //       renalrxn: taskMap[index]['renalrxn'].toString(),
  //       hema: taskMap[index]['hema'].toString(),
  //       hemarxn: taskMap[index]['hemarxn'].toString(),
  //       others: taskMap[index]['others'].toString(),
  //       otherrxn: taskMap[index]['otherrxn'].toString(),
  //       interval: taskMap[index]['interval'].toString(),
  //       transfusionstopped: taskMap[index]['transfusionstopped'].toString(),
  //       starttime: taskMap[index]['starttime'].toString(),
  //       transfusionstoptime: taskMap[index]['transfusionstoptime'].toString(),
  //       healthstaff: taskMap[index]['healthstaff'].toString(),
  //       date: taskMap[index]['date'].toString(),
  //       time: taskMap[index]['time'].toString(),
  //       month: taskMap[index]['month'].toString(),
  //       year: taskMap[index]['year'].toString(),
  //       status: taskMap[index]['status'].toString(),
  //       uploaded: taskMap[index]['uploaded'].toString(),
  //     );
  //   });
  // }

  // Future<List<Observation>> getObservationReaction(String patientid) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db
  //       .rawQuery("SELECT * FROM observation WHERE patientid = '$patientid'");
  //   return List.generate(taskMap.length, (index) {
  //     return Observation(
  //       rbtc_id: taskMap[index]['rbtc_id'].toString(),
  //       tfs_id: taskMap[index]['tfs_id'].toString(),
  //       tfs_name: taskMap[index]['tfs_name'].toString(),
  //       observationid: taskMap[index]['observationid'].toString(),
  //       requestid: taskMap[index]['requestid'].toString(),
  //       gender: taskMap[index]['gender'].toString(),
  //       patientid: taskMap[index]['patientid'].toString(),
  //       bagid: taskMap[index]['bagid'].toString(),
  //       ward: taskMap[index]['ward'].toString(),
  //       sbp: taskMap[index]['sbp'].toString(),
  //       dbp: taskMap[index]['dbp'].toString(),
  //       pulse: taskMap[index]['pulse'].toString(),
  //       temp: taskMap[index]['temp'].toString(),
  //       resp: taskMap[index]['resp'].toString(),
  //       reaction: taskMap[index]['reaction'].toString(),
  //       general: taskMap[index]['general'].toString(),
  //       generalrxn: taskMap[index]['generalrxn'].toString(),
  //       derma: taskMap[index]['derma'].toString(),
  //       dermarxn: taskMap[index]['dermarxn'].toString(),
  //       cresp: taskMap[index]['cresp'].toString(),
  //       cresprxn: taskMap[index]['cresprxn'].toString(),
  //       renal: taskMap[index]['renal'].toString(),
  //       renalrxn: taskMap[index]['renalrxn'].toString(),
  //       hema: taskMap[index]['hema'].toString(),
  //       hemarxn: taskMap[index]['hemarxn'].toString(),
  //       others: taskMap[index]['others'].toString(),
  //       otherrxn: taskMap[index]['otherrxn'].toString(),
  //       interval: taskMap[index]['interval'].toString(),
  //       transfusionstopped: taskMap[index]['transfusionstopped'].toString(),
  //       starttime: taskMap[index]['starttime'].toString(),
  //       transfusionstoptime: taskMap[index]['transfusionstoptime'].toString(),
  //       healthstaff: taskMap[index]['healthstaff'].toString(),
  //       date: taskMap[index]['date'].toString(),
  //       time: taskMap[index]['time'].toString(),
  //       month: taskMap[index]['month'].toString(),
  //       year: taskMap[index]['year'].toString(),
  //       status: taskMap[index]['status'].toString(),
  //       uploaded: taskMap[index]['uploaded'].toString(),
  //     );
  //   });
  // }

  // Future<List<PostTransfusionReaction>> getPta(String patientid) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db.rawQuery(
  //       "SELECT * FROM posttransfusionreaction WHERE patientid = '$patientid' ");
  //   return List.generate(taskMap.length, (index) {
  //     return PostTransfusionReaction(
  //       rbtc_id: taskMap[index]['rbtc_id'].toString(),
  //       tfs_id: taskMap[index]['tfs_id'].toString(),
  //       tfs_name: taskMap[index]['tfs_name'].toString(),
  //       patientid: taskMap[index]['patientid'].toString(),
  //       gender: taskMap[index]['gender'].toString(),
  //       ward: taskMap[index]['ward'].toString(),
  //       general: taskMap[index]['general'].toString(),
  //       generalrxn: taskMap[index]['generalrxn'].toString(),
  //       derma: taskMap[index]['derma'].toString(),
  //       dermarxn: taskMap[index]['dermarxn'].toString(),
  //       cresp: taskMap[index]['cresp'].toString(),
  //       cresprxn: taskMap[index]['cresprxn'].toString(),
  //       renal: taskMap[index]['renal'].toString(),
  //       renalrxn: taskMap[index]['renalrxn'].toString(),
  //       hema: taskMap[index]['hema'].toString(),
  //       hemarxn: taskMap[index]['hemarxn'].toString(),
  //       others: taskMap[index]['others'].toString(),
  //       otherrxn: taskMap[index]['otherrxn'].toString(),
  //       healthstaff: taskMap[index]['healthstaff'].toString(),
  //       date: taskMap[index]['date'].toString(),
  //       time: taskMap[index]['time'].toString(),
  //       month: taskMap[index]['month'].toString(),
  //       year: taskMap[index]['year'].toString(),
  //       uploaded: taskMap[index]['uploaded'].toString(),
  //     );
  //   });
  // }

  // Future<List<PreTransfusionObservation>> getPreTransfusionObservation(
  //     String value, String bagvalue) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db.rawQuery(
  //       "SELECT * FROM pretransfusionobservation WHERE requestid = '$value' AND bagid = '$bagvalue'");
  //   return List.generate(taskMap.length, (index) {
  //     return PreTransfusionObservation(
  //       rbtc_id: taskMap[index]['rbtc_id'].toString(),
  //       tfs_id: taskMap[index]['tfs_id'].toString(),
  //       tfs_name: taskMap[index]['tfs_name'].toString(),
  //       requestid: taskMap[index]['requestid'].toString(),
  //       bagid: taskMap[index]['bagid'].toString(),
  //       gender: taskMap[index]['gender'].toString(),
  //       patientid: taskMap[index]['patientid'].toString(),
  //       ward: taskMap[index]['ward'].toString(),
  //       sbp: taskMap[index]['sbp'].toString(),
  //       dbp: taskMap[index]['dbp'].toString(),
  //       pulse: taskMap[index]['pulse'].toString(),
  //       temp: taskMap[index]['temp'].toString(),
  //       resp: taskMap[index]['resp'].toString(),
  //       reaction: taskMap[index]['reaction'].toString(),
  //       general: taskMap[index]['general'].toString(),
  //       generalrxn: taskMap[index]['generalrxn'].toString(),
  //       derma: taskMap[index]['derma'].toString(),
  //       dermarxn: taskMap[index]['dermarxn'].toString(),
  //       cresp: taskMap[index]['cresp'].toString(),
  //       cresprxn: taskMap[index]['cresprxn'].toString(),
  //       renal: taskMap[index]['renal'].toString(),
  //       renalrxn: taskMap[index]['renalrxn'].toString(),
  //       hema: taskMap[index]['hema'].toString(),
  //       hemarxn: taskMap[index]['hemarxn'].toString(),
  //       others: taskMap[index]['others'].toString(),
  //       otherrxn: taskMap[index]['otherrxn'].toString(),
  //       healthstaff: taskMap[index]['healthstaff'].toString(),
  //       date: taskMap[index]['date'].toString(),
  //       time: taskMap[index]['time'].toString(),
  //       month: taskMap[index]['month'].toString(),
  //       year: taskMap[index]['year'].toString(),
  //       status: taskMap[index]['status'].toString(),
  //       uploaded: taskMap[index]['uploaded'].toString(),
  //     );
  //   });
  // }

  // Future<List<PreTransfusionObservation>> getPreTransfusionObservationreaction(
  //     String patientid) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db.rawQuery(
  //       "SELECT * FROM pretransfusionobservation WHERE patientid = '$patientid'");
  //   return List.generate(taskMap.length, (index) {
  //     return PreTransfusionObservation(
  //       rbtc_id: taskMap[index]['rbtc_id'].toString(),
  //       tfs_id: taskMap[index]['tfs_id'].toString(),
  //       tfs_name: taskMap[index]['tfs_name'].toString(),
  //       requestid: taskMap[index]['requestid'].toString(),
  //       bagid: taskMap[index]['bagid'].toString(),
  //       gender: taskMap[index]['gender'].toString(),
  //       patientid: taskMap[index]['patientid'].toString(),
  //       ward: taskMap[index]['ward'].toString(),
  //       sbp: taskMap[index]['sbp'].toString(),
  //       dbp: taskMap[index]['dbp'].toString(),
  //       pulse: taskMap[index]['pulse'].toString(),
  //       temp: taskMap[index]['temp'].toString(),
  //       resp: taskMap[index]['resp'].toString(),
  //       reaction: taskMap[index]['reaction'].toString(),
  //       general: taskMap[index]['general'].toString(),
  //       generalrxn: taskMap[index]['generalrxn'].toString(),
  //       derma: taskMap[index]['derma'].toString(),
  //       dermarxn: taskMap[index]['dermarxn'].toString(),
  //       cresp: taskMap[index]['cresp'].toString(),
  //       cresprxn: taskMap[index]['cresprxn'].toString(),
  //       renal: taskMap[index]['renal'].toString(),
  //       renalrxn: taskMap[index]['renalrxn'].toString(),
  //       hema: taskMap[index]['hema'].toString(),
  //       hemarxn: taskMap[index]['hemarxn'].toString(),
  //       others: taskMap[index]['others'].toString(),
  //       otherrxn: taskMap[index]['otherrxn'].toString(),
  //       healthstaff: taskMap[index]['healthstaff'].toString(),
  //       date: taskMap[index]['date'].toString(),
  //       time: taskMap[index]['time'].toString(),
  //       month: taskMap[index]['month'].toString(),
  //       year: taskMap[index]['year'].toString(),
  //       status: taskMap[index]['status'].toString(),
  //       uploaded: taskMap[index]['uploaded'].toString(),
  //     );
  //   });
  // }

  Future<void> updatePatient(String patientid, String status, String abo,
      String rh, String aborh, String phenotype, String kell) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE patient SET uploaded = '$status', psr = 'Yes', abo = '$abo', rh = '$rh', aborh = '$aborh', phenotype = '$phenotype', kell = '$kell' WHERE patientid = '$patientid'");
  }
}
