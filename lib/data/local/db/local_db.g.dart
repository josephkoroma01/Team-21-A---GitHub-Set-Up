// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// ignore_for_file: type=lint
class $BloodDonationScheduleTable extends BloodDonationSchedule
    with TableInfo<$BloodDonationScheduleTable, BloodDonationScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodDonationScheduleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _donorTypeMeta =
      const VerificationMeta('donorType');
  @override
  late final GeneratedColumn<String> donorType = GeneratedColumn<String>(
      'donor_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _surnameMeta =
      const VerificationMeta('surname');
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
      'surname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageCategoryMeta =
      const VerificationMeta('ageCategory');
  @override
  late final GeneratedColumn<String> ageCategory = GeneratedColumn<String>(
      'age_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _districtMeta =
      const VerificationMeta('district');
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
      'district', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _maritalStatusMeta =
      const VerificationMeta('maritalStatus');
  @override
  late final GeneratedColumn<String> maritalStatus = GeneratedColumn<String>(
      'marital_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _occupationMeta =
      const VerificationMeta('occupation');
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
      'occupation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextOfKinMeta =
      const VerificationMeta('nextOfKin');
  @override
  late final GeneratedColumn<String> nextOfKin = GeneratedColumn<String>(
      'next_of_kin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iNextOfKinMeta =
      const VerificationMeta('iNextOfKin');
  @override
  late final GeneratedColumn<String> iNextOfKin = GeneratedColumn<String>(
      'i_next_of_kin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nokContactMeta =
      const VerificationMeta('nokContact');
  @override
  late final GeneratedColumn<String> nokContact = GeneratedColumn<String>(
      'nok_contact', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pidMeta = const VerificationMeta('pid');
  @override
  late final GeneratedColumn<String> pid = GeneratedColumn<String>(
      'pid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pidNumberMeta =
      const VerificationMeta('pidNumber');
  @override
  late final GeneratedColumn<String> pidNumber = GeneratedColumn<String>(
      'pid_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vhbvMeta = const VerificationMeta('vhbv');
  @override
  late final GeneratedColumn<String> vhbv = GeneratedColumn<String>(
      'vhbv', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _whenHbvMeta =
      const VerificationMeta('whenHbv');
  @override
  late final GeneratedColumn<String> whenHbv = GeneratedColumn<String>(
      'when_hbv', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _facilityMeta =
      const VerificationMeta('facility');
  @override
  late final GeneratedColumn<String> facility = GeneratedColumn<String>(
      'facility', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _newDateMeta =
      const VerificationMeta('newDate');
  @override
  late final GeneratedColumn<int> newDate = GeneratedColumn<int>(
      'new_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeSlotMeta =
      const VerificationMeta('timeSlot');
  @override
  late final GeneratedColumn<String> timeSlot = GeneratedColumn<String>(
      'time_slot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refCodeMeta =
      const VerificationMeta('refCode');
  @override
  late final GeneratedColumn<String> refCode = GeneratedColumn<String>(
      'ref_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewMeta = const VerificationMeta('review');
  @override
  late final GeneratedColumn<String> review = GeneratedColumn<String>(
      'review', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _nextDonationDateMeta =
      const VerificationMeta('nextDonationDate');
  @override
  late final GeneratedColumn<int> nextDonationDate = GeneratedColumn<int>(
      'next_donation_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        donorType,
        surname,
        name,
        ageCategory,
        gender,
        address,
        phoneNumber,
        email,
        district,
        maritalStatus,
        occupation,
        nextOfKin,
        iNextOfKin,
        nokContact,
        pid,
        pidNumber,
        vhbv,
        whenHbv,
        bloodGroup,
        facility,
        date,
        newDate,
        month,
        year,
        timeSlot,
        refCode,
        status,
        review,
        rating,
        nextDonationDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_donation_schedule';
  @override
  VerificationContext validateIntegrity(
      Insertable<BloodDonationScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_type')) {
      context.handle(_donorTypeMeta,
          donorType.isAcceptableOrUnknown(data['donor_type']!, _donorTypeMeta));
    } else if (isInserting) {
      context.missing(_donorTypeMeta);
    }
    if (data.containsKey('surname')) {
      context.handle(_surnameMeta,
          surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta));
    } else if (isInserting) {
      context.missing(_surnameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age_category')) {
      context.handle(
          _ageCategoryMeta,
          ageCategory.isAcceptableOrUnknown(
              data['age_category']!, _ageCategoryMeta));
    } else if (isInserting) {
      context.missing(_ageCategoryMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('marital_status')) {
      context.handle(
          _maritalStatusMeta,
          maritalStatus.isAcceptableOrUnknown(
              data['marital_status']!, _maritalStatusMeta));
    } else if (isInserting) {
      context.missing(_maritalStatusMeta);
    }
    if (data.containsKey('occupation')) {
      context.handle(
          _occupationMeta,
          occupation.isAcceptableOrUnknown(
              data['occupation']!, _occupationMeta));
    } else if (isInserting) {
      context.missing(_occupationMeta);
    }
    if (data.containsKey('next_of_kin')) {
      context.handle(
          _nextOfKinMeta,
          nextOfKin.isAcceptableOrUnknown(
              data['next_of_kin']!, _nextOfKinMeta));
    } else if (isInserting) {
      context.missing(_nextOfKinMeta);
    }
    if (data.containsKey('i_next_of_kin')) {
      context.handle(
          _iNextOfKinMeta,
          iNextOfKin.isAcceptableOrUnknown(
              data['i_next_of_kin']!, _iNextOfKinMeta));
    } else if (isInserting) {
      context.missing(_iNextOfKinMeta);
    }
    if (data.containsKey('nok_contact')) {
      context.handle(
          _nokContactMeta,
          nokContact.isAcceptableOrUnknown(
              data['nok_contact']!, _nokContactMeta));
    } else if (isInserting) {
      context.missing(_nokContactMeta);
    }
    if (data.containsKey('pid')) {
      context.handle(
          _pidMeta, pid.isAcceptableOrUnknown(data['pid']!, _pidMeta));
    } else if (isInserting) {
      context.missing(_pidMeta);
    }
    if (data.containsKey('pid_number')) {
      context.handle(_pidNumberMeta,
          pidNumber.isAcceptableOrUnknown(data['pid_number']!, _pidNumberMeta));
    } else if (isInserting) {
      context.missing(_pidNumberMeta);
    }
    if (data.containsKey('vhbv')) {
      context.handle(
          _vhbvMeta, vhbv.isAcceptableOrUnknown(data['vhbv']!, _vhbvMeta));
    } else if (isInserting) {
      context.missing(_vhbvMeta);
    }
    if (data.containsKey('when_hbv')) {
      context.handle(_whenHbvMeta,
          whenHbv.isAcceptableOrUnknown(data['when_hbv']!, _whenHbvMeta));
    } else if (isInserting) {
      context.missing(_whenHbvMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupMeta);
    }
    if (data.containsKey('facility')) {
      context.handle(_facilityMeta,
          facility.isAcceptableOrUnknown(data['facility']!, _facilityMeta));
    } else if (isInserting) {
      context.missing(_facilityMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('new_date')) {
      context.handle(_newDateMeta,
          newDate.isAcceptableOrUnknown(data['new_date']!, _newDateMeta));
    } else if (isInserting) {
      context.missing(_newDateMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('time_slot')) {
      context.handle(_timeSlotMeta,
          timeSlot.isAcceptableOrUnknown(data['time_slot']!, _timeSlotMeta));
    } else if (isInserting) {
      context.missing(_timeSlotMeta);
    }
    if (data.containsKey('ref_code')) {
      context.handle(_refCodeMeta,
          refCode.isAcceptableOrUnknown(data['ref_code']!, _refCodeMeta));
    } else if (isInserting) {
      context.missing(_refCodeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('review')) {
      context.handle(_reviewMeta,
          review.isAcceptableOrUnknown(data['review']!, _reviewMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('next_donation_date')) {
      context.handle(
          _nextDonationDateMeta,
          nextDonationDate.isAcceptableOrUnknown(
              data['next_donation_date']!, _nextDonationDateMeta));
    } else if (isInserting) {
      context.missing(_nextDonationDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodDonationScheduleData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodDonationScheduleData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      donorType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}donor_type'])!,
      surname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}surname'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ageCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age_category'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      district: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}district'])!,
      maritalStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marital_status'])!,
      occupation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occupation'])!,
      nextOfKin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_of_kin'])!,
      iNextOfKin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}i_next_of_kin'])!,
      nokContact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nok_contact'])!,
      pid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pid'])!,
      pidNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pid_number'])!,
      vhbv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vhbv'])!,
      whenHbv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}when_hbv'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group'])!,
      facility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}facility'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      newDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}new_date'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      timeSlot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_slot'])!,
      refCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ref_code'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      review: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
      nextDonationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}next_donation_date'])!,
    );
  }

  @override
  $BloodDonationScheduleTable createAlias(String alias) {
    return $BloodDonationScheduleTable(attachedDatabase, alias);
  }
}

class BloodDonationScheduleData extends DataClass
    implements Insertable<BloodDonationScheduleData> {
  final int id;
  final String donorType;
  final String surname;
  final String name;
  final String ageCategory;
  final String gender;
  final String address;
  final String phoneNumber;
  final String email;
  final String district;
  final String maritalStatus;
  final String occupation;
  final String nextOfKin;
  final String iNextOfKin;
  final String nokContact;
  final String pid;
  final String pidNumber;
  final String vhbv;
  final String whenHbv;
  final String bloodGroup;
  final String facility;
  final int date;
  final int newDate;
  final int month;
  final int year;
  final String timeSlot;
  final String refCode;
  final String status;
  final String? review;
  final double? rating;
  final int nextDonationDate;
  const BloodDonationScheduleData(
      {required this.id,
      required this.donorType,
      required this.surname,
      required this.name,
      required this.ageCategory,
      required this.gender,
      required this.address,
      required this.phoneNumber,
      required this.email,
      required this.district,
      required this.maritalStatus,
      required this.occupation,
      required this.nextOfKin,
      required this.iNextOfKin,
      required this.nokContact,
      required this.pid,
      required this.pidNumber,
      required this.vhbv,
      required this.whenHbv,
      required this.bloodGroup,
      required this.facility,
      required this.date,
      required this.newDate,
      required this.month,
      required this.year,
      required this.timeSlot,
      required this.refCode,
      required this.status,
      this.review,
      this.rating,
      required this.nextDonationDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_type'] = Variable<String>(donorType);
    map['surname'] = Variable<String>(surname);
    map['name'] = Variable<String>(name);
    map['age_category'] = Variable<String>(ageCategory);
    map['gender'] = Variable<String>(gender);
    map['address'] = Variable<String>(address);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['email'] = Variable<String>(email);
    map['district'] = Variable<String>(district);
    map['marital_status'] = Variable<String>(maritalStatus);
    map['occupation'] = Variable<String>(occupation);
    map['next_of_kin'] = Variable<String>(nextOfKin);
    map['i_next_of_kin'] = Variable<String>(iNextOfKin);
    map['nok_contact'] = Variable<String>(nokContact);
    map['pid'] = Variable<String>(pid);
    map['pid_number'] = Variable<String>(pidNumber);
    map['vhbv'] = Variable<String>(vhbv);
    map['when_hbv'] = Variable<String>(whenHbv);
    map['blood_group'] = Variable<String>(bloodGroup);
    map['facility'] = Variable<String>(facility);
    map['date'] = Variable<int>(date);
    map['new_date'] = Variable<int>(newDate);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    map['time_slot'] = Variable<String>(timeSlot);
    map['ref_code'] = Variable<String>(refCode);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || review != null) {
      map['review'] = Variable<String>(review);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    map['next_donation_date'] = Variable<int>(nextDonationDate);
    return map;
  }

  BloodDonationScheduleCompanion toCompanion(bool nullToAbsent) {
    return BloodDonationScheduleCompanion(
      id: Value(id),
      donorType: Value(donorType),
      surname: Value(surname),
      name: Value(name),
      ageCategory: Value(ageCategory),
      gender: Value(gender),
      address: Value(address),
      phoneNumber: Value(phoneNumber),
      email: Value(email),
      district: Value(district),
      maritalStatus: Value(maritalStatus),
      occupation: Value(occupation),
      nextOfKin: Value(nextOfKin),
      iNextOfKin: Value(iNextOfKin),
      nokContact: Value(nokContact),
      pid: Value(pid),
      pidNumber: Value(pidNumber),
      vhbv: Value(vhbv),
      whenHbv: Value(whenHbv),
      bloodGroup: Value(bloodGroup),
      facility: Value(facility),
      date: Value(date),
      newDate: Value(newDate),
      month: Value(month),
      year: Value(year),
      timeSlot: Value(timeSlot),
      refCode: Value(refCode),
      status: Value(status),
      review:
          review == null && nullToAbsent ? const Value.absent() : Value(review),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      nextDonationDate: Value(nextDonationDate),
    );
  }

  factory BloodDonationScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodDonationScheduleData(
      id: serializer.fromJson<int>(json['id']),
      donorType: serializer.fromJson<String>(json['donorType']),
      surname: serializer.fromJson<String>(json['surname']),
      name: serializer.fromJson<String>(json['name']),
      ageCategory: serializer.fromJson<String>(json['ageCategory']),
      gender: serializer.fromJson<String>(json['gender']),
      address: serializer.fromJson<String>(json['address']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      email: serializer.fromJson<String>(json['email']),
      district: serializer.fromJson<String>(json['district']),
      maritalStatus: serializer.fromJson<String>(json['maritalStatus']),
      occupation: serializer.fromJson<String>(json['occupation']),
      nextOfKin: serializer.fromJson<String>(json['nextOfKin']),
      iNextOfKin: serializer.fromJson<String>(json['iNextOfKin']),
      nokContact: serializer.fromJson<String>(json['nokContact']),
      pid: serializer.fromJson<String>(json['pid']),
      pidNumber: serializer.fromJson<String>(json['pidNumber']),
      vhbv: serializer.fromJson<String>(json['vhbv']),
      whenHbv: serializer.fromJson<String>(json['whenHbv']),
      bloodGroup: serializer.fromJson<String>(json['bloodGroup']),
      facility: serializer.fromJson<String>(json['facility']),
      date: serializer.fromJson<int>(json['date']),
      newDate: serializer.fromJson<int>(json['newDate']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      timeSlot: serializer.fromJson<String>(json['timeSlot']),
      refCode: serializer.fromJson<String>(json['refCode']),
      status: serializer.fromJson<String>(json['status']),
      review: serializer.fromJson<String?>(json['review']),
      rating: serializer.fromJson<double?>(json['rating']),
      nextDonationDate: serializer.fromJson<int>(json['nextDonationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorType': serializer.toJson<String>(donorType),
      'surname': serializer.toJson<String>(surname),
      'name': serializer.toJson<String>(name),
      'ageCategory': serializer.toJson<String>(ageCategory),
      'gender': serializer.toJson<String>(gender),
      'address': serializer.toJson<String>(address),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'email': serializer.toJson<String>(email),
      'district': serializer.toJson<String>(district),
      'maritalStatus': serializer.toJson<String>(maritalStatus),
      'occupation': serializer.toJson<String>(occupation),
      'nextOfKin': serializer.toJson<String>(nextOfKin),
      'iNextOfKin': serializer.toJson<String>(iNextOfKin),
      'nokContact': serializer.toJson<String>(nokContact),
      'pid': serializer.toJson<String>(pid),
      'pidNumber': serializer.toJson<String>(pidNumber),
      'vhbv': serializer.toJson<String>(vhbv),
      'whenHbv': serializer.toJson<String>(whenHbv),
      'bloodGroup': serializer.toJson<String>(bloodGroup),
      'facility': serializer.toJson<String>(facility),
      'date': serializer.toJson<int>(date),
      'newDate': serializer.toJson<int>(newDate),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'timeSlot': serializer.toJson<String>(timeSlot),
      'refCode': serializer.toJson<String>(refCode),
      'status': serializer.toJson<String>(status),
      'review': serializer.toJson<String?>(review),
      'rating': serializer.toJson<double?>(rating),
      'nextDonationDate': serializer.toJson<int>(nextDonationDate),
    };
  }

  BloodDonationScheduleData copyWith(
          {int? id,
          String? donorType,
          String? surname,
          String? name,
          String? ageCategory,
          String? gender,
          String? address,
          String? phoneNumber,
          String? email,
          String? district,
          String? maritalStatus,
          String? occupation,
          String? nextOfKin,
          String? iNextOfKin,
          String? nokContact,
          String? pid,
          String? pidNumber,
          String? vhbv,
          String? whenHbv,
          String? bloodGroup,
          String? facility,
          int? date,
          int? newDate,
          int? month,
          int? year,
          String? timeSlot,
          String? refCode,
          String? status,
          Value<String?> review = const Value.absent(),
          Value<double?> rating = const Value.absent(),
          int? nextDonationDate}) =>
      BloodDonationScheduleData(
        id: id ?? this.id,
        donorType: donorType ?? this.donorType,
        surname: surname ?? this.surname,
        name: name ?? this.name,
        ageCategory: ageCategory ?? this.ageCategory,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        district: district ?? this.district,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        occupation: occupation ?? this.occupation,
        nextOfKin: nextOfKin ?? this.nextOfKin,
        iNextOfKin: iNextOfKin ?? this.iNextOfKin,
        nokContact: nokContact ?? this.nokContact,
        pid: pid ?? this.pid,
        pidNumber: pidNumber ?? this.pidNumber,
        vhbv: vhbv ?? this.vhbv,
        whenHbv: whenHbv ?? this.whenHbv,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        facility: facility ?? this.facility,
        date: date ?? this.date,
        newDate: newDate ?? this.newDate,
        month: month ?? this.month,
        year: year ?? this.year,
        timeSlot: timeSlot ?? this.timeSlot,
        refCode: refCode ?? this.refCode,
        status: status ?? this.status,
        review: review.present ? review.value : this.review,
        rating: rating.present ? rating.value : this.rating,
        nextDonationDate: nextDonationDate ?? this.nextDonationDate,
      );
  @override
  String toString() {
    return (StringBuffer('BloodDonationScheduleData(')
          ..write('id: $id, ')
          ..write('donorType: $donorType, ')
          ..write('surname: $surname, ')
          ..write('name: $name, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('district: $district, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('occupation: $occupation, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('iNextOfKin: $iNextOfKin, ')
          ..write('nokContact: $nokContact, ')
          ..write('pid: $pid, ')
          ..write('pidNumber: $pidNumber, ')
          ..write('vhbv: $vhbv, ')
          ..write('whenHbv: $whenHbv, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('facility: $facility, ')
          ..write('date: $date, ')
          ..write('newDate: $newDate, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('timeSlot: $timeSlot, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('review: $review, ')
          ..write('rating: $rating, ')
          ..write('nextDonationDate: $nextDonationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        donorType,
        surname,
        name,
        ageCategory,
        gender,
        address,
        phoneNumber,
        email,
        district,
        maritalStatus,
        occupation,
        nextOfKin,
        iNextOfKin,
        nokContact,
        pid,
        pidNumber,
        vhbv,
        whenHbv,
        bloodGroup,
        facility,
        date,
        newDate,
        month,
        year,
        timeSlot,
        refCode,
        status,
        review,
        rating,
        nextDonationDate
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodDonationScheduleData &&
          other.id == this.id &&
          other.donorType == this.donorType &&
          other.surname == this.surname &&
          other.name == this.name &&
          other.ageCategory == this.ageCategory &&
          other.gender == this.gender &&
          other.address == this.address &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.district == this.district &&
          other.maritalStatus == this.maritalStatus &&
          other.occupation == this.occupation &&
          other.nextOfKin == this.nextOfKin &&
          other.iNextOfKin == this.iNextOfKin &&
          other.nokContact == this.nokContact &&
          other.pid == this.pid &&
          other.pidNumber == this.pidNumber &&
          other.vhbv == this.vhbv &&
          other.whenHbv == this.whenHbv &&
          other.bloodGroup == this.bloodGroup &&
          other.facility == this.facility &&
          other.date == this.date &&
          other.newDate == this.newDate &&
          other.month == this.month &&
          other.year == this.year &&
          other.timeSlot == this.timeSlot &&
          other.refCode == this.refCode &&
          other.status == this.status &&
          other.review == this.review &&
          other.rating == this.rating &&
          other.nextDonationDate == this.nextDonationDate);
}

class BloodDonationScheduleCompanion
    extends UpdateCompanion<BloodDonationScheduleData> {
  final Value<int> id;
  final Value<String> donorType;
  final Value<String> surname;
  final Value<String> name;
  final Value<String> ageCategory;
  final Value<String> gender;
  final Value<String> address;
  final Value<String> phoneNumber;
  final Value<String> email;
  final Value<String> district;
  final Value<String> maritalStatus;
  final Value<String> occupation;
  final Value<String> nextOfKin;
  final Value<String> iNextOfKin;
  final Value<String> nokContact;
  final Value<String> pid;
  final Value<String> pidNumber;
  final Value<String> vhbv;
  final Value<String> whenHbv;
  final Value<String> bloodGroup;
  final Value<String> facility;
  final Value<int> date;
  final Value<int> newDate;
  final Value<int> month;
  final Value<int> year;
  final Value<String> timeSlot;
  final Value<String> refCode;
  final Value<String> status;
  final Value<String?> review;
  final Value<double?> rating;
  final Value<int> nextDonationDate;
  const BloodDonationScheduleCompanion({
    this.id = const Value.absent(),
    this.donorType = const Value.absent(),
    this.surname = const Value.absent(),
    this.name = const Value.absent(),
    this.ageCategory = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.district = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.occupation = const Value.absent(),
    this.nextOfKin = const Value.absent(),
    this.iNextOfKin = const Value.absent(),
    this.nokContact = const Value.absent(),
    this.pid = const Value.absent(),
    this.pidNumber = const Value.absent(),
    this.vhbv = const Value.absent(),
    this.whenHbv = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.facility = const Value.absent(),
    this.date = const Value.absent(),
    this.newDate = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.timeSlot = const Value.absent(),
    this.refCode = const Value.absent(),
    this.status = const Value.absent(),
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
    this.nextDonationDate = const Value.absent(),
  });
  BloodDonationScheduleCompanion.insert({
    this.id = const Value.absent(),
    required String donorType,
    required String surname,
    required String name,
    required String ageCategory,
    required String gender,
    required String address,
    required String phoneNumber,
    required String email,
    required String district,
    required String maritalStatus,
    required String occupation,
    required String nextOfKin,
    required String iNextOfKin,
    required String nokContact,
    required String pid,
    required String pidNumber,
    required String vhbv,
    required String whenHbv,
    required String bloodGroup,
    required String facility,
    required int date,
    required int newDate,
    required int month,
    required int year,
    required String timeSlot,
    required String refCode,
    required String status,
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
    required int nextDonationDate,
  })  : donorType = Value(donorType),
        surname = Value(surname),
        name = Value(name),
        ageCategory = Value(ageCategory),
        gender = Value(gender),
        address = Value(address),
        phoneNumber = Value(phoneNumber),
        email = Value(email),
        district = Value(district),
        maritalStatus = Value(maritalStatus),
        occupation = Value(occupation),
        nextOfKin = Value(nextOfKin),
        iNextOfKin = Value(iNextOfKin),
        nokContact = Value(nokContact),
        pid = Value(pid),
        pidNumber = Value(pidNumber),
        vhbv = Value(vhbv),
        whenHbv = Value(whenHbv),
        bloodGroup = Value(bloodGroup),
        facility = Value(facility),
        date = Value(date),
        newDate = Value(newDate),
        month = Value(month),
        year = Value(year),
        timeSlot = Value(timeSlot),
        refCode = Value(refCode),
        status = Value(status),
        nextDonationDate = Value(nextDonationDate);
  static Insertable<BloodDonationScheduleData> custom({
    Expression<int>? id,
    Expression<String>? donorType,
    Expression<String>? surname,
    Expression<String>? name,
    Expression<String>? ageCategory,
    Expression<String>? gender,
    Expression<String>? address,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? district,
    Expression<String>? maritalStatus,
    Expression<String>? occupation,
    Expression<String>? nextOfKin,
    Expression<String>? iNextOfKin,
    Expression<String>? nokContact,
    Expression<String>? pid,
    Expression<String>? pidNumber,
    Expression<String>? vhbv,
    Expression<String>? whenHbv,
    Expression<String>? bloodGroup,
    Expression<String>? facility,
    Expression<int>? date,
    Expression<int>? newDate,
    Expression<int>? month,
    Expression<int>? year,
    Expression<String>? timeSlot,
    Expression<String>? refCode,
    Expression<String>? status,
    Expression<String>? review,
    Expression<double>? rating,
    Expression<int>? nextDonationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorType != null) 'donor_type': donorType,
      if (surname != null) 'surname': surname,
      if (name != null) 'name': name,
      if (ageCategory != null) 'age_category': ageCategory,
      if (gender != null) 'gender': gender,
      if (address != null) 'address': address,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (district != null) 'district': district,
      if (maritalStatus != null) 'marital_status': maritalStatus,
      if (occupation != null) 'occupation': occupation,
      if (nextOfKin != null) 'next_of_kin': nextOfKin,
      if (iNextOfKin != null) 'i_next_of_kin': iNextOfKin,
      if (nokContact != null) 'nok_contact': nokContact,
      if (pid != null) 'pid': pid,
      if (pidNumber != null) 'pid_number': pidNumber,
      if (vhbv != null) 'vhbv': vhbv,
      if (whenHbv != null) 'when_hbv': whenHbv,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (facility != null) 'facility': facility,
      if (date != null) 'date': date,
      if (newDate != null) 'new_date': newDate,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (timeSlot != null) 'time_slot': timeSlot,
      if (refCode != null) 'ref_code': refCode,
      if (status != null) 'status': status,
      if (review != null) 'review': review,
      if (rating != null) 'rating': rating,
      if (nextDonationDate != null) 'next_donation_date': nextDonationDate,
    });
  }

  BloodDonationScheduleCompanion copyWith(
      {Value<int>? id,
      Value<String>? donorType,
      Value<String>? surname,
      Value<String>? name,
      Value<String>? ageCategory,
      Value<String>? gender,
      Value<String>? address,
      Value<String>? phoneNumber,
      Value<String>? email,
      Value<String>? district,
      Value<String>? maritalStatus,
      Value<String>? occupation,
      Value<String>? nextOfKin,
      Value<String>? iNextOfKin,
      Value<String>? nokContact,
      Value<String>? pid,
      Value<String>? pidNumber,
      Value<String>? vhbv,
      Value<String>? whenHbv,
      Value<String>? bloodGroup,
      Value<String>? facility,
      Value<int>? date,
      Value<int>? newDate,
      Value<int>? month,
      Value<int>? year,
      Value<String>? timeSlot,
      Value<String>? refCode,
      Value<String>? status,
      Value<String?>? review,
      Value<double?>? rating,
      Value<int>? nextDonationDate}) {
    return BloodDonationScheduleCompanion(
      id: id ?? this.id,
      donorType: donorType ?? this.donorType,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      ageCategory: ageCategory ?? this.ageCategory,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      district: district ?? this.district,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      occupation: occupation ?? this.occupation,
      nextOfKin: nextOfKin ?? this.nextOfKin,
      iNextOfKin: iNextOfKin ?? this.iNextOfKin,
      nokContact: nokContact ?? this.nokContact,
      pid: pid ?? this.pid,
      pidNumber: pidNumber ?? this.pidNumber,
      vhbv: vhbv ?? this.vhbv,
      whenHbv: whenHbv ?? this.whenHbv,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      facility: facility ?? this.facility,
      date: date ?? this.date,
      newDate: newDate ?? this.newDate,
      month: month ?? this.month,
      year: year ?? this.year,
      timeSlot: timeSlot ?? this.timeSlot,
      refCode: refCode ?? this.refCode,
      status: status ?? this.status,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      nextDonationDate: nextDonationDate ?? this.nextDonationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorType.present) {
      map['donor_type'] = Variable<String>(donorType.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ageCategory.present) {
      map['age_category'] = Variable<String>(ageCategory.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (maritalStatus.present) {
      map['marital_status'] = Variable<String>(maritalStatus.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    if (nextOfKin.present) {
      map['next_of_kin'] = Variable<String>(nextOfKin.value);
    }
    if (iNextOfKin.present) {
      map['i_next_of_kin'] = Variable<String>(iNextOfKin.value);
    }
    if (nokContact.present) {
      map['nok_contact'] = Variable<String>(nokContact.value);
    }
    if (pid.present) {
      map['pid'] = Variable<String>(pid.value);
    }
    if (pidNumber.present) {
      map['pid_number'] = Variable<String>(pidNumber.value);
    }
    if (vhbv.present) {
      map['vhbv'] = Variable<String>(vhbv.value);
    }
    if (whenHbv.present) {
      map['when_hbv'] = Variable<String>(whenHbv.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (facility.present) {
      map['facility'] = Variable<String>(facility.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (newDate.present) {
      map['new_date'] = Variable<int>(newDate.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (timeSlot.present) {
      map['time_slot'] = Variable<String>(timeSlot.value);
    }
    if (refCode.present) {
      map['ref_code'] = Variable<String>(refCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (review.present) {
      map['review'] = Variable<String>(review.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (nextDonationDate.present) {
      map['next_donation_date'] = Variable<int>(nextDonationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodDonationScheduleCompanion(')
          ..write('id: $id, ')
          ..write('donorType: $donorType, ')
          ..write('surname: $surname, ')
          ..write('name: $name, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('district: $district, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('occupation: $occupation, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('iNextOfKin: $iNextOfKin, ')
          ..write('nokContact: $nokContact, ')
          ..write('pid: $pid, ')
          ..write('pidNumber: $pidNumber, ')
          ..write('vhbv: $vhbv, ')
          ..write('whenHbv: $whenHbv, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('facility: $facility, ')
          ..write('date: $date, ')
          ..write('newDate: $newDate, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('timeSlot: $timeSlot, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('review: $review, ')
          ..write('rating: $rating, ')
          ..write('nextDonationDate: $nextDonationDate')
          ..write(')'))
        .toString();
  }
}

class $BloodDonorRequestTable extends BloodDonorRequest
    with TableInfo<$BloodDonorRequestTable, BloodDonorRequestData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodDonorRequestTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _facilityMeta =
      const VerificationMeta('facility');
  @override
  late final GeneratedColumn<String> facility = GeneratedColumn<String>(
      'facility', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wardMeta = const VerificationMeta('ward');
  @override
  late final GeneratedColumn<String> ward = GeneratedColumn<String>(
      'ward', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientTypeMeta =
      const VerificationMeta('patientType');
  @override
  late final GeneratedColumn<String> patientType = GeneratedColumn<String>(
      'patient_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodComponentMeta =
      const VerificationMeta('bloodComponent');
  @override
  late final GeneratedColumn<String> bloodComponent = GeneratedColumn<String>(
      'blood_component', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<int> units = GeneratedColumn<int>(
      'units', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        facility,
        ward,
        gender,
        patientType,
        bloodComponent,
        bloodGroup,
        units,
        date
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_donor_request';
  @override
  VerificationContext validateIntegrity(
      Insertable<BloodDonorRequestData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('facility')) {
      context.handle(_facilityMeta,
          facility.isAcceptableOrUnknown(data['facility']!, _facilityMeta));
    } else if (isInserting) {
      context.missing(_facilityMeta);
    }
    if (data.containsKey('ward')) {
      context.handle(
          _wardMeta, ward.isAcceptableOrUnknown(data['ward']!, _wardMeta));
    } else if (isInserting) {
      context.missing(_wardMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('patient_type')) {
      context.handle(
          _patientTypeMeta,
          patientType.isAcceptableOrUnknown(
              data['patient_type']!, _patientTypeMeta));
    } else if (isInserting) {
      context.missing(_patientTypeMeta);
    }
    if (data.containsKey('blood_component')) {
      context.handle(
          _bloodComponentMeta,
          bloodComponent.isAcceptableOrUnknown(
              data['blood_component']!, _bloodComponentMeta));
    } else if (isInserting) {
      context.missing(_bloodComponentMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupMeta);
    }
    if (data.containsKey('units')) {
      context.handle(
          _unitsMeta, units.isAcceptableOrUnknown(data['units']!, _unitsMeta));
    } else if (isInserting) {
      context.missing(_unitsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodDonorRequestData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodDonorRequestData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      facility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}facility'])!,
      ward: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ward'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      patientType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_type'])!,
      bloodComponent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}blood_component'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group'])!,
      units: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}units'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $BloodDonorRequestTable createAlias(String alias) {
    return $BloodDonorRequestTable(attachedDatabase, alias);
  }
}

class BloodDonorRequestData extends DataClass
    implements Insertable<BloodDonorRequestData> {
  final int id;
  final String facility;
  final String ward;
  final String gender;
  final String patientType;
  final String bloodComponent;
  final String bloodGroup;
  final int units;
  final int date;
  const BloodDonorRequestData(
      {required this.id,
      required this.facility,
      required this.ward,
      required this.gender,
      required this.patientType,
      required this.bloodComponent,
      required this.bloodGroup,
      required this.units,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['facility'] = Variable<String>(facility);
    map['ward'] = Variable<String>(ward);
    map['gender'] = Variable<String>(gender);
    map['patient_type'] = Variable<String>(patientType);
    map['blood_component'] = Variable<String>(bloodComponent);
    map['blood_group'] = Variable<String>(bloodGroup);
    map['units'] = Variable<int>(units);
    map['date'] = Variable<int>(date);
    return map;
  }

  BloodDonorRequestCompanion toCompanion(bool nullToAbsent) {
    return BloodDonorRequestCompanion(
      id: Value(id),
      facility: Value(facility),
      ward: Value(ward),
      gender: Value(gender),
      patientType: Value(patientType),
      bloodComponent: Value(bloodComponent),
      bloodGroup: Value(bloodGroup),
      units: Value(units),
      date: Value(date),
    );
  }

  factory BloodDonorRequestData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodDonorRequestData(
      id: serializer.fromJson<int>(json['id']),
      facility: serializer.fromJson<String>(json['facility']),
      ward: serializer.fromJson<String>(json['ward']),
      gender: serializer.fromJson<String>(json['gender']),
      patientType: serializer.fromJson<String>(json['patientType']),
      bloodComponent: serializer.fromJson<String>(json['bloodComponent']),
      bloodGroup: serializer.fromJson<String>(json['bloodGroup']),
      units: serializer.fromJson<int>(json['units']),
      date: serializer.fromJson<int>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'facility': serializer.toJson<String>(facility),
      'ward': serializer.toJson<String>(ward),
      'gender': serializer.toJson<String>(gender),
      'patientType': serializer.toJson<String>(patientType),
      'bloodComponent': serializer.toJson<String>(bloodComponent),
      'bloodGroup': serializer.toJson<String>(bloodGroup),
      'units': serializer.toJson<int>(units),
      'date': serializer.toJson<int>(date),
    };
  }

  BloodDonorRequestData copyWith(
          {int? id,
          String? facility,
          String? ward,
          String? gender,
          String? patientType,
          String? bloodComponent,
          String? bloodGroup,
          int? units,
          int? date}) =>
      BloodDonorRequestData(
        id: id ?? this.id,
        facility: facility ?? this.facility,
        ward: ward ?? this.ward,
        gender: gender ?? this.gender,
        patientType: patientType ?? this.patientType,
        bloodComponent: bloodComponent ?? this.bloodComponent,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        units: units ?? this.units,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('BloodDonorRequestData(')
          ..write('id: $id, ')
          ..write('facility: $facility, ')
          ..write('ward: $ward, ')
          ..write('gender: $gender, ')
          ..write('patientType: $patientType, ')
          ..write('bloodComponent: $bloodComponent, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('units: $units, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, facility, ward, gender, patientType,
      bloodComponent, bloodGroup, units, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodDonorRequestData &&
          other.id == this.id &&
          other.facility == this.facility &&
          other.ward == this.ward &&
          other.gender == this.gender &&
          other.patientType == this.patientType &&
          other.bloodComponent == this.bloodComponent &&
          other.bloodGroup == this.bloodGroup &&
          other.units == this.units &&
          other.date == this.date);
}

class BloodDonorRequestCompanion
    extends UpdateCompanion<BloodDonorRequestData> {
  final Value<int> id;
  final Value<String> facility;
  final Value<String> ward;
  final Value<String> gender;
  final Value<String> patientType;
  final Value<String> bloodComponent;
  final Value<String> bloodGroup;
  final Value<int> units;
  final Value<int> date;
  const BloodDonorRequestCompanion({
    this.id = const Value.absent(),
    this.facility = const Value.absent(),
    this.ward = const Value.absent(),
    this.gender = const Value.absent(),
    this.patientType = const Value.absent(),
    this.bloodComponent = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.units = const Value.absent(),
    this.date = const Value.absent(),
  });
  BloodDonorRequestCompanion.insert({
    this.id = const Value.absent(),
    required String facility,
    required String ward,
    required String gender,
    required String patientType,
    required String bloodComponent,
    required String bloodGroup,
    required int units,
    required int date,
  })  : facility = Value(facility),
        ward = Value(ward),
        gender = Value(gender),
        patientType = Value(patientType),
        bloodComponent = Value(bloodComponent),
        bloodGroup = Value(bloodGroup),
        units = Value(units),
        date = Value(date);
  static Insertable<BloodDonorRequestData> custom({
    Expression<int>? id,
    Expression<String>? facility,
    Expression<String>? ward,
    Expression<String>? gender,
    Expression<String>? patientType,
    Expression<String>? bloodComponent,
    Expression<String>? bloodGroup,
    Expression<int>? units,
    Expression<int>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (facility != null) 'facility': facility,
      if (ward != null) 'ward': ward,
      if (gender != null) 'gender': gender,
      if (patientType != null) 'patient_type': patientType,
      if (bloodComponent != null) 'blood_component': bloodComponent,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (units != null) 'units': units,
      if (date != null) 'date': date,
    });
  }

  BloodDonorRequestCompanion copyWith(
      {Value<int>? id,
      Value<String>? facility,
      Value<String>? ward,
      Value<String>? gender,
      Value<String>? patientType,
      Value<String>? bloodComponent,
      Value<String>? bloodGroup,
      Value<int>? units,
      Value<int>? date}) {
    return BloodDonorRequestCompanion(
      id: id ?? this.id,
      facility: facility ?? this.facility,
      ward: ward ?? this.ward,
      gender: gender ?? this.gender,
      patientType: patientType ?? this.patientType,
      bloodComponent: bloodComponent ?? this.bloodComponent,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      units: units ?? this.units,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (facility.present) {
      map['facility'] = Variable<String>(facility.value);
    }
    if (ward.present) {
      map['ward'] = Variable<String>(ward.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (patientType.present) {
      map['patient_type'] = Variable<String>(patientType.value);
    }
    if (bloodComponent.present) {
      map['blood_component'] = Variable<String>(bloodComponent.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (units.present) {
      map['units'] = Variable<int>(units.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodDonorRequestCompanion(')
          ..write('id: $id, ')
          ..write('facility: $facility, ')
          ..write('ward: $ward, ')
          ..write('gender: $gender, ')
          ..write('patientType: $patientType, ')
          ..write('bloodComponent: $bloodComponent, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('units: $units, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DonationCampaignDonorTable extends DonationCampaignDonor
    with TableInfo<$DonationCampaignDonorTable, DonationCampaignDonorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonationCampaignDonorTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _rbtcIdMeta = const VerificationMeta('rbtcId');
  @override
  late final GeneratedColumn<int> rbtcId = GeneratedColumn<int>(
      'rbtc_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _surnameMeta =
      const VerificationMeta('surname');
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
      'surname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageCategoryMeta =
      const VerificationMeta('ageCategory');
  @override
  late final GeneratedColumn<String> ageCategory = GeneratedColumn<String>(
      'age_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _donorPhoneNumberMeta =
      const VerificationMeta('donorPhoneNumber');
  @override
  late final GeneratedColumn<String> donorPhoneNumber = GeneratedColumn<String>(
      'donor_phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _donorEmailMeta =
      const VerificationMeta('donorEmail');
  @override
  late final GeneratedColumn<String> donorEmail = GeneratedColumn<String>(
      'donor_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _districtMeta =
      const VerificationMeta('district');
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
      'district', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _maritalStatusMeta =
      const VerificationMeta('maritalStatus');
  @override
  late final GeneratedColumn<String> maritalStatus = GeneratedColumn<String>(
      'marital_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _occupationMeta =
      const VerificationMeta('occupation');
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
      'occupation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextOfKinMeta =
      const VerificationMeta('nextOfKin');
  @override
  late final GeneratedColumn<String> nextOfKin = GeneratedColumn<String>(
      'next_of_kin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iNextOfKinMeta =
      const VerificationMeta('iNextOfKin');
  @override
  late final GeneratedColumn<String> iNextOfKin = GeneratedColumn<String>(
      'i_next_of_kin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nokContactMeta =
      const VerificationMeta('nokContact');
  @override
  late final GeneratedColumn<String> nokContact = GeneratedColumn<String>(
      'nok_contact', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pidMeta = const VerificationMeta('pid');
  @override
  late final GeneratedColumn<String> pid = GeneratedColumn<String>(
      'pid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pidNumberMeta =
      const VerificationMeta('pidNumber');
  @override
  late final GeneratedColumn<String> pidNumber = GeneratedColumn<String>(
      'pid_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vhbvMeta = const VerificationMeta('vhbv');
  @override
  late final GeneratedColumn<String> vhbv = GeneratedColumn<String>(
      'vhbv', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _whenHbvMeta =
      const VerificationMeta('whenHbv');
  @override
  late final GeneratedColumn<String> whenHbv = GeneratedColumn<String>(
      'when_hbv', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignIdMeta =
      const VerificationMeta('campaignId');
  @override
  late final GeneratedColumn<int> campaignId = GeneratedColumn<int>(
      'campaign_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _campaignNameMeta =
      const VerificationMeta('campaignName');
  @override
  late final GeneratedColumn<String> campaignName = GeneratedColumn<String>(
      'campaign_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignCreatorMeta =
      const VerificationMeta('campaignCreator');
  @override
  late final GeneratedColumn<String> campaignCreator = GeneratedColumn<String>(
      'campaign_creator', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignDescriptionMeta =
      const VerificationMeta('campaignDescription');
  @override
  late final GeneratedColumn<String> campaignDescription =
      GeneratedColumn<String>('campaign_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignContactMeta =
      const VerificationMeta('campaignContact');
  @override
  late final GeneratedColumn<String> campaignContact = GeneratedColumn<String>(
      'campaign_contact', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignEmailMeta =
      const VerificationMeta('campaignEmail');
  @override
  late final GeneratedColumn<String> campaignEmail = GeneratedColumn<String>(
      'campaign_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _facilityMeta =
      const VerificationMeta('facility');
  @override
  late final GeneratedColumn<String> facility = GeneratedColumn<String>(
      'facility', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignFacilityMeta =
      const VerificationMeta('campaignFacility');
  @override
  late final GeneratedColumn<String> campaignFacility = GeneratedColumn<String>(
      'campaign_facility', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignLocationMeta =
      const VerificationMeta('campaignLocation');
  @override
  late final GeneratedColumn<String> campaignLocation = GeneratedColumn<String>(
      'campaign_location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignDistrictMeta =
      const VerificationMeta('campaignDistrict');
  @override
  late final GeneratedColumn<String> campaignDistrict = GeneratedColumn<String>(
      'campaign_district', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campaignDateMeta =
      const VerificationMeta('campaignDate');
  @override
  late final GeneratedColumn<int> campaignDate = GeneratedColumn<int>(
      'campaign_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _campaignDateCreatedMeta =
      const VerificationMeta('campaignDateCreated');
  @override
  late final GeneratedColumn<int> campaignDateCreated = GeneratedColumn<int>(
      'campaign_date_created', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _campaignStatusMeta =
      const VerificationMeta('campaignStatus');
  @override
  late final GeneratedColumn<String> campaignStatus = GeneratedColumn<String>(
      'campaign_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _atLabMeta = const VerificationMeta('atLab');
  @override
  late final GeneratedColumn<String> atLab = GeneratedColumn<String>(
      'at_lab', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _refCodeMeta =
      const VerificationMeta('refCode');
  @override
  late final GeneratedColumn<String> refCode = GeneratedColumn<String>(
      'ref_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewMeta = const VerificationMeta('review');
  @override
  late final GeneratedColumn<String> review = GeneratedColumn<String>(
      'review', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        rbtcId,
        surname,
        name,
        ageCategory,
        gender,
        address,
        donorPhoneNumber,
        donorEmail,
        district,
        maritalStatus,
        occupation,
        nextOfKin,
        iNextOfKin,
        nokContact,
        pid,
        pidNumber,
        vhbv,
        whenHbv,
        bloodGroup,
        campaignId,
        campaignName,
        campaignCreator,
        campaignDescription,
        campaignContact,
        campaignEmail,
        facility,
        campaignFacility,
        campaignLocation,
        campaignDistrict,
        campaignDate,
        campaignDateCreated,
        campaignStatus,
        atLab,
        date,
        month,
        year,
        refCode,
        status,
        review,
        rating,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donation_campaign_donor';
  @override
  VerificationContext validateIntegrity(
      Insertable<DonationCampaignDonorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rbtc_id')) {
      context.handle(_rbtcIdMeta,
          rbtcId.isAcceptableOrUnknown(data['rbtc_id']!, _rbtcIdMeta));
    } else if (isInserting) {
      context.missing(_rbtcIdMeta);
    }
    if (data.containsKey('surname')) {
      context.handle(_surnameMeta,
          surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta));
    } else if (isInserting) {
      context.missing(_surnameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age_category')) {
      context.handle(
          _ageCategoryMeta,
          ageCategory.isAcceptableOrUnknown(
              data['age_category']!, _ageCategoryMeta));
    } else if (isInserting) {
      context.missing(_ageCategoryMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('donor_phone_number')) {
      context.handle(
          _donorPhoneNumberMeta,
          donorPhoneNumber.isAcceptableOrUnknown(
              data['donor_phone_number']!, _donorPhoneNumberMeta));
    } else if (isInserting) {
      context.missing(_donorPhoneNumberMeta);
    }
    if (data.containsKey('donor_email')) {
      context.handle(
          _donorEmailMeta,
          donorEmail.isAcceptableOrUnknown(
              data['donor_email']!, _donorEmailMeta));
    } else if (isInserting) {
      context.missing(_donorEmailMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('marital_status')) {
      context.handle(
          _maritalStatusMeta,
          maritalStatus.isAcceptableOrUnknown(
              data['marital_status']!, _maritalStatusMeta));
    } else if (isInserting) {
      context.missing(_maritalStatusMeta);
    }
    if (data.containsKey('occupation')) {
      context.handle(
          _occupationMeta,
          occupation.isAcceptableOrUnknown(
              data['occupation']!, _occupationMeta));
    } else if (isInserting) {
      context.missing(_occupationMeta);
    }
    if (data.containsKey('next_of_kin')) {
      context.handle(
          _nextOfKinMeta,
          nextOfKin.isAcceptableOrUnknown(
              data['next_of_kin']!, _nextOfKinMeta));
    } else if (isInserting) {
      context.missing(_nextOfKinMeta);
    }
    if (data.containsKey('i_next_of_kin')) {
      context.handle(
          _iNextOfKinMeta,
          iNextOfKin.isAcceptableOrUnknown(
              data['i_next_of_kin']!, _iNextOfKinMeta));
    } else if (isInserting) {
      context.missing(_iNextOfKinMeta);
    }
    if (data.containsKey('nok_contact')) {
      context.handle(
          _nokContactMeta,
          nokContact.isAcceptableOrUnknown(
              data['nok_contact']!, _nokContactMeta));
    } else if (isInserting) {
      context.missing(_nokContactMeta);
    }
    if (data.containsKey('pid')) {
      context.handle(
          _pidMeta, pid.isAcceptableOrUnknown(data['pid']!, _pidMeta));
    } else if (isInserting) {
      context.missing(_pidMeta);
    }
    if (data.containsKey('pid_number')) {
      context.handle(_pidNumberMeta,
          pidNumber.isAcceptableOrUnknown(data['pid_number']!, _pidNumberMeta));
    } else if (isInserting) {
      context.missing(_pidNumberMeta);
    }
    if (data.containsKey('vhbv')) {
      context.handle(
          _vhbvMeta, vhbv.isAcceptableOrUnknown(data['vhbv']!, _vhbvMeta));
    } else if (isInserting) {
      context.missing(_vhbvMeta);
    }
    if (data.containsKey('when_hbv')) {
      context.handle(_whenHbvMeta,
          whenHbv.isAcceptableOrUnknown(data['when_hbv']!, _whenHbvMeta));
    } else if (isInserting) {
      context.missing(_whenHbvMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupMeta);
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
          _campaignIdMeta,
          campaignId.isAcceptableOrUnknown(
              data['campaign_id']!, _campaignIdMeta));
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('campaign_name')) {
      context.handle(
          _campaignNameMeta,
          campaignName.isAcceptableOrUnknown(
              data['campaign_name']!, _campaignNameMeta));
    } else if (isInserting) {
      context.missing(_campaignNameMeta);
    }
    if (data.containsKey('campaign_creator')) {
      context.handle(
          _campaignCreatorMeta,
          campaignCreator.isAcceptableOrUnknown(
              data['campaign_creator']!, _campaignCreatorMeta));
    } else if (isInserting) {
      context.missing(_campaignCreatorMeta);
    }
    if (data.containsKey('campaign_description')) {
      context.handle(
          _campaignDescriptionMeta,
          campaignDescription.isAcceptableOrUnknown(
              data['campaign_description']!, _campaignDescriptionMeta));
    } else if (isInserting) {
      context.missing(_campaignDescriptionMeta);
    }
    if (data.containsKey('campaign_contact')) {
      context.handle(
          _campaignContactMeta,
          campaignContact.isAcceptableOrUnknown(
              data['campaign_contact']!, _campaignContactMeta));
    } else if (isInserting) {
      context.missing(_campaignContactMeta);
    }
    if (data.containsKey('campaign_email')) {
      context.handle(
          _campaignEmailMeta,
          campaignEmail.isAcceptableOrUnknown(
              data['campaign_email']!, _campaignEmailMeta));
    } else if (isInserting) {
      context.missing(_campaignEmailMeta);
    }
    if (data.containsKey('facility')) {
      context.handle(_facilityMeta,
          facility.isAcceptableOrUnknown(data['facility']!, _facilityMeta));
    } else if (isInserting) {
      context.missing(_facilityMeta);
    }
    if (data.containsKey('campaign_facility')) {
      context.handle(
          _campaignFacilityMeta,
          campaignFacility.isAcceptableOrUnknown(
              data['campaign_facility']!, _campaignFacilityMeta));
    } else if (isInserting) {
      context.missing(_campaignFacilityMeta);
    }
    if (data.containsKey('campaign_location')) {
      context.handle(
          _campaignLocationMeta,
          campaignLocation.isAcceptableOrUnknown(
              data['campaign_location']!, _campaignLocationMeta));
    } else if (isInserting) {
      context.missing(_campaignLocationMeta);
    }
    if (data.containsKey('campaign_district')) {
      context.handle(
          _campaignDistrictMeta,
          campaignDistrict.isAcceptableOrUnknown(
              data['campaign_district']!, _campaignDistrictMeta));
    } else if (isInserting) {
      context.missing(_campaignDistrictMeta);
    }
    if (data.containsKey('campaign_date')) {
      context.handle(
          _campaignDateMeta,
          campaignDate.isAcceptableOrUnknown(
              data['campaign_date']!, _campaignDateMeta));
    } else if (isInserting) {
      context.missing(_campaignDateMeta);
    }
    if (data.containsKey('campaign_date_created')) {
      context.handle(
          _campaignDateCreatedMeta,
          campaignDateCreated.isAcceptableOrUnknown(
              data['campaign_date_created']!, _campaignDateCreatedMeta));
    } else if (isInserting) {
      context.missing(_campaignDateCreatedMeta);
    }
    if (data.containsKey('campaign_status')) {
      context.handle(
          _campaignStatusMeta,
          campaignStatus.isAcceptableOrUnknown(
              data['campaign_status']!, _campaignStatusMeta));
    } else if (isInserting) {
      context.missing(_campaignStatusMeta);
    }
    if (data.containsKey('at_lab')) {
      context.handle(
          _atLabMeta, atLab.isAcceptableOrUnknown(data['at_lab']!, _atLabMeta));
    } else if (isInserting) {
      context.missing(_atLabMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('ref_code')) {
      context.handle(_refCodeMeta,
          refCode.isAcceptableOrUnknown(data['ref_code']!, _refCodeMeta));
    } else if (isInserting) {
      context.missing(_refCodeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('review')) {
      context.handle(_reviewMeta,
          review.isAcceptableOrUnknown(data['review']!, _reviewMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonationCampaignDonorData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonationCampaignDonorData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rbtcId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rbtc_id'])!,
      surname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}surname'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ageCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age_category'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      donorPhoneNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}donor_phone_number'])!,
      donorEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}donor_email'])!,
      district: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}district'])!,
      maritalStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marital_status'])!,
      occupation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occupation'])!,
      nextOfKin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_of_kin'])!,
      iNextOfKin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}i_next_of_kin'])!,
      nokContact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nok_contact'])!,
      pid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pid'])!,
      pidNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pid_number'])!,
      vhbv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vhbv'])!,
      whenHbv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}when_hbv'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group'])!,
      campaignId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}campaign_id'])!,
      campaignName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campaign_name'])!,
      campaignCreator: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_creator'])!,
      campaignDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_description'])!,
      campaignContact: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_contact'])!,
      campaignEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campaign_email'])!,
      facility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}facility'])!,
      campaignFacility: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_facility'])!,
      campaignLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_location'])!,
      campaignDistrict: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_district'])!,
      campaignDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}campaign_date'])!,
      campaignDateCreated: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}campaign_date_created'])!,
      campaignStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}campaign_status'])!,
      atLab: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}at_lab'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      refCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ref_code'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      review: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DonationCampaignDonorTable createAlias(String alias) {
    return $DonationCampaignDonorTable(attachedDatabase, alias);
  }
}

class DonationCampaignDonorData extends DataClass
    implements Insertable<DonationCampaignDonorData> {
  final int id;
  final int rbtcId;
  final String surname;
  final String name;
  final String ageCategory;
  final String gender;
  final String address;
  final String donorPhoneNumber;
  final String donorEmail;
  final String district;
  final String maritalStatus;
  final String occupation;
  final String nextOfKin;
  final String iNextOfKin;
  final String nokContact;
  final String pid;
  final String pidNumber;
  final String vhbv;
  final String whenHbv;
  final String bloodGroup;
  final int campaignId;
  final String campaignName;
  final String campaignCreator;
  final String campaignDescription;
  final String campaignContact;
  final String campaignEmail;
  final String facility;
  final String campaignFacility;
  final String campaignLocation;
  final String campaignDistrict;
  final int campaignDate;
  final int campaignDateCreated;
  final String campaignStatus;
  final String atLab;
  final int date;
  final int month;
  final int year;
  final String refCode;
  final String status;
  final String? review;
  final double? rating;
  final int createdAt;
  const DonationCampaignDonorData(
      {required this.id,
      required this.rbtcId,
      required this.surname,
      required this.name,
      required this.ageCategory,
      required this.gender,
      required this.address,
      required this.donorPhoneNumber,
      required this.donorEmail,
      required this.district,
      required this.maritalStatus,
      required this.occupation,
      required this.nextOfKin,
      required this.iNextOfKin,
      required this.nokContact,
      required this.pid,
      required this.pidNumber,
      required this.vhbv,
      required this.whenHbv,
      required this.bloodGroup,
      required this.campaignId,
      required this.campaignName,
      required this.campaignCreator,
      required this.campaignDescription,
      required this.campaignContact,
      required this.campaignEmail,
      required this.facility,
      required this.campaignFacility,
      required this.campaignLocation,
      required this.campaignDistrict,
      required this.campaignDate,
      required this.campaignDateCreated,
      required this.campaignStatus,
      required this.atLab,
      required this.date,
      required this.month,
      required this.year,
      required this.refCode,
      required this.status,
      this.review,
      this.rating,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rbtc_id'] = Variable<int>(rbtcId);
    map['surname'] = Variable<String>(surname);
    map['name'] = Variable<String>(name);
    map['age_category'] = Variable<String>(ageCategory);
    map['gender'] = Variable<String>(gender);
    map['address'] = Variable<String>(address);
    map['donor_phone_number'] = Variable<String>(donorPhoneNumber);
    map['donor_email'] = Variable<String>(donorEmail);
    map['district'] = Variable<String>(district);
    map['marital_status'] = Variable<String>(maritalStatus);
    map['occupation'] = Variable<String>(occupation);
    map['next_of_kin'] = Variable<String>(nextOfKin);
    map['i_next_of_kin'] = Variable<String>(iNextOfKin);
    map['nok_contact'] = Variable<String>(nokContact);
    map['pid'] = Variable<String>(pid);
    map['pid_number'] = Variable<String>(pidNumber);
    map['vhbv'] = Variable<String>(vhbv);
    map['when_hbv'] = Variable<String>(whenHbv);
    map['blood_group'] = Variable<String>(bloodGroup);
    map['campaign_id'] = Variable<int>(campaignId);
    map['campaign_name'] = Variable<String>(campaignName);
    map['campaign_creator'] = Variable<String>(campaignCreator);
    map['campaign_description'] = Variable<String>(campaignDescription);
    map['campaign_contact'] = Variable<String>(campaignContact);
    map['campaign_email'] = Variable<String>(campaignEmail);
    map['facility'] = Variable<String>(facility);
    map['campaign_facility'] = Variable<String>(campaignFacility);
    map['campaign_location'] = Variable<String>(campaignLocation);
    map['campaign_district'] = Variable<String>(campaignDistrict);
    map['campaign_date'] = Variable<int>(campaignDate);
    map['campaign_date_created'] = Variable<int>(campaignDateCreated);
    map['campaign_status'] = Variable<String>(campaignStatus);
    map['at_lab'] = Variable<String>(atLab);
    map['date'] = Variable<int>(date);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    map['ref_code'] = Variable<String>(refCode);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || review != null) {
      map['review'] = Variable<String>(review);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  DonationCampaignDonorCompanion toCompanion(bool nullToAbsent) {
    return DonationCampaignDonorCompanion(
      id: Value(id),
      rbtcId: Value(rbtcId),
      surname: Value(surname),
      name: Value(name),
      ageCategory: Value(ageCategory),
      gender: Value(gender),
      address: Value(address),
      donorPhoneNumber: Value(donorPhoneNumber),
      donorEmail: Value(donorEmail),
      district: Value(district),
      maritalStatus: Value(maritalStatus),
      occupation: Value(occupation),
      nextOfKin: Value(nextOfKin),
      iNextOfKin: Value(iNextOfKin),
      nokContact: Value(nokContact),
      pid: Value(pid),
      pidNumber: Value(pidNumber),
      vhbv: Value(vhbv),
      whenHbv: Value(whenHbv),
      bloodGroup: Value(bloodGroup),
      campaignId: Value(campaignId),
      campaignName: Value(campaignName),
      campaignCreator: Value(campaignCreator),
      campaignDescription: Value(campaignDescription),
      campaignContact: Value(campaignContact),
      campaignEmail: Value(campaignEmail),
      facility: Value(facility),
      campaignFacility: Value(campaignFacility),
      campaignLocation: Value(campaignLocation),
      campaignDistrict: Value(campaignDistrict),
      campaignDate: Value(campaignDate),
      campaignDateCreated: Value(campaignDateCreated),
      campaignStatus: Value(campaignStatus),
      atLab: Value(atLab),
      date: Value(date),
      month: Value(month),
      year: Value(year),
      refCode: Value(refCode),
      status: Value(status),
      review:
          review == null && nullToAbsent ? const Value.absent() : Value(review),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      createdAt: Value(createdAt),
    );
  }

  factory DonationCampaignDonorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonationCampaignDonorData(
      id: serializer.fromJson<int>(json['id']),
      rbtcId: serializer.fromJson<int>(json['rbtcId']),
      surname: serializer.fromJson<String>(json['surname']),
      name: serializer.fromJson<String>(json['name']),
      ageCategory: serializer.fromJson<String>(json['ageCategory']),
      gender: serializer.fromJson<String>(json['gender']),
      address: serializer.fromJson<String>(json['address']),
      donorPhoneNumber: serializer.fromJson<String>(json['donorPhoneNumber']),
      donorEmail: serializer.fromJson<String>(json['donorEmail']),
      district: serializer.fromJson<String>(json['district']),
      maritalStatus: serializer.fromJson<String>(json['maritalStatus']),
      occupation: serializer.fromJson<String>(json['occupation']),
      nextOfKin: serializer.fromJson<String>(json['nextOfKin']),
      iNextOfKin: serializer.fromJson<String>(json['iNextOfKin']),
      nokContact: serializer.fromJson<String>(json['nokContact']),
      pid: serializer.fromJson<String>(json['pid']),
      pidNumber: serializer.fromJson<String>(json['pidNumber']),
      vhbv: serializer.fromJson<String>(json['vhbv']),
      whenHbv: serializer.fromJson<String>(json['whenHbv']),
      bloodGroup: serializer.fromJson<String>(json['bloodGroup']),
      campaignId: serializer.fromJson<int>(json['campaignId']),
      campaignName: serializer.fromJson<String>(json['campaignName']),
      campaignCreator: serializer.fromJson<String>(json['campaignCreator']),
      campaignDescription:
          serializer.fromJson<String>(json['campaignDescription']),
      campaignContact: serializer.fromJson<String>(json['campaignContact']),
      campaignEmail: serializer.fromJson<String>(json['campaignEmail']),
      facility: serializer.fromJson<String>(json['facility']),
      campaignFacility: serializer.fromJson<String>(json['campaignFacility']),
      campaignLocation: serializer.fromJson<String>(json['campaignLocation']),
      campaignDistrict: serializer.fromJson<String>(json['campaignDistrict']),
      campaignDate: serializer.fromJson<int>(json['campaignDate']),
      campaignDateCreated:
          serializer.fromJson<int>(json['campaignDateCreated']),
      campaignStatus: serializer.fromJson<String>(json['campaignStatus']),
      atLab: serializer.fromJson<String>(json['atLab']),
      date: serializer.fromJson<int>(json['date']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      refCode: serializer.fromJson<String>(json['refCode']),
      status: serializer.fromJson<String>(json['status']),
      review: serializer.fromJson<String?>(json['review']),
      rating: serializer.fromJson<double?>(json['rating']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rbtcId': serializer.toJson<int>(rbtcId),
      'surname': serializer.toJson<String>(surname),
      'name': serializer.toJson<String>(name),
      'ageCategory': serializer.toJson<String>(ageCategory),
      'gender': serializer.toJson<String>(gender),
      'address': serializer.toJson<String>(address),
      'donorPhoneNumber': serializer.toJson<String>(donorPhoneNumber),
      'donorEmail': serializer.toJson<String>(donorEmail),
      'district': serializer.toJson<String>(district),
      'maritalStatus': serializer.toJson<String>(maritalStatus),
      'occupation': serializer.toJson<String>(occupation),
      'nextOfKin': serializer.toJson<String>(nextOfKin),
      'iNextOfKin': serializer.toJson<String>(iNextOfKin),
      'nokContact': serializer.toJson<String>(nokContact),
      'pid': serializer.toJson<String>(pid),
      'pidNumber': serializer.toJson<String>(pidNumber),
      'vhbv': serializer.toJson<String>(vhbv),
      'whenHbv': serializer.toJson<String>(whenHbv),
      'bloodGroup': serializer.toJson<String>(bloodGroup),
      'campaignId': serializer.toJson<int>(campaignId),
      'campaignName': serializer.toJson<String>(campaignName),
      'campaignCreator': serializer.toJson<String>(campaignCreator),
      'campaignDescription': serializer.toJson<String>(campaignDescription),
      'campaignContact': serializer.toJson<String>(campaignContact),
      'campaignEmail': serializer.toJson<String>(campaignEmail),
      'facility': serializer.toJson<String>(facility),
      'campaignFacility': serializer.toJson<String>(campaignFacility),
      'campaignLocation': serializer.toJson<String>(campaignLocation),
      'campaignDistrict': serializer.toJson<String>(campaignDistrict),
      'campaignDate': serializer.toJson<int>(campaignDate),
      'campaignDateCreated': serializer.toJson<int>(campaignDateCreated),
      'campaignStatus': serializer.toJson<String>(campaignStatus),
      'atLab': serializer.toJson<String>(atLab),
      'date': serializer.toJson<int>(date),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'refCode': serializer.toJson<String>(refCode),
      'status': serializer.toJson<String>(status),
      'review': serializer.toJson<String?>(review),
      'rating': serializer.toJson<double?>(rating),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  DonationCampaignDonorData copyWith(
          {int? id,
          int? rbtcId,
          String? surname,
          String? name,
          String? ageCategory,
          String? gender,
          String? address,
          String? donorPhoneNumber,
          String? donorEmail,
          String? district,
          String? maritalStatus,
          String? occupation,
          String? nextOfKin,
          String? iNextOfKin,
          String? nokContact,
          String? pid,
          String? pidNumber,
          String? vhbv,
          String? whenHbv,
          String? bloodGroup,
          int? campaignId,
          String? campaignName,
          String? campaignCreator,
          String? campaignDescription,
          String? campaignContact,
          String? campaignEmail,
          String? facility,
          String? campaignFacility,
          String? campaignLocation,
          String? campaignDistrict,
          int? campaignDate,
          int? campaignDateCreated,
          String? campaignStatus,
          String? atLab,
          int? date,
          int? month,
          int? year,
          String? refCode,
          String? status,
          Value<String?> review = const Value.absent(),
          Value<double?> rating = const Value.absent(),
          int? createdAt}) =>
      DonationCampaignDonorData(
        id: id ?? this.id,
        rbtcId: rbtcId ?? this.rbtcId,
        surname: surname ?? this.surname,
        name: name ?? this.name,
        ageCategory: ageCategory ?? this.ageCategory,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        donorPhoneNumber: donorPhoneNumber ?? this.donorPhoneNumber,
        donorEmail: donorEmail ?? this.donorEmail,
        district: district ?? this.district,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        occupation: occupation ?? this.occupation,
        nextOfKin: nextOfKin ?? this.nextOfKin,
        iNextOfKin: iNextOfKin ?? this.iNextOfKin,
        nokContact: nokContact ?? this.nokContact,
        pid: pid ?? this.pid,
        pidNumber: pidNumber ?? this.pidNumber,
        vhbv: vhbv ?? this.vhbv,
        whenHbv: whenHbv ?? this.whenHbv,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        campaignId: campaignId ?? this.campaignId,
        campaignName: campaignName ?? this.campaignName,
        campaignCreator: campaignCreator ?? this.campaignCreator,
        campaignDescription: campaignDescription ?? this.campaignDescription,
        campaignContact: campaignContact ?? this.campaignContact,
        campaignEmail: campaignEmail ?? this.campaignEmail,
        facility: facility ?? this.facility,
        campaignFacility: campaignFacility ?? this.campaignFacility,
        campaignLocation: campaignLocation ?? this.campaignLocation,
        campaignDistrict: campaignDistrict ?? this.campaignDistrict,
        campaignDate: campaignDate ?? this.campaignDate,
        campaignDateCreated: campaignDateCreated ?? this.campaignDateCreated,
        campaignStatus: campaignStatus ?? this.campaignStatus,
        atLab: atLab ?? this.atLab,
        date: date ?? this.date,
        month: month ?? this.month,
        year: year ?? this.year,
        refCode: refCode ?? this.refCode,
        status: status ?? this.status,
        review: review.present ? review.value : this.review,
        rating: rating.present ? rating.value : this.rating,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('DonationCampaignDonorData(')
          ..write('id: $id, ')
          ..write('rbtcId: $rbtcId, ')
          ..write('surname: $surname, ')
          ..write('name: $name, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('donorPhoneNumber: $donorPhoneNumber, ')
          ..write('donorEmail: $donorEmail, ')
          ..write('district: $district, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('occupation: $occupation, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('iNextOfKin: $iNextOfKin, ')
          ..write('nokContact: $nokContact, ')
          ..write('pid: $pid, ')
          ..write('pidNumber: $pidNumber, ')
          ..write('vhbv: $vhbv, ')
          ..write('whenHbv: $whenHbv, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('campaignId: $campaignId, ')
          ..write('campaignName: $campaignName, ')
          ..write('campaignCreator: $campaignCreator, ')
          ..write('campaignDescription: $campaignDescription, ')
          ..write('campaignContact: $campaignContact, ')
          ..write('campaignEmail: $campaignEmail, ')
          ..write('facility: $facility, ')
          ..write('campaignFacility: $campaignFacility, ')
          ..write('campaignLocation: $campaignLocation, ')
          ..write('campaignDistrict: $campaignDistrict, ')
          ..write('campaignDate: $campaignDate, ')
          ..write('campaignDateCreated: $campaignDateCreated, ')
          ..write('campaignStatus: $campaignStatus, ')
          ..write('atLab: $atLab, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('review: $review, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        rbtcId,
        surname,
        name,
        ageCategory,
        gender,
        address,
        donorPhoneNumber,
        donorEmail,
        district,
        maritalStatus,
        occupation,
        nextOfKin,
        iNextOfKin,
        nokContact,
        pid,
        pidNumber,
        vhbv,
        whenHbv,
        bloodGroup,
        campaignId,
        campaignName,
        campaignCreator,
        campaignDescription,
        campaignContact,
        campaignEmail,
        facility,
        campaignFacility,
        campaignLocation,
        campaignDistrict,
        campaignDate,
        campaignDateCreated,
        campaignStatus,
        atLab,
        date,
        month,
        year,
        refCode,
        status,
        review,
        rating,
        createdAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonationCampaignDonorData &&
          other.id == this.id &&
          other.rbtcId == this.rbtcId &&
          other.surname == this.surname &&
          other.name == this.name &&
          other.ageCategory == this.ageCategory &&
          other.gender == this.gender &&
          other.address == this.address &&
          other.donorPhoneNumber == this.donorPhoneNumber &&
          other.donorEmail == this.donorEmail &&
          other.district == this.district &&
          other.maritalStatus == this.maritalStatus &&
          other.occupation == this.occupation &&
          other.nextOfKin == this.nextOfKin &&
          other.iNextOfKin == this.iNextOfKin &&
          other.nokContact == this.nokContact &&
          other.pid == this.pid &&
          other.pidNumber == this.pidNumber &&
          other.vhbv == this.vhbv &&
          other.whenHbv == this.whenHbv &&
          other.bloodGroup == this.bloodGroup &&
          other.campaignId == this.campaignId &&
          other.campaignName == this.campaignName &&
          other.campaignCreator == this.campaignCreator &&
          other.campaignDescription == this.campaignDescription &&
          other.campaignContact == this.campaignContact &&
          other.campaignEmail == this.campaignEmail &&
          other.facility == this.facility &&
          other.campaignFacility == this.campaignFacility &&
          other.campaignLocation == this.campaignLocation &&
          other.campaignDistrict == this.campaignDistrict &&
          other.campaignDate == this.campaignDate &&
          other.campaignDateCreated == this.campaignDateCreated &&
          other.campaignStatus == this.campaignStatus &&
          other.atLab == this.atLab &&
          other.date == this.date &&
          other.month == this.month &&
          other.year == this.year &&
          other.refCode == this.refCode &&
          other.status == this.status &&
          other.review == this.review &&
          other.rating == this.rating &&
          other.createdAt == this.createdAt);
}

class DonationCampaignDonorCompanion
    extends UpdateCompanion<DonationCampaignDonorData> {
  final Value<int> id;
  final Value<int> rbtcId;
  final Value<String> surname;
  final Value<String> name;
  final Value<String> ageCategory;
  final Value<String> gender;
  final Value<String> address;
  final Value<String> donorPhoneNumber;
  final Value<String> donorEmail;
  final Value<String> district;
  final Value<String> maritalStatus;
  final Value<String> occupation;
  final Value<String> nextOfKin;
  final Value<String> iNextOfKin;
  final Value<String> nokContact;
  final Value<String> pid;
  final Value<String> pidNumber;
  final Value<String> vhbv;
  final Value<String> whenHbv;
  final Value<String> bloodGroup;
  final Value<int> campaignId;
  final Value<String> campaignName;
  final Value<String> campaignCreator;
  final Value<String> campaignDescription;
  final Value<String> campaignContact;
  final Value<String> campaignEmail;
  final Value<String> facility;
  final Value<String> campaignFacility;
  final Value<String> campaignLocation;
  final Value<String> campaignDistrict;
  final Value<int> campaignDate;
  final Value<int> campaignDateCreated;
  final Value<String> campaignStatus;
  final Value<String> atLab;
  final Value<int> date;
  final Value<int> month;
  final Value<int> year;
  final Value<String> refCode;
  final Value<String> status;
  final Value<String?> review;
  final Value<double?> rating;
  final Value<int> createdAt;
  const DonationCampaignDonorCompanion({
    this.id = const Value.absent(),
    this.rbtcId = const Value.absent(),
    this.surname = const Value.absent(),
    this.name = const Value.absent(),
    this.ageCategory = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.donorPhoneNumber = const Value.absent(),
    this.donorEmail = const Value.absent(),
    this.district = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.occupation = const Value.absent(),
    this.nextOfKin = const Value.absent(),
    this.iNextOfKin = const Value.absent(),
    this.nokContact = const Value.absent(),
    this.pid = const Value.absent(),
    this.pidNumber = const Value.absent(),
    this.vhbv = const Value.absent(),
    this.whenHbv = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.campaignName = const Value.absent(),
    this.campaignCreator = const Value.absent(),
    this.campaignDescription = const Value.absent(),
    this.campaignContact = const Value.absent(),
    this.campaignEmail = const Value.absent(),
    this.facility = const Value.absent(),
    this.campaignFacility = const Value.absent(),
    this.campaignLocation = const Value.absent(),
    this.campaignDistrict = const Value.absent(),
    this.campaignDate = const Value.absent(),
    this.campaignDateCreated = const Value.absent(),
    this.campaignStatus = const Value.absent(),
    this.atLab = const Value.absent(),
    this.date = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.refCode = const Value.absent(),
    this.status = const Value.absent(),
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DonationCampaignDonorCompanion.insert({
    this.id = const Value.absent(),
    required int rbtcId,
    required String surname,
    required String name,
    required String ageCategory,
    required String gender,
    required String address,
    required String donorPhoneNumber,
    required String donorEmail,
    required String district,
    required String maritalStatus,
    required String occupation,
    required String nextOfKin,
    required String iNextOfKin,
    required String nokContact,
    required String pid,
    required String pidNumber,
    required String vhbv,
    required String whenHbv,
    required String bloodGroup,
    required int campaignId,
    required String campaignName,
    required String campaignCreator,
    required String campaignDescription,
    required String campaignContact,
    required String campaignEmail,
    required String facility,
    required String campaignFacility,
    required String campaignLocation,
    required String campaignDistrict,
    required int campaignDate,
    required int campaignDateCreated,
    required String campaignStatus,
    required String atLab,
    required int date,
    required int month,
    required int year,
    required String refCode,
    required String status,
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
    required int createdAt,
  })  : rbtcId = Value(rbtcId),
        surname = Value(surname),
        name = Value(name),
        ageCategory = Value(ageCategory),
        gender = Value(gender),
        address = Value(address),
        donorPhoneNumber = Value(donorPhoneNumber),
        donorEmail = Value(donorEmail),
        district = Value(district),
        maritalStatus = Value(maritalStatus),
        occupation = Value(occupation),
        nextOfKin = Value(nextOfKin),
        iNextOfKin = Value(iNextOfKin),
        nokContact = Value(nokContact),
        pid = Value(pid),
        pidNumber = Value(pidNumber),
        vhbv = Value(vhbv),
        whenHbv = Value(whenHbv),
        bloodGroup = Value(bloodGroup),
        campaignId = Value(campaignId),
        campaignName = Value(campaignName),
        campaignCreator = Value(campaignCreator),
        campaignDescription = Value(campaignDescription),
        campaignContact = Value(campaignContact),
        campaignEmail = Value(campaignEmail),
        facility = Value(facility),
        campaignFacility = Value(campaignFacility),
        campaignLocation = Value(campaignLocation),
        campaignDistrict = Value(campaignDistrict),
        campaignDate = Value(campaignDate),
        campaignDateCreated = Value(campaignDateCreated),
        campaignStatus = Value(campaignStatus),
        atLab = Value(atLab),
        date = Value(date),
        month = Value(month),
        year = Value(year),
        refCode = Value(refCode),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<DonationCampaignDonorData> custom({
    Expression<int>? id,
    Expression<int>? rbtcId,
    Expression<String>? surname,
    Expression<String>? name,
    Expression<String>? ageCategory,
    Expression<String>? gender,
    Expression<String>? address,
    Expression<String>? donorPhoneNumber,
    Expression<String>? donorEmail,
    Expression<String>? district,
    Expression<String>? maritalStatus,
    Expression<String>? occupation,
    Expression<String>? nextOfKin,
    Expression<String>? iNextOfKin,
    Expression<String>? nokContact,
    Expression<String>? pid,
    Expression<String>? pidNumber,
    Expression<String>? vhbv,
    Expression<String>? whenHbv,
    Expression<String>? bloodGroup,
    Expression<int>? campaignId,
    Expression<String>? campaignName,
    Expression<String>? campaignCreator,
    Expression<String>? campaignDescription,
    Expression<String>? campaignContact,
    Expression<String>? campaignEmail,
    Expression<String>? facility,
    Expression<String>? campaignFacility,
    Expression<String>? campaignLocation,
    Expression<String>? campaignDistrict,
    Expression<int>? campaignDate,
    Expression<int>? campaignDateCreated,
    Expression<String>? campaignStatus,
    Expression<String>? atLab,
    Expression<int>? date,
    Expression<int>? month,
    Expression<int>? year,
    Expression<String>? refCode,
    Expression<String>? status,
    Expression<String>? review,
    Expression<double>? rating,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rbtcId != null) 'rbtc_id': rbtcId,
      if (surname != null) 'surname': surname,
      if (name != null) 'name': name,
      if (ageCategory != null) 'age_category': ageCategory,
      if (gender != null) 'gender': gender,
      if (address != null) 'address': address,
      if (donorPhoneNumber != null) 'donor_phone_number': donorPhoneNumber,
      if (donorEmail != null) 'donor_email': donorEmail,
      if (district != null) 'district': district,
      if (maritalStatus != null) 'marital_status': maritalStatus,
      if (occupation != null) 'occupation': occupation,
      if (nextOfKin != null) 'next_of_kin': nextOfKin,
      if (iNextOfKin != null) 'i_next_of_kin': iNextOfKin,
      if (nokContact != null) 'nok_contact': nokContact,
      if (pid != null) 'pid': pid,
      if (pidNumber != null) 'pid_number': pidNumber,
      if (vhbv != null) 'vhbv': vhbv,
      if (whenHbv != null) 'when_hbv': whenHbv,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (campaignId != null) 'campaign_id': campaignId,
      if (campaignName != null) 'campaign_name': campaignName,
      if (campaignCreator != null) 'campaign_creator': campaignCreator,
      if (campaignDescription != null)
        'campaign_description': campaignDescription,
      if (campaignContact != null) 'campaign_contact': campaignContact,
      if (campaignEmail != null) 'campaign_email': campaignEmail,
      if (facility != null) 'facility': facility,
      if (campaignFacility != null) 'campaign_facility': campaignFacility,
      if (campaignLocation != null) 'campaign_location': campaignLocation,
      if (campaignDistrict != null) 'campaign_district': campaignDistrict,
      if (campaignDate != null) 'campaign_date': campaignDate,
      if (campaignDateCreated != null)
        'campaign_date_created': campaignDateCreated,
      if (campaignStatus != null) 'campaign_status': campaignStatus,
      if (atLab != null) 'at_lab': atLab,
      if (date != null) 'date': date,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (refCode != null) 'ref_code': refCode,
      if (status != null) 'status': status,
      if (review != null) 'review': review,
      if (rating != null) 'rating': rating,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DonationCampaignDonorCompanion copyWith(
      {Value<int>? id,
      Value<int>? rbtcId,
      Value<String>? surname,
      Value<String>? name,
      Value<String>? ageCategory,
      Value<String>? gender,
      Value<String>? address,
      Value<String>? donorPhoneNumber,
      Value<String>? donorEmail,
      Value<String>? district,
      Value<String>? maritalStatus,
      Value<String>? occupation,
      Value<String>? nextOfKin,
      Value<String>? iNextOfKin,
      Value<String>? nokContact,
      Value<String>? pid,
      Value<String>? pidNumber,
      Value<String>? vhbv,
      Value<String>? whenHbv,
      Value<String>? bloodGroup,
      Value<int>? campaignId,
      Value<String>? campaignName,
      Value<String>? campaignCreator,
      Value<String>? campaignDescription,
      Value<String>? campaignContact,
      Value<String>? campaignEmail,
      Value<String>? facility,
      Value<String>? campaignFacility,
      Value<String>? campaignLocation,
      Value<String>? campaignDistrict,
      Value<int>? campaignDate,
      Value<int>? campaignDateCreated,
      Value<String>? campaignStatus,
      Value<String>? atLab,
      Value<int>? date,
      Value<int>? month,
      Value<int>? year,
      Value<String>? refCode,
      Value<String>? status,
      Value<String?>? review,
      Value<double?>? rating,
      Value<int>? createdAt}) {
    return DonationCampaignDonorCompanion(
      id: id ?? this.id,
      rbtcId: rbtcId ?? this.rbtcId,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      ageCategory: ageCategory ?? this.ageCategory,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      donorPhoneNumber: donorPhoneNumber ?? this.donorPhoneNumber,
      donorEmail: donorEmail ?? this.donorEmail,
      district: district ?? this.district,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      occupation: occupation ?? this.occupation,
      nextOfKin: nextOfKin ?? this.nextOfKin,
      iNextOfKin: iNextOfKin ?? this.iNextOfKin,
      nokContact: nokContact ?? this.nokContact,
      pid: pid ?? this.pid,
      pidNumber: pidNumber ?? this.pidNumber,
      vhbv: vhbv ?? this.vhbv,
      whenHbv: whenHbv ?? this.whenHbv,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      campaignId: campaignId ?? this.campaignId,
      campaignName: campaignName ?? this.campaignName,
      campaignCreator: campaignCreator ?? this.campaignCreator,
      campaignDescription: campaignDescription ?? this.campaignDescription,
      campaignContact: campaignContact ?? this.campaignContact,
      campaignEmail: campaignEmail ?? this.campaignEmail,
      facility: facility ?? this.facility,
      campaignFacility: campaignFacility ?? this.campaignFacility,
      campaignLocation: campaignLocation ?? this.campaignLocation,
      campaignDistrict: campaignDistrict ?? this.campaignDistrict,
      campaignDate: campaignDate ?? this.campaignDate,
      campaignDateCreated: campaignDateCreated ?? this.campaignDateCreated,
      campaignStatus: campaignStatus ?? this.campaignStatus,
      atLab: atLab ?? this.atLab,
      date: date ?? this.date,
      month: month ?? this.month,
      year: year ?? this.year,
      refCode: refCode ?? this.refCode,
      status: status ?? this.status,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rbtcId.present) {
      map['rbtc_id'] = Variable<int>(rbtcId.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ageCategory.present) {
      map['age_category'] = Variable<String>(ageCategory.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (donorPhoneNumber.present) {
      map['donor_phone_number'] = Variable<String>(donorPhoneNumber.value);
    }
    if (donorEmail.present) {
      map['donor_email'] = Variable<String>(donorEmail.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (maritalStatus.present) {
      map['marital_status'] = Variable<String>(maritalStatus.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    if (nextOfKin.present) {
      map['next_of_kin'] = Variable<String>(nextOfKin.value);
    }
    if (iNextOfKin.present) {
      map['i_next_of_kin'] = Variable<String>(iNextOfKin.value);
    }
    if (nokContact.present) {
      map['nok_contact'] = Variable<String>(nokContact.value);
    }
    if (pid.present) {
      map['pid'] = Variable<String>(pid.value);
    }
    if (pidNumber.present) {
      map['pid_number'] = Variable<String>(pidNumber.value);
    }
    if (vhbv.present) {
      map['vhbv'] = Variable<String>(vhbv.value);
    }
    if (whenHbv.present) {
      map['when_hbv'] = Variable<String>(whenHbv.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<int>(campaignId.value);
    }
    if (campaignName.present) {
      map['campaign_name'] = Variable<String>(campaignName.value);
    }
    if (campaignCreator.present) {
      map['campaign_creator'] = Variable<String>(campaignCreator.value);
    }
    if (campaignDescription.present) {
      map['campaign_description'] = Variable<String>(campaignDescription.value);
    }
    if (campaignContact.present) {
      map['campaign_contact'] = Variable<String>(campaignContact.value);
    }
    if (campaignEmail.present) {
      map['campaign_email'] = Variable<String>(campaignEmail.value);
    }
    if (facility.present) {
      map['facility'] = Variable<String>(facility.value);
    }
    if (campaignFacility.present) {
      map['campaign_facility'] = Variable<String>(campaignFacility.value);
    }
    if (campaignLocation.present) {
      map['campaign_location'] = Variable<String>(campaignLocation.value);
    }
    if (campaignDistrict.present) {
      map['campaign_district'] = Variable<String>(campaignDistrict.value);
    }
    if (campaignDate.present) {
      map['campaign_date'] = Variable<int>(campaignDate.value);
    }
    if (campaignDateCreated.present) {
      map['campaign_date_created'] = Variable<int>(campaignDateCreated.value);
    }
    if (campaignStatus.present) {
      map['campaign_status'] = Variable<String>(campaignStatus.value);
    }
    if (atLab.present) {
      map['at_lab'] = Variable<String>(atLab.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (refCode.present) {
      map['ref_code'] = Variable<String>(refCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (review.present) {
      map['review'] = Variable<String>(review.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonationCampaignDonorCompanion(')
          ..write('id: $id, ')
          ..write('rbtcId: $rbtcId, ')
          ..write('surname: $surname, ')
          ..write('name: $name, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('donorPhoneNumber: $donorPhoneNumber, ')
          ..write('donorEmail: $donorEmail, ')
          ..write('district: $district, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('occupation: $occupation, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('iNextOfKin: $iNextOfKin, ')
          ..write('nokContact: $nokContact, ')
          ..write('pid: $pid, ')
          ..write('pidNumber: $pidNumber, ')
          ..write('vhbv: $vhbv, ')
          ..write('whenHbv: $whenHbv, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('campaignId: $campaignId, ')
          ..write('campaignName: $campaignName, ')
          ..write('campaignCreator: $campaignCreator, ')
          ..write('campaignDescription: $campaignDescription, ')
          ..write('campaignContact: $campaignContact, ')
          ..write('campaignEmail: $campaignEmail, ')
          ..write('facility: $facility, ')
          ..write('campaignFacility: $campaignFacility, ')
          ..write('campaignLocation: $campaignLocation, ')
          ..write('campaignDistrict: $campaignDistrict, ')
          ..write('campaignDate: $campaignDate, ')
          ..write('campaignDateCreated: $campaignDateCreated, ')
          ..write('campaignStatus: $campaignStatus, ')
          ..write('atLab: $atLab, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('review: $review, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BloodTestScheduleTable extends BloodTestSchedule
    with TableInfo<$BloodTestScheduleTable, BloodTestScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodTestScheduleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bloodTestForMeta =
      const VerificationMeta('bloodTestFor');
  @override
  late final GeneratedColumn<String> bloodTestFor = GeneratedColumn<String>(
      'blood_test_for', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _middleNameMeta =
      const VerificationMeta('middleName');
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
      'middle_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageCategoryMeta =
      const VerificationMeta('ageCategory');
  @override
  late final GeneratedColumn<String> ageCategory = GeneratedColumn<String>(
      'age_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schedulerPhoneNumberMeta =
      const VerificationMeta('schedulerPhoneNumber');
  @override
  late final GeneratedColumn<String> schedulerPhoneNumber =
      GeneratedColumn<String>('scheduler_phone_number', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _facilityMeta =
      const VerificationMeta('facility');
  @override
  late final GeneratedColumn<String> facility = GeneratedColumn<String>(
      'facility', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeSlotMeta =
      const VerificationMeta('timeSlot');
  @override
  late final GeneratedColumn<String> timeSlot = GeneratedColumn<String>(
      'time_slot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refCodeMeta =
      const VerificationMeta('refCode');
  @override
  late final GeneratedColumn<String> refCode = GeneratedColumn<String>(
      'ref_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
      'result', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _onSiteMeta = const VerificationMeta('onSite');
  @override
  late final GeneratedColumn<bool> onSite = GeneratedColumn<bool>(
      'on_site', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("on_site" IN (0, 1))'));
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rhMeta = const VerificationMeta('rh');
  @override
  late final GeneratedColumn<String> rh = GeneratedColumn<String>(
      'rh', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupRhMeta =
      const VerificationMeta('bloodGroupRh');
  @override
  late final GeneratedColumn<String> bloodGroupRh = GeneratedColumn<String>(
      'blood_group_rh', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phenotypeMeta =
      const VerificationMeta('phenotype');
  @override
  late final GeneratedColumn<String> phenotype = GeneratedColumn<String>(
      'phenotype', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kellMeta = const VerificationMeta('kell');
  @override
  late final GeneratedColumn<String> kell = GeneratedColumn<String>(
      'kell', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewMeta = const VerificationMeta('review');
  @override
  late final GeneratedColumn<String> review = GeneratedColumn<String>(
      'review', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bloodTestFor,
        firstName,
        middleName,
        lastName,
        ageCategory,
        gender,
        phoneNumber,
        email,
        schedulerPhoneNumber,
        address,
        facility,
        date,
        month,
        year,
        timeSlot,
        refCode,
        status,
        result,
        onSite,
        bloodGroup,
        rh,
        bloodGroupRh,
        phenotype,
        kell,
        review,
        rating
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_test_schedule';
  @override
  VerificationContext validateIntegrity(
      Insertable<BloodTestScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('blood_test_for')) {
      context.handle(
          _bloodTestForMeta,
          bloodTestFor.isAcceptableOrUnknown(
              data['blood_test_for']!, _bloodTestForMeta));
    } else if (isInserting) {
      context.missing(_bloodTestForMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
          _middleNameMeta,
          middleName.isAcceptableOrUnknown(
              data['middle_name']!, _middleNameMeta));
    } else if (isInserting) {
      context.missing(_middleNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('age_category')) {
      context.handle(
          _ageCategoryMeta,
          ageCategory.isAcceptableOrUnknown(
              data['age_category']!, _ageCategoryMeta));
    } else if (isInserting) {
      context.missing(_ageCategoryMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('scheduler_phone_number')) {
      context.handle(
          _schedulerPhoneNumberMeta,
          schedulerPhoneNumber.isAcceptableOrUnknown(
              data['scheduler_phone_number']!, _schedulerPhoneNumberMeta));
    } else if (isInserting) {
      context.missing(_schedulerPhoneNumberMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('facility')) {
      context.handle(_facilityMeta,
          facility.isAcceptableOrUnknown(data['facility']!, _facilityMeta));
    } else if (isInserting) {
      context.missing(_facilityMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('time_slot')) {
      context.handle(_timeSlotMeta,
          timeSlot.isAcceptableOrUnknown(data['time_slot']!, _timeSlotMeta));
    } else if (isInserting) {
      context.missing(_timeSlotMeta);
    }
    if (data.containsKey('ref_code')) {
      context.handle(_refCodeMeta,
          refCode.isAcceptableOrUnknown(data['ref_code']!, _refCodeMeta));
    } else if (isInserting) {
      context.missing(_refCodeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('result')) {
      context.handle(_resultMeta,
          result.isAcceptableOrUnknown(data['result']!, _resultMeta));
    }
    if (data.containsKey('on_site')) {
      context.handle(_onSiteMeta,
          onSite.isAcceptableOrUnknown(data['on_site']!, _onSiteMeta));
    } else if (isInserting) {
      context.missing(_onSiteMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupMeta);
    }
    if (data.containsKey('rh')) {
      context.handle(_rhMeta, rh.isAcceptableOrUnknown(data['rh']!, _rhMeta));
    } else if (isInserting) {
      context.missing(_rhMeta);
    }
    if (data.containsKey('blood_group_rh')) {
      context.handle(
          _bloodGroupRhMeta,
          bloodGroupRh.isAcceptableOrUnknown(
              data['blood_group_rh']!, _bloodGroupRhMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupRhMeta);
    }
    if (data.containsKey('phenotype')) {
      context.handle(_phenotypeMeta,
          phenotype.isAcceptableOrUnknown(data['phenotype']!, _phenotypeMeta));
    } else if (isInserting) {
      context.missing(_phenotypeMeta);
    }
    if (data.containsKey('kell')) {
      context.handle(
          _kellMeta, kell.isAcceptableOrUnknown(data['kell']!, _kellMeta));
    } else if (isInserting) {
      context.missing(_kellMeta);
    }
    if (data.containsKey('review')) {
      context.handle(_reviewMeta,
          review.isAcceptableOrUnknown(data['review']!, _reviewMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodTestScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodTestScheduleData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bloodTestFor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_test_for'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      middleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}middle_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      ageCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age_category'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      schedulerPhoneNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scheduler_phone_number'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      facility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}facility'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      timeSlot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_slot'])!,
      refCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ref_code'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      result: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result']),
      onSite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}on_site'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group'])!,
      rh: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rh'])!,
      bloodGroupRh: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group_rh'])!,
      phenotype: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phenotype'])!,
      kell: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kell'])!,
      review: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
    );
  }

  @override
  $BloodTestScheduleTable createAlias(String alias) {
    return $BloodTestScheduleTable(attachedDatabase, alias);
  }
}

class BloodTestScheduleData extends DataClass
    implements Insertable<BloodTestScheduleData> {
  final int id;
  final String bloodTestFor;
  final String firstName;
  final String middleName;
  final String lastName;
  final String ageCategory;
  final String gender;
  final String phoneNumber;
  final String email;
  final String schedulerPhoneNumber;
  final String address;
  final String facility;
  final int date;
  final int month;
  final int year;
  final String timeSlot;
  final String refCode;
  final String status;
  final String? result;
  final bool onSite;
  final String bloodGroup;
  final String rh;
  final String bloodGroupRh;
  final String phenotype;
  final String kell;
  final String? review;
  final double? rating;
  const BloodTestScheduleData(
      {required this.id,
      required this.bloodTestFor,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.ageCategory,
      required this.gender,
      required this.phoneNumber,
      required this.email,
      required this.schedulerPhoneNumber,
      required this.address,
      required this.facility,
      required this.date,
      required this.month,
      required this.year,
      required this.timeSlot,
      required this.refCode,
      required this.status,
      this.result,
      required this.onSite,
      required this.bloodGroup,
      required this.rh,
      required this.bloodGroupRh,
      required this.phenotype,
      required this.kell,
      this.review,
      this.rating});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['blood_test_for'] = Variable<String>(bloodTestFor);
    map['first_name'] = Variable<String>(firstName);
    map['middle_name'] = Variable<String>(middleName);
    map['last_name'] = Variable<String>(lastName);
    map['age_category'] = Variable<String>(ageCategory);
    map['gender'] = Variable<String>(gender);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['email'] = Variable<String>(email);
    map['scheduler_phone_number'] = Variable<String>(schedulerPhoneNumber);
    map['address'] = Variable<String>(address);
    map['facility'] = Variable<String>(facility);
    map['date'] = Variable<int>(date);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    map['time_slot'] = Variable<String>(timeSlot);
    map['ref_code'] = Variable<String>(refCode);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    map['on_site'] = Variable<bool>(onSite);
    map['blood_group'] = Variable<String>(bloodGroup);
    map['rh'] = Variable<String>(rh);
    map['blood_group_rh'] = Variable<String>(bloodGroupRh);
    map['phenotype'] = Variable<String>(phenotype);
    map['kell'] = Variable<String>(kell);
    if (!nullToAbsent || review != null) {
      map['review'] = Variable<String>(review);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    return map;
  }

  BloodTestScheduleCompanion toCompanion(bool nullToAbsent) {
    return BloodTestScheduleCompanion(
      id: Value(id),
      bloodTestFor: Value(bloodTestFor),
      firstName: Value(firstName),
      middleName: Value(middleName),
      lastName: Value(lastName),
      ageCategory: Value(ageCategory),
      gender: Value(gender),
      phoneNumber: Value(phoneNumber),
      email: Value(email),
      schedulerPhoneNumber: Value(schedulerPhoneNumber),
      address: Value(address),
      facility: Value(facility),
      date: Value(date),
      month: Value(month),
      year: Value(year),
      timeSlot: Value(timeSlot),
      refCode: Value(refCode),
      status: Value(status),
      result:
          result == null && nullToAbsent ? const Value.absent() : Value(result),
      onSite: Value(onSite),
      bloodGroup: Value(bloodGroup),
      rh: Value(rh),
      bloodGroupRh: Value(bloodGroupRh),
      phenotype: Value(phenotype),
      kell: Value(kell),
      review:
          review == null && nullToAbsent ? const Value.absent() : Value(review),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
    );
  }

  factory BloodTestScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodTestScheduleData(
      id: serializer.fromJson<int>(json['id']),
      bloodTestFor: serializer.fromJson<String>(json['bloodTestFor']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String>(json['middleName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      ageCategory: serializer.fromJson<String>(json['ageCategory']),
      gender: serializer.fromJson<String>(json['gender']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      email: serializer.fromJson<String>(json['email']),
      schedulerPhoneNumber:
          serializer.fromJson<String>(json['schedulerPhoneNumber']),
      address: serializer.fromJson<String>(json['address']),
      facility: serializer.fromJson<String>(json['facility']),
      date: serializer.fromJson<int>(json['date']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      timeSlot: serializer.fromJson<String>(json['timeSlot']),
      refCode: serializer.fromJson<String>(json['refCode']),
      status: serializer.fromJson<String>(json['status']),
      result: serializer.fromJson<String?>(json['result']),
      onSite: serializer.fromJson<bool>(json['onSite']),
      bloodGroup: serializer.fromJson<String>(json['bloodGroup']),
      rh: serializer.fromJson<String>(json['rh']),
      bloodGroupRh: serializer.fromJson<String>(json['bloodGroupRh']),
      phenotype: serializer.fromJson<String>(json['phenotype']),
      kell: serializer.fromJson<String>(json['kell']),
      review: serializer.fromJson<String?>(json['review']),
      rating: serializer.fromJson<double?>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bloodTestFor': serializer.toJson<String>(bloodTestFor),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String>(middleName),
      'lastName': serializer.toJson<String>(lastName),
      'ageCategory': serializer.toJson<String>(ageCategory),
      'gender': serializer.toJson<String>(gender),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'email': serializer.toJson<String>(email),
      'schedulerPhoneNumber': serializer.toJson<String>(schedulerPhoneNumber),
      'address': serializer.toJson<String>(address),
      'facility': serializer.toJson<String>(facility),
      'date': serializer.toJson<int>(date),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'timeSlot': serializer.toJson<String>(timeSlot),
      'refCode': serializer.toJson<String>(refCode),
      'status': serializer.toJson<String>(status),
      'result': serializer.toJson<String?>(result),
      'onSite': serializer.toJson<bool>(onSite),
      'bloodGroup': serializer.toJson<String>(bloodGroup),
      'rh': serializer.toJson<String>(rh),
      'bloodGroupRh': serializer.toJson<String>(bloodGroupRh),
      'phenotype': serializer.toJson<String>(phenotype),
      'kell': serializer.toJson<String>(kell),
      'review': serializer.toJson<String?>(review),
      'rating': serializer.toJson<double?>(rating),
    };
  }

  BloodTestScheduleData copyWith(
          {int? id,
          String? bloodTestFor,
          String? firstName,
          String? middleName,
          String? lastName,
          String? ageCategory,
          String? gender,
          String? phoneNumber,
          String? email,
          String? schedulerPhoneNumber,
          String? address,
          String? facility,
          int? date,
          int? month,
          int? year,
          String? timeSlot,
          String? refCode,
          String? status,
          Value<String?> result = const Value.absent(),
          bool? onSite,
          String? bloodGroup,
          String? rh,
          String? bloodGroupRh,
          String? phenotype,
          String? kell,
          Value<String?> review = const Value.absent(),
          Value<double?> rating = const Value.absent()}) =>
      BloodTestScheduleData(
        id: id ?? this.id,
        bloodTestFor: bloodTestFor ?? this.bloodTestFor,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        ageCategory: ageCategory ?? this.ageCategory,
        gender: gender ?? this.gender,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        schedulerPhoneNumber: schedulerPhoneNumber ?? this.schedulerPhoneNumber,
        address: address ?? this.address,
        facility: facility ?? this.facility,
        date: date ?? this.date,
        month: month ?? this.month,
        year: year ?? this.year,
        timeSlot: timeSlot ?? this.timeSlot,
        refCode: refCode ?? this.refCode,
        status: status ?? this.status,
        result: result.present ? result.value : this.result,
        onSite: onSite ?? this.onSite,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        rh: rh ?? this.rh,
        bloodGroupRh: bloodGroupRh ?? this.bloodGroupRh,
        phenotype: phenotype ?? this.phenotype,
        kell: kell ?? this.kell,
        review: review.present ? review.value : this.review,
        rating: rating.present ? rating.value : this.rating,
      );
  @override
  String toString() {
    return (StringBuffer('BloodTestScheduleData(')
          ..write('id: $id, ')
          ..write('bloodTestFor: $bloodTestFor, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('schedulerPhoneNumber: $schedulerPhoneNumber, ')
          ..write('address: $address, ')
          ..write('facility: $facility, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('timeSlot: $timeSlot, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('result: $result, ')
          ..write('onSite: $onSite, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('rh: $rh, ')
          ..write('bloodGroupRh: $bloodGroupRh, ')
          ..write('phenotype: $phenotype, ')
          ..write('kell: $kell, ')
          ..write('review: $review, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        bloodTestFor,
        firstName,
        middleName,
        lastName,
        ageCategory,
        gender,
        phoneNumber,
        email,
        schedulerPhoneNumber,
        address,
        facility,
        date,
        month,
        year,
        timeSlot,
        refCode,
        status,
        result,
        onSite,
        bloodGroup,
        rh,
        bloodGroupRh,
        phenotype,
        kell,
        review,
        rating
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodTestScheduleData &&
          other.id == this.id &&
          other.bloodTestFor == this.bloodTestFor &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.ageCategory == this.ageCategory &&
          other.gender == this.gender &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.schedulerPhoneNumber == this.schedulerPhoneNumber &&
          other.address == this.address &&
          other.facility == this.facility &&
          other.date == this.date &&
          other.month == this.month &&
          other.year == this.year &&
          other.timeSlot == this.timeSlot &&
          other.refCode == this.refCode &&
          other.status == this.status &&
          other.result == this.result &&
          other.onSite == this.onSite &&
          other.bloodGroup == this.bloodGroup &&
          other.rh == this.rh &&
          other.bloodGroupRh == this.bloodGroupRh &&
          other.phenotype == this.phenotype &&
          other.kell == this.kell &&
          other.review == this.review &&
          other.rating == this.rating);
}

class BloodTestScheduleCompanion
    extends UpdateCompanion<BloodTestScheduleData> {
  final Value<int> id;
  final Value<String> bloodTestFor;
  final Value<String> firstName;
  final Value<String> middleName;
  final Value<String> lastName;
  final Value<String> ageCategory;
  final Value<String> gender;
  final Value<String> phoneNumber;
  final Value<String> email;
  final Value<String> schedulerPhoneNumber;
  final Value<String> address;
  final Value<String> facility;
  final Value<int> date;
  final Value<int> month;
  final Value<int> year;
  final Value<String> timeSlot;
  final Value<String> refCode;
  final Value<String> status;
  final Value<String?> result;
  final Value<bool> onSite;
  final Value<String> bloodGroup;
  final Value<String> rh;
  final Value<String> bloodGroupRh;
  final Value<String> phenotype;
  final Value<String> kell;
  final Value<String?> review;
  final Value<double?> rating;
  const BloodTestScheduleCompanion({
    this.id = const Value.absent(),
    this.bloodTestFor = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.ageCategory = const Value.absent(),
    this.gender = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.schedulerPhoneNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.facility = const Value.absent(),
    this.date = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.timeSlot = const Value.absent(),
    this.refCode = const Value.absent(),
    this.status = const Value.absent(),
    this.result = const Value.absent(),
    this.onSite = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.rh = const Value.absent(),
    this.bloodGroupRh = const Value.absent(),
    this.phenotype = const Value.absent(),
    this.kell = const Value.absent(),
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
  });
  BloodTestScheduleCompanion.insert({
    this.id = const Value.absent(),
    required String bloodTestFor,
    required String firstName,
    required String middleName,
    required String lastName,
    required String ageCategory,
    required String gender,
    required String phoneNumber,
    required String email,
    required String schedulerPhoneNumber,
    required String address,
    required String facility,
    required int date,
    required int month,
    required int year,
    required String timeSlot,
    required String refCode,
    required String status,
    this.result = const Value.absent(),
    required bool onSite,
    required String bloodGroup,
    required String rh,
    required String bloodGroupRh,
    required String phenotype,
    required String kell,
    this.review = const Value.absent(),
    this.rating = const Value.absent(),
  })  : bloodTestFor = Value(bloodTestFor),
        firstName = Value(firstName),
        middleName = Value(middleName),
        lastName = Value(lastName),
        ageCategory = Value(ageCategory),
        gender = Value(gender),
        phoneNumber = Value(phoneNumber),
        email = Value(email),
        schedulerPhoneNumber = Value(schedulerPhoneNumber),
        address = Value(address),
        facility = Value(facility),
        date = Value(date),
        month = Value(month),
        year = Value(year),
        timeSlot = Value(timeSlot),
        refCode = Value(refCode),
        status = Value(status),
        onSite = Value(onSite),
        bloodGroup = Value(bloodGroup),
        rh = Value(rh),
        bloodGroupRh = Value(bloodGroupRh),
        phenotype = Value(phenotype),
        kell = Value(kell);
  static Insertable<BloodTestScheduleData> custom({
    Expression<int>? id,
    Expression<String>? bloodTestFor,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? ageCategory,
    Expression<String>? gender,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? schedulerPhoneNumber,
    Expression<String>? address,
    Expression<String>? facility,
    Expression<int>? date,
    Expression<int>? month,
    Expression<int>? year,
    Expression<String>? timeSlot,
    Expression<String>? refCode,
    Expression<String>? status,
    Expression<String>? result,
    Expression<bool>? onSite,
    Expression<String>? bloodGroup,
    Expression<String>? rh,
    Expression<String>? bloodGroupRh,
    Expression<String>? phenotype,
    Expression<String>? kell,
    Expression<String>? review,
    Expression<double>? rating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bloodTestFor != null) 'blood_test_for': bloodTestFor,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (ageCategory != null) 'age_category': ageCategory,
      if (gender != null) 'gender': gender,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (schedulerPhoneNumber != null)
        'scheduler_phone_number': schedulerPhoneNumber,
      if (address != null) 'address': address,
      if (facility != null) 'facility': facility,
      if (date != null) 'date': date,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (timeSlot != null) 'time_slot': timeSlot,
      if (refCode != null) 'ref_code': refCode,
      if (status != null) 'status': status,
      if (result != null) 'result': result,
      if (onSite != null) 'on_site': onSite,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (rh != null) 'rh': rh,
      if (bloodGroupRh != null) 'blood_group_rh': bloodGroupRh,
      if (phenotype != null) 'phenotype': phenotype,
      if (kell != null) 'kell': kell,
      if (review != null) 'review': review,
      if (rating != null) 'rating': rating,
    });
  }

  BloodTestScheduleCompanion copyWith(
      {Value<int>? id,
      Value<String>? bloodTestFor,
      Value<String>? firstName,
      Value<String>? middleName,
      Value<String>? lastName,
      Value<String>? ageCategory,
      Value<String>? gender,
      Value<String>? phoneNumber,
      Value<String>? email,
      Value<String>? schedulerPhoneNumber,
      Value<String>? address,
      Value<String>? facility,
      Value<int>? date,
      Value<int>? month,
      Value<int>? year,
      Value<String>? timeSlot,
      Value<String>? refCode,
      Value<String>? status,
      Value<String?>? result,
      Value<bool>? onSite,
      Value<String>? bloodGroup,
      Value<String>? rh,
      Value<String>? bloodGroupRh,
      Value<String>? phenotype,
      Value<String>? kell,
      Value<String?>? review,
      Value<double?>? rating}) {
    return BloodTestScheduleCompanion(
      id: id ?? this.id,
      bloodTestFor: bloodTestFor ?? this.bloodTestFor,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      ageCategory: ageCategory ?? this.ageCategory,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      schedulerPhoneNumber: schedulerPhoneNumber ?? this.schedulerPhoneNumber,
      address: address ?? this.address,
      facility: facility ?? this.facility,
      date: date ?? this.date,
      month: month ?? this.month,
      year: year ?? this.year,
      timeSlot: timeSlot ?? this.timeSlot,
      refCode: refCode ?? this.refCode,
      status: status ?? this.status,
      result: result ?? this.result,
      onSite: onSite ?? this.onSite,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      rh: rh ?? this.rh,
      bloodGroupRh: bloodGroupRh ?? this.bloodGroupRh,
      phenotype: phenotype ?? this.phenotype,
      kell: kell ?? this.kell,
      review: review ?? this.review,
      rating: rating ?? this.rating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bloodTestFor.present) {
      map['blood_test_for'] = Variable<String>(bloodTestFor.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (ageCategory.present) {
      map['age_category'] = Variable<String>(ageCategory.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (schedulerPhoneNumber.present) {
      map['scheduler_phone_number'] =
          Variable<String>(schedulerPhoneNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (facility.present) {
      map['facility'] = Variable<String>(facility.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (timeSlot.present) {
      map['time_slot'] = Variable<String>(timeSlot.value);
    }
    if (refCode.present) {
      map['ref_code'] = Variable<String>(refCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (onSite.present) {
      map['on_site'] = Variable<bool>(onSite.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (rh.present) {
      map['rh'] = Variable<String>(rh.value);
    }
    if (bloodGroupRh.present) {
      map['blood_group_rh'] = Variable<String>(bloodGroupRh.value);
    }
    if (phenotype.present) {
      map['phenotype'] = Variable<String>(phenotype.value);
    }
    if (kell.present) {
      map['kell'] = Variable<String>(kell.value);
    }
    if (review.present) {
      map['review'] = Variable<String>(review.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodTestScheduleCompanion(')
          ..write('id: $id, ')
          ..write('bloodTestFor: $bloodTestFor, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('schedulerPhoneNumber: $schedulerPhoneNumber, ')
          ..write('address: $address, ')
          ..write('facility: $facility, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('timeSlot: $timeSlot, ')
          ..write('refCode: $refCode, ')
          ..write('status: $status, ')
          ..write('result: $result, ')
          ..write('onSite: $onSite, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('rh: $rh, ')
          ..write('bloodGroupRh: $bloodGroupRh, ')
          ..write('phenotype: $phenotype, ')
          ..write('kell: $kell, ')
          ..write('review: $review, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<String> dob = GeneratedColumn<String>(
      'dob', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ageCategoryMeta =
      const VerificationMeta('ageCategory');
  @override
  late final GeneratedColumn<String> ageCategory = GeneratedColumn<String>(
      'age_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailAddressMeta =
      const VerificationMeta('emailAddress');
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
      'email_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _homeAddressMeta =
      const VerificationMeta('homeAddress');
  @override
  late final GeneratedColumn<String> homeAddress = GeneratedColumn<String>(
      'home_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prevDonationMeta =
      const VerificationMeta('prevDonation');
  @override
  late final GeneratedColumn<bool> prevDonation = GeneratedColumn<bool>(
      'prev_donation', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("prev_donation" IN (0, 1))'));
  static const VerificationMeta _prevDonationAmountMeta =
      const VerificationMeta('prevDonationAmount');
  @override
  late final GeneratedColumn<double> prevDonationAmount =
      GeneratedColumn<double>('prev_donation_amount', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _whatsAppCommunityMeta =
      const VerificationMeta('whatsAppCommunity');
  @override
  late final GeneratedColumn<String> whatsAppCommunity =
      GeneratedColumn<String>('whats_app_community', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _triviaMeta = const VerificationMeta('trivia');
  @override
  late final GeneratedColumn<String> trivia = GeneratedColumn<String>(
      'trivia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        dob,
        age,
        ageCategory,
        gender,
        avatar,
        emailAddress,
        homeAddress,
        country,
        bloodGroup,
        prevDonation,
        prevDonationAmount,
        phoneNumber,
        password,
        whatsAppCommunity,
        trivia,
        date,
        month,
        year
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('dob')) {
      context.handle(
          _dobMeta, dob.isAcceptableOrUnknown(data['dob']!, _dobMeta));
    } else if (isInserting) {
      context.missing(_dobMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('age_category')) {
      context.handle(
          _ageCategoryMeta,
          ageCategory.isAcceptableOrUnknown(
              data['age_category']!, _ageCategoryMeta));
    } else if (isInserting) {
      context.missing(_ageCategoryMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('email_address')) {
      context.handle(
          _emailAddressMeta,
          emailAddress.isAcceptableOrUnknown(
              data['email_address']!, _emailAddressMeta));
    } else if (isInserting) {
      context.missing(_emailAddressMeta);
    }
    if (data.containsKey('home_address')) {
      context.handle(
          _homeAddressMeta,
          homeAddress.isAcceptableOrUnknown(
              data['home_address']!, _homeAddressMeta));
    } else if (isInserting) {
      context.missing(_homeAddressMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    } else if (isInserting) {
      context.missing(_bloodGroupMeta);
    }
    if (data.containsKey('prev_donation')) {
      context.handle(
          _prevDonationMeta,
          prevDonation.isAcceptableOrUnknown(
              data['prev_donation']!, _prevDonationMeta));
    } else if (isInserting) {
      context.missing(_prevDonationMeta);
    }
    if (data.containsKey('prev_donation_amount')) {
      context.handle(
          _prevDonationAmountMeta,
          prevDonationAmount.isAcceptableOrUnknown(
              data['prev_donation_amount']!, _prevDonationAmountMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('whats_app_community')) {
      context.handle(
          _whatsAppCommunityMeta,
          whatsAppCommunity.isAcceptableOrUnknown(
              data['whats_app_community']!, _whatsAppCommunityMeta));
    }
    if (data.containsKey('trivia')) {
      context.handle(_triviaMeta,
          trivia.isAcceptableOrUnknown(data['trivia']!, _triviaMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      dob: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dob'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      ageCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age_category'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar']),
      emailAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email_address'])!,
      homeAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}home_address'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group'])!,
      prevDonation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}prev_donation'])!,
      prevDonationAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}prev_donation_amount']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      whatsAppCommunity: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}whats_app_community']),
      trivia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trivia']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date']),
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month']),
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String fullName;
  final String dob;
  final int? age;
  final String ageCategory;
  final String gender;
  final String? avatar;
  final String emailAddress;
  final String homeAddress;
  final String country;
  final String bloodGroup;
  final bool prevDonation;
  final double? prevDonationAmount;
  final String phoneNumber;
  final String password;
  final String? whatsAppCommunity;
  final String? trivia;
  final int? date;
  final int? month;
  final int? year;
  const UserData(
      {required this.id,
      required this.fullName,
      required this.dob,
      this.age,
      required this.ageCategory,
      required this.gender,
      this.avatar,
      required this.emailAddress,
      required this.homeAddress,
      required this.country,
      required this.bloodGroup,
      required this.prevDonation,
      this.prevDonationAmount,
      required this.phoneNumber,
      required this.password,
      this.whatsAppCommunity,
      this.trivia,
      this.date,
      this.month,
      this.year});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['dob'] = Variable<String>(dob);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    map['age_category'] = Variable<String>(ageCategory);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['email_address'] = Variable<String>(emailAddress);
    map['home_address'] = Variable<String>(homeAddress);
    map['country'] = Variable<String>(country);
    map['blood_group'] = Variable<String>(bloodGroup);
    map['prev_donation'] = Variable<bool>(prevDonation);
    if (!nullToAbsent || prevDonationAmount != null) {
      map['prev_donation_amount'] = Variable<double>(prevDonationAmount);
    }
    map['phone_number'] = Variable<String>(phoneNumber);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || whatsAppCommunity != null) {
      map['whats_app_community'] = Variable<String>(whatsAppCommunity);
    }
    if (!nullToAbsent || trivia != null) {
      map['trivia'] = Variable<String>(trivia);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<int>(date);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<int>(month);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      fullName: Value(fullName),
      dob: Value(dob),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      ageCategory: Value(ageCategory),
      gender: Value(gender),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      emailAddress: Value(emailAddress),
      homeAddress: Value(homeAddress),
      country: Value(country),
      bloodGroup: Value(bloodGroup),
      prevDonation: Value(prevDonation),
      prevDonationAmount: prevDonationAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(prevDonationAmount),
      phoneNumber: Value(phoneNumber),
      password: Value(password),
      whatsAppCommunity: whatsAppCommunity == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsAppCommunity),
      trivia:
          trivia == null && nullToAbsent ? const Value.absent() : Value(trivia),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      month:
          month == null && nullToAbsent ? const Value.absent() : Value(month),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      dob: serializer.fromJson<String>(json['dob']),
      age: serializer.fromJson<int?>(json['age']),
      ageCategory: serializer.fromJson<String>(json['ageCategory']),
      gender: serializer.fromJson<String>(json['gender']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      emailAddress: serializer.fromJson<String>(json['emailAddress']),
      homeAddress: serializer.fromJson<String>(json['homeAddress']),
      country: serializer.fromJson<String>(json['country']),
      bloodGroup: serializer.fromJson<String>(json['bloodGroup']),
      prevDonation: serializer.fromJson<bool>(json['prevDonation']),
      prevDonationAmount:
          serializer.fromJson<double?>(json['prevDonationAmount']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      password: serializer.fromJson<String>(json['password']),
      whatsAppCommunity:
          serializer.fromJson<String?>(json['whatsAppCommunity']),
      trivia: serializer.fromJson<String?>(json['trivia']),
      date: serializer.fromJson<int?>(json['date']),
      month: serializer.fromJson<int?>(json['month']),
      year: serializer.fromJson<int?>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'dob': serializer.toJson<String>(dob),
      'age': serializer.toJson<int?>(age),
      'ageCategory': serializer.toJson<String>(ageCategory),
      'gender': serializer.toJson<String>(gender),
      'avatar': serializer.toJson<String?>(avatar),
      'emailAddress': serializer.toJson<String>(emailAddress),
      'homeAddress': serializer.toJson<String>(homeAddress),
      'country': serializer.toJson<String>(country),
      'bloodGroup': serializer.toJson<String>(bloodGroup),
      'prevDonation': serializer.toJson<bool>(prevDonation),
      'prevDonationAmount': serializer.toJson<double?>(prevDonationAmount),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'password': serializer.toJson<String>(password),
      'whatsAppCommunity': serializer.toJson<String?>(whatsAppCommunity),
      'trivia': serializer.toJson<String?>(trivia),
      'date': serializer.toJson<int?>(date),
      'month': serializer.toJson<int?>(month),
      'year': serializer.toJson<int?>(year),
    };
  }

  UserData copyWith(
          {int? id,
          String? fullName,
          String? dob,
          Value<int?> age = const Value.absent(),
          String? ageCategory,
          String? gender,
          Value<String?> avatar = const Value.absent(),
          String? emailAddress,
          String? homeAddress,
          String? country,
          String? bloodGroup,
          bool? prevDonation,
          Value<double?> prevDonationAmount = const Value.absent(),
          String? phoneNumber,
          String? password,
          Value<String?> whatsAppCommunity = const Value.absent(),
          Value<String?> trivia = const Value.absent(),
          Value<int?> date = const Value.absent(),
          Value<int?> month = const Value.absent(),
          Value<int?> year = const Value.absent()}) =>
      UserData(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        dob: dob ?? this.dob,
        age: age.present ? age.value : this.age,
        ageCategory: ageCategory ?? this.ageCategory,
        gender: gender ?? this.gender,
        avatar: avatar.present ? avatar.value : this.avatar,
        emailAddress: emailAddress ?? this.emailAddress,
        homeAddress: homeAddress ?? this.homeAddress,
        country: country ?? this.country,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        prevDonation: prevDonation ?? this.prevDonation,
        prevDonationAmount: prevDonationAmount.present
            ? prevDonationAmount.value
            : this.prevDonationAmount,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        whatsAppCommunity: whatsAppCommunity.present
            ? whatsAppCommunity.value
            : this.whatsAppCommunity,
        trivia: trivia.present ? trivia.value : this.trivia,
        date: date.present ? date.value : this.date,
        month: month.present ? month.value : this.month,
        year: year.present ? year.value : this.year,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('dob: $dob, ')
          ..write('age: $age, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('avatar: $avatar, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('homeAddress: $homeAddress, ')
          ..write('country: $country, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('prevDonation: $prevDonation, ')
          ..write('prevDonationAmount: $prevDonationAmount, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('password: $password, ')
          ..write('whatsAppCommunity: $whatsAppCommunity, ')
          ..write('trivia: $trivia, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fullName,
      dob,
      age,
      ageCategory,
      gender,
      avatar,
      emailAddress,
      homeAddress,
      country,
      bloodGroup,
      prevDonation,
      prevDonationAmount,
      phoneNumber,
      password,
      whatsAppCommunity,
      trivia,
      date,
      month,
      year);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.dob == this.dob &&
          other.age == this.age &&
          other.ageCategory == this.ageCategory &&
          other.gender == this.gender &&
          other.avatar == this.avatar &&
          other.emailAddress == this.emailAddress &&
          other.homeAddress == this.homeAddress &&
          other.country == this.country &&
          other.bloodGroup == this.bloodGroup &&
          other.prevDonation == this.prevDonation &&
          other.prevDonationAmount == this.prevDonationAmount &&
          other.phoneNumber == this.phoneNumber &&
          other.password == this.password &&
          other.whatsAppCommunity == this.whatsAppCommunity &&
          other.trivia == this.trivia &&
          other.date == this.date &&
          other.month == this.month &&
          other.year == this.year);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<String> dob;
  final Value<int?> age;
  final Value<String> ageCategory;
  final Value<String> gender;
  final Value<String?> avatar;
  final Value<String> emailAddress;
  final Value<String> homeAddress;
  final Value<String> country;
  final Value<String> bloodGroup;
  final Value<bool> prevDonation;
  final Value<double?> prevDonationAmount;
  final Value<String> phoneNumber;
  final Value<String> password;
  final Value<String?> whatsAppCommunity;
  final Value<String?> trivia;
  final Value<int?> date;
  final Value<int?> month;
  final Value<int?> year;
  const UserCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dob = const Value.absent(),
    this.age = const Value.absent(),
    this.ageCategory = const Value.absent(),
    this.gender = const Value.absent(),
    this.avatar = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.homeAddress = const Value.absent(),
    this.country = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.prevDonation = const Value.absent(),
    this.prevDonationAmount = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.password = const Value.absent(),
    this.whatsAppCommunity = const Value.absent(),
    this.trivia = const Value.absent(),
    this.date = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    required String dob,
    this.age = const Value.absent(),
    required String ageCategory,
    required String gender,
    this.avatar = const Value.absent(),
    required String emailAddress,
    required String homeAddress,
    required String country,
    required String bloodGroup,
    required bool prevDonation,
    this.prevDonationAmount = const Value.absent(),
    required String phoneNumber,
    required String password,
    this.whatsAppCommunity = const Value.absent(),
    this.trivia = const Value.absent(),
    this.date = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
  })  : fullName = Value(fullName),
        dob = Value(dob),
        ageCategory = Value(ageCategory),
        gender = Value(gender),
        emailAddress = Value(emailAddress),
        homeAddress = Value(homeAddress),
        country = Value(country),
        bloodGroup = Value(bloodGroup),
        prevDonation = Value(prevDonation),
        phoneNumber = Value(phoneNumber),
        password = Value(password);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? dob,
    Expression<int>? age,
    Expression<String>? ageCategory,
    Expression<String>? gender,
    Expression<String>? avatar,
    Expression<String>? emailAddress,
    Expression<String>? homeAddress,
    Expression<String>? country,
    Expression<String>? bloodGroup,
    Expression<bool>? prevDonation,
    Expression<double>? prevDonationAmount,
    Expression<String>? phoneNumber,
    Expression<String>? password,
    Expression<String>? whatsAppCommunity,
    Expression<String>? trivia,
    Expression<int>? date,
    Expression<int>? month,
    Expression<int>? year,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (dob != null) 'dob': dob,
      if (age != null) 'age': age,
      if (ageCategory != null) 'age_category': ageCategory,
      if (gender != null) 'gender': gender,
      if (avatar != null) 'avatar': avatar,
      if (emailAddress != null) 'email_address': emailAddress,
      if (homeAddress != null) 'home_address': homeAddress,
      if (country != null) 'country': country,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (prevDonation != null) 'prev_donation': prevDonation,
      if (prevDonationAmount != null)
        'prev_donation_amount': prevDonationAmount,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (password != null) 'password': password,
      if (whatsAppCommunity != null) 'whats_app_community': whatsAppCommunity,
      if (trivia != null) 'trivia': trivia,
      if (date != null) 'date': date,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    });
  }

  UserCompanion copyWith(
      {Value<int>? id,
      Value<String>? fullName,
      Value<String>? dob,
      Value<int?>? age,
      Value<String>? ageCategory,
      Value<String>? gender,
      Value<String?>? avatar,
      Value<String>? emailAddress,
      Value<String>? homeAddress,
      Value<String>? country,
      Value<String>? bloodGroup,
      Value<bool>? prevDonation,
      Value<double?>? prevDonationAmount,
      Value<String>? phoneNumber,
      Value<String>? password,
      Value<String?>? whatsAppCommunity,
      Value<String?>? trivia,
      Value<int?>? date,
      Value<int?>? month,
      Value<int?>? year}) {
    return UserCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      ageCategory: ageCategory ?? this.ageCategory,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      emailAddress: emailAddress ?? this.emailAddress,
      homeAddress: homeAddress ?? this.homeAddress,
      country: country ?? this.country,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      prevDonation: prevDonation ?? this.prevDonation,
      prevDonationAmount: prevDonationAmount ?? this.prevDonationAmount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      whatsAppCommunity: whatsAppCommunity ?? this.whatsAppCommunity,
      trivia: trivia ?? this.trivia,
      date: date ?? this.date,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (dob.present) {
      map['dob'] = Variable<String>(dob.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (ageCategory.present) {
      map['age_category'] = Variable<String>(ageCategory.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    if (homeAddress.present) {
      map['home_address'] = Variable<String>(homeAddress.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (prevDonation.present) {
      map['prev_donation'] = Variable<bool>(prevDonation.value);
    }
    if (prevDonationAmount.present) {
      map['prev_donation_amount'] = Variable<double>(prevDonationAmount.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (whatsAppCommunity.present) {
      map['whats_app_community'] = Variable<String>(whatsAppCommunity.value);
    }
    if (trivia.present) {
      map['trivia'] = Variable<String>(trivia.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('dob: $dob, ')
          ..write('age: $age, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('gender: $gender, ')
          ..write('avatar: $avatar, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('homeAddress: $homeAddress, ')
          ..write('country: $country, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('prevDonation: $prevDonation, ')
          ..write('prevDonationAmount: $prevDonationAmount, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('password: $password, ')
          ..write('whatsAppCommunity: $whatsAppCommunity, ')
          ..write('trivia: $trivia, ')
          ..write('date: $date, ')
          ..write('month: $month, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDB extends GeneratedDatabase {
  _$LocalDB(QueryExecutor e) : super(e);
  late final $BloodDonationScheduleTable bloodDonationSchedule =
      $BloodDonationScheduleTable(this);
  late final $BloodDonorRequestTable bloodDonorRequest =
      $BloodDonorRequestTable(this);
  late final $DonationCampaignDonorTable donationCampaignDonor =
      $DonationCampaignDonorTable(this);
  late final $BloodTestScheduleTable bloodTestSchedule =
      $BloodTestScheduleTable(this);
  late final $UserTable user = $UserTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bloodDonationSchedule,
        bloodDonorRequest,
        donationCampaignDonor,
        bloodTestSchedule,
        user
      ];
}
