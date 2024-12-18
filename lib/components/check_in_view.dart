import 'package:checker_app/components/detail_view.dart';
import 'package:checker_app/domain/models/guest.dart';
import 'package:checker_app/main.dart';
import 'package:checker_app/presentation/bloc/guest_cubit.dart';
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
    return RefreshIndicator(
      backgroundColor: Colors.black38,
      color: Colors.white70,
      onRefresh: () async {
        // Replace this delay with the code to be executed during refresh
        // and return a Future when code finishes execution.
        context.read<GuestCubit>().fetchData();
        // return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        // physics: const BouncingScrollPhysics(),
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
      ),
    );
  }
}
