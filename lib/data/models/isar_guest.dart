import 'package:checker_nfc/domain/models/guest.dart';
import 'package:isar/isar.dart';

/// Isar Guest module
/// chuyển Guest module thành dạng isar Guest để có thể lưu vào Isar database
// ignore_for_file: dangling_library_doc_comments

part "isar_guest.g.dart";

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

  // Chuyển đối tượng isar -> chuyển về dạng app có thể đọc được
  Guest toDomain() {
    return Guest(
      id: id,
      name: name,
      phone: phone,
      sex: sex,
      uid: uid,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      imageFile: imageFile,
      isCheckOut: isCheckOut,
    );
  }

  // Chuyển dữ liệu từ đối tượng Guest trong app -> Isar có thể lưu lại
  static IsarGuest fromDomain(Guest guest) {
    return IsarGuest()
      ..id = guest.id
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
