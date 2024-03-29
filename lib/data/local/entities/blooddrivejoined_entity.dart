import 'package:drift/drift.dart';

class DonationCampaignDonor extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rbtcId => integer()();
  TextColumn get surname => text()();
  TextColumn get name => text()();
  TextColumn get ageCategory => text()();
  TextColumn get gender => text()();
  TextColumn get address => text()();
  TextColumn get donorPhoneNumber => text()();
  TextColumn get donorEmail => text()();
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
  IntColumn get campaignId => integer()();
  TextColumn get campaignName => text()();
  TextColumn get campaignCreator => text()();
  TextColumn get campaignDescription => text()();
  TextColumn get campaignContact => text()();
  TextColumn get campaignEmail => text()();
  TextColumn get facility => text()();
  TextColumn get campaignFacility => text()();
  TextColumn get campaignLocation => text()();
  TextColumn get campaignDistrict => text()();
  IntColumn get campaignDate => integer()();
  IntColumn get campaignDateCreated => integer()();
  TextColumn get campaignStatus => text()();
  TextColumn get atLab => text()();
  IntColumn get date => integer()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  TextColumn get refCode => text()();
  TextColumn get status => text()();
  TextColumn get review => text().nullable()();
  RealColumn get rating => real().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
