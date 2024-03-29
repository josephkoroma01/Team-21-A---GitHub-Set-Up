import 'package:drift/drift.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text()();
  TextColumn get dob => text()();
  IntColumn get age => integer().nullable()();
  TextColumn get ageCategory => text()();
  TextColumn get gender => text()();
  TextColumn get avatar => text().nullable()();
  TextColumn get emailAddress => text()();
  TextColumn get homeAddress => text()();
  TextColumn get country => text()();
  TextColumn get bloodGroup => text()();
  BoolColumn get prevDonation => boolean()();
  RealColumn get prevDonationAmount => real().nullable()();
  TextColumn get phoneNumber => text()();
  TextColumn get password => text()();
  TextColumn get whatsAppCommunity => text().nullable()();
  TextColumn get trivia => text().nullable()();
  IntColumn get date => integer().nullable()();
  IntColumn get month => integer().nullable()();
  IntColumn get year => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
