import 'package:isar/isar.dart';

import '../../domain/models/guest.dart';

part 'isar_guest.g.dart';

@collection 

class IsarGuest {
  Id id = Isar.autoIncrement;
  late String name;
  late String phone;
  late String uid;
  late String sex;
  late DateTime? checkInTime;
  late DateTime? checkOutTime;
  late String imageFile;
  late bool isCheckOut;

  // chuyen doi tuong isar -> ve dang app co the doc duoc
  Guest toDomain() {
    return Guest(id: id, name: name, phone: phone, sex: sex, imageFile: imageFile, uid: uid, checkInTime: checkInTime,);
  }

  // chuyen du lieu tu doi tuong Guest trong app -> Isar co the luu tru
  static IsarGuest fromDomain(Guest guest) {
    return IsarGuest()  ..id = guest.id
      ..name = guest.name
      ..phone = guest.phone
      ..sex = guest.sex
      ..uid = guest.uid
      ..checkInTime = guest.checkInTime
      ..checkOutTime = guest.checkOutTime
      ..imageFile = guest.imageFile
      ..isCheckOut = guest.isCheckOut;
  }
}