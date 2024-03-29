import 'dart:io';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifebloodworld/data/local/entities/blooddonationsch_entity.dart';
import 'package:lifebloodworld/data/local/entities/blooddonorrequest_entity.dart';
import 'package:lifebloodworld/data/local/entities/blooddrivejoined_entity.dart';
import 'package:lifebloodworld/data/local/entities/bloodtestsch_entity.dart';
import 'package:lifebloodworld/data/local/entities/users_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';


part 'local_db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  BloodDonationSchedule,
  BloodDonorRequest,
  DonationCampaignDonor,
  BloodTestSchedule,
  User,
])
class LocalDB extends _$LocalDB {
  // we tell the database where to store the data with this constructor
  LocalDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertUser(UserCompanion user) {
    return into(user as TableInfo<Table, dynamic>).insert(user);
  }

  Future<UserData?> getUser(String email, String password) {
    return (select(user)..where((tbl) => tbl.emailAddress.equals(email) & tbl.password.equals(password))).getSingleOrNull();
  }

  // update user
  Future<void> updateUser(UserCompanion user) {
    return update(user as TableInfo<Table, dynamic>).replace(user);
  } 

  Future<void> insertBloodDonationSchedule(BloodDonationScheduleCompanion bloodDonationSchedule) {
    return into(bloodDonationSchedule as TableInfo<Table, dynamic>).insert(bloodDonationSchedule);
  }

  Future<void> insertBloodDonorRequest(BloodDonorRequestCompanion bloodDonorRequest) {
    return into(bloodDonorRequest as TableInfo<Table, dynamic>).insert(bloodDonorRequest);
  }

  Future<void> insertBloodTestSchedule(BloodTestScheduleCompanion bloodTestSchedule) {
    return into(bloodTestSchedule as TableInfo<Table, dynamic>).insert(bloodTestSchedule);
  }

  Future<void> insertBloodDriveJoined(DonationCampaignDonorCompanion donationCampaignDonor) {
    return into(donationCampaignDonor as TableInfo<Table, dynamic>).insert(donationCampaignDonor);
  }



   
}
