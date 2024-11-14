import 'package:checker_app/domain/models/guest.dart';

abstract class GuestRepo {
  // Get list of Guests
  Future<List<Guest>> fetchData();
  // Add a new Guest
  Future<void> addGuest(Guest newGuest);
  // Upgrade a new Guest
  Future<void> upgradeGuest(Guest guest);
  // Find nfcid
  Future<Guest?> userExistByNfcid(String nfc);
  // Check out Guest
  Future<void> checkOutGuest(Guest guestout);
  // Delete the Guest
  Future<void> deleteGuest(Guest guest);
}
