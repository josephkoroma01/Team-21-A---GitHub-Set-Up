import 'package:drift/drift.dart';

class BloodDonorRequest extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get facility => text()();
  TextColumn get ward => text()();
  TextColumn get gender => text()();
  TextColumn get patientType => text()();
  TextColumn get bloodComponent => text()();
  TextColumn get bloodGroup => text()();
  IntColumn get units => integer()();
  IntColumn get date => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
