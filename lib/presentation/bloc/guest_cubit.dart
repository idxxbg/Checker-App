import 'package:checker_nfc/domain/models/guest.dart';
import 'package:checker_nfc/domain/repository/guest_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestCubit extends Cubit<List<Guest>> {
  final GuestRepo guestRepo;

  GuestCubit(this.guestRepo) : super([]) {
    fetchData();
  }
  // LOAD
  Future<void> fetchData() async {
    final guestList = await guestRepo.fetchData();
    emit(guestList);
  }

  //ADD - Check In
  Future<void> addData(
    String name,
    String phone,
    String sex,
    String imageFile,
    String uid,
  ) async {
    // final existingGuest = await guestRepo.
    final newGuest = Guest(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      phone: phone,
      sex: sex,
      uid: uid,
      checkInTime: DateTime.now(),
      imageFile: imageFile,
    );

    // luu guest vao trong repo
    await guestRepo.addGuest(newGuest);

    fetchData();
  }

  //update
  Future<void> updateData() async {}

  //DELETE
  Future<void> deleteData(Guest guest) async {
    await guestRepo.deleteGuest(guest);
    fetchData();
  }

  // Check if guest exists by NFC ID
  Future<Guest?> guestExistByNfcid(String nfcid) async {
    return await guestRepo.userExistByNfcid(nfcid);
  }

  // Check out
  Future<void> checkOutGuest(Guest guest) async {
    Guest checkOutGuest = guest.guestCheckout();
    await guestRepo.checkOutGuest(checkOutGuest);
    // fetch data
    fetchData();
  }
}
