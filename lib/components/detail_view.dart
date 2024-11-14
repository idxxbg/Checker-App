import 'dart:io';
import 'package:checker_app/domain/models/guest.dart';
import 'package:checker_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    super.key,
    required this.a,
  });

  final Guest a;

  @override
  Widget build(BuildContext context) {
    // String dateTime = DateFormat('').add_jm();

    return Container(
      width: 400,
      padding: paddingScreen,
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          colors: [bgblue, bgwhite, bgpurper],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.file(File(a.imageFile))),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.person_crop_circle,
                size: 40,
              ),
              title: Text(a.name),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.phone_circle,
                size: 40,
              ),
              title: Text(a.phone),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.time,
                size: 40,
              ),
              title: const Text(
                "Đã Check In vào lúc: ",
              ),
              subtitle:
                  Text(DateFormat('EEEE dd ').add_jm().format(a.checkInTime!)),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.checkmark_seal_fill,
                size: 40,
              ),
              title: a.isCheckOut
                  ? const Text("Đã check Out vào lúc: ")
                  : const Text("Chưa check Out"),
              subtitle: a.isCheckOut
                  ? Text(
                      DateFormat('EEEE dd ').add_jm().format(a.checkOutTime!))
                  : null,
            ),
            ListTile(
              leading: const Icon(
                Icons.transgender,
                size: 40,
              ),
              title: const Text('Giơí tính: '),
              subtitle: Text(a.sex),
            ),
            Text(a.isCheckOut.toString()),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
