import 'package:checker_nfc/components/detail_view.dart';
import 'package:checker_nfc/domain/models/guest.dart';
import 'package:checker_nfc/main.dart';
import 'package:checker_nfc/presentation/bloc/guest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({
    super.key,
    required this.guestList,
    required this.isCheckOut,
  });
  final List<Guest> guestList;
  final bool isCheckOut;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: guestList.length,
      itemBuilder: (BuildContext context, i) {
        final a = guestList[i];
        final bool = isCheckOut == a.isCheckOut;

        return Visibility(
          visible: bool,
          child: Padding(
            padding: paddingScreen,
            child: Card(
              elevation: 0,
              color: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                onLongPress: () => context.read<GuestCubit>().deleteData(a),
                title: Text(a.name),
                subtitle: Text(a.phone),
                trailing: IconButton(
                  onPressed: () => showBottomSheet(
                      backgroundColor: Colors.transparent,
                      builder: (_) => DetailView(a: a),
                      context: context),
                  icon: const Icon(Icons.info_outline_rounded),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
