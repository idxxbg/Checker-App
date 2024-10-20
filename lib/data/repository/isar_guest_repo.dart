// ignore: dangling_library_doc_comments
import 'package:checker_nfc/data/models/isar_guest.dart';
import 'package:checker_nfc/domain/models/guest.dart';
import 'package:checker_nfc/domain/repository/guest_repo.dart';
import 'package:isar/isar.dart';

/// Xử lý dữ liệu và lưu vào isarDB

class IsarGuestRepo implements GuestRepo {
  // Truyen database
  final Isar db;
  IsarGuestRepo({required this.db});

  // Get Data from db
  @override
  Future<List<Guest>> fetchData() async {
    final guests = await db.isarGuests.where().findAll();

    return guests.map((isarGuest) => isarGuest.toDomain()).toList();
  }

  // A D D
  @override
  Future<void> addGuest(Guest newGuest) async {
    // chuyển về dạng isar db
    final newguest = IsarGuest.fromDomain(newGuest);
    // lưu vào db
    return db.writeTxn(() => db.isarGuests.put(newguest));
  }

  // D e l e t e
  @override
  Future<void> deleteGuest(Guest guest) {
    return db.writeTxn(() => db.isarGuests.delete(guest.id));
  }

  // U P D A T E
  @override
  Future<void> upgradeGuest(Guest guest) async {
    // final Guest? guest = await db.isarGuests.filter().uidEqualTo(nfcID).findFirst();

    final updateGuest = IsarGuest.fromDomain(guest);
    // lưu vào db
    return db.writeTxn(() => db.isarGuests.put(updateGuest));
  }

  // CHECK EXIST GUEST
  @override
  Future<Guest?> userExistByNfcid(String uid) async {
    final guest = await db.isarGuests
        .filter()
        .uidEqualTo(uid)
        .isCheckOutEqualTo(false)
        .findFirst();

    return guest?.toDomain();
  }

  // CHECK OUT GUEST
  @override
  Future<void> checkOutGuest(Guest guest) {
    // chuyển về dạng isar
    final checkOutGuest = IsarGuest.fromDomain(guest);
    // lưu vào data base
    return db.writeTxn(() => db.isarGuests.put(checkOutGuest));
  }
}
