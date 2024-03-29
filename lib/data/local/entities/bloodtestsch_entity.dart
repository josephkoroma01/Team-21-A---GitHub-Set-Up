import 'package:drift/drift.dart';

class BloodTestSchedule extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bloodTestFor => text()();
  TextColumn get firstName => text()();
  TextColumn get middleName => text()();
  TextColumn get lastName => text()();
  TextColumn get ageCategory => text()();
  TextColumn get gender => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get email => text()();
  TextColumn get schedulerPhoneNumber => text()();
  TextColumn get address => text()();
  TextColumn get facility => text()();
  IntColumn get date => integer()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  TextColumn get timeSlot => text()();
  TextColumn get refCode => text()();
  TextColumn get status => text()();
  TextColumn get result => text().nullable()();
  BoolColumn get onSite => boolean()();
  TextColumn get bloodGroup => text()();
  TextColumn get rh => text()();
  TextColumn get bloodGroupRh => text()();
  TextColumn get phenotype => text()();
  TextColumn get kell => text()();
  TextColumn get review => text().nullable()();
  RealColumn get rating => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
