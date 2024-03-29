import 'package:drift/drift.dart';

class BloodDonationSchedule extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get donorType => text()();
  TextColumn get surname => text()();
  TextColumn get name => text()();
  TextColumn get ageCategory => text()();
  TextColumn get gender => text()();
  TextColumn get address => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get email => text()();
  TextColumn get district => text()();
  TextColumn get maritalStatus => text()();
  TextColumn get occupation => text()();
  TextColumn get nextOfKin => text()();
  TextColumn get iNextOfKin => text()();
  TextColumn get nokContact => text()();
  TextColumn get pid => text()();
  TextColumn get pidNumber => text()();
  TextColumn get vhbv => text()();
  TextColumn get whenHbv => text()();
  TextColumn get bloodGroup => text()();
  TextColumn get facility => text()();
  IntColumn get date => integer()();
  IntColumn get newDate => integer()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  TextColumn get timeSlot => text()();
  TextColumn get refCode => text()();
  TextColumn get status => text()();
  TextColumn get review => text().nullable()();
  RealColumn get rating => real().nullable()();
  IntColumn get nextDonationDate => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
