// ignore_for_file: dangling_library_doc_comments
/// khởi tạo Guest
/// đây là một đối tượng Guest gồm các thuộc tính
/// id
/// phone
/// Sex
/// imageFile
/// uid
/// dateTime

class Guest {
  int id;
  String name;
  String phone;
  String sex;
  String imageFile;
  String uid;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  bool isCheckOut;
  Guest({
    required this.id,
    required this.name,
    required this.phone,
    required this.sex,
    required this.imageFile,
    required this.uid,
    required this.checkInTime,
    this.checkOutTime,
    this.isCheckOut = false,
  });

  Guest guestCheckout() {
    return Guest(
      id: id,
      name: name,
      phone: phone,
      sex: sex,
      imageFile: imageFile,
      uid: uid,
      checkInTime: checkInTime,
      checkOutTime: DateTime.now(),
      isCheckOut: true,
    );
  }
}
