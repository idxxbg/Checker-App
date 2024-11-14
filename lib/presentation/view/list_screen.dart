import 'package:checker_app/components/check_in_view.dart';
import 'package:checker_app/domain/models/guest.dart';
import 'package:checker_app/main.dart';
import 'package:checker_app/presentation/bloc/guest_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String nfcID = "";
  Guest? guest;

  Future<void> scanNFC() async {
    final cubit = context.read<GuestCubit>();
    try {
      var tag = await FlutterNfcKit.poll();
      nfcID = tag.id;
      guest = await cubit.guestExistByNfcid(nfcID);
      if (guest == null) {
        Navigator.pop(context);
        showMessageCheckGuest("Thẻ này chưa được sử dụng !");
      } else {
        Navigator.pop(context);
        handleCheckout(guest);
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      // print("Có lỗi xảy ra khi quét NFC: $e");
    }
    nfcID = '';
  }

  // Hiển thị dialog khi tìm thấy Guest
  void handleCheckout(Guest? guest) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Check out".toUpperCase(),
          style: heading2,
        ),
        content: Text(
          'Tên : ${guest!.name}\n'
          'Số điện thoại : ${guest.phone}',
        ),
        actions: [
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<GuestCubit>().checkOut(guest);
                showMessageCheckGuest('Đã Check Out cho khách.');
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  //showMessage
  void showMessageCheckGuest(String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(text),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestCubit, List<Guest>>(
      builder: (context, guestList) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              tooltip: 'Check Out',
              onPressed: () async {
                showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  builder: (_) {
                    scanNFC();
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [bgwhite, bgblue, bgpurper])),
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Mời quét thẻ để Check Out: ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: bold,
                                      color: Colors.blue),
                                  // children: [ ],
                                ),
                              ),
                              nfcID == ""
                                  ? const CircularProgressIndicator()
                                  : Text.rich(
                                      TextSpan(
                                        text: nfcID,
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.exit_to_app),
            ),
            appBar: AppBar(
              backgroundColor: bgpurper,
              title: const Text(
                "Danh sách",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: "Check In",
                    icon: Icon(CupertinoIcons.checkmark_seal),
                  ),
                  Tab(
                    text: "Check Out",
                    icon: Icon(CupertinoIcons.checkmark_seal_fill),
                  )
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [bgpurper, Colors.white, bgblue],
                    ),
                  ),
                ),
                TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // check in view
                    CheckInView(
                      guestList: guestList,
                      isCheckOut: false,
                    ),
                    // check out view
                    CheckInView(
                      guestList: guestList,
                      isCheckOut: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
