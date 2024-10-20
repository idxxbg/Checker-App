import 'package:checker_nfc/main.dart';
import 'package:checker_nfc/presentation/view/form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgwhite,
        elevation: 0,
        title: Text(title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
            icon: const Icon(CupertinoIcons.square_list),
          )
        ],
      ),
      body: const FormScreen(),
    );
  }
}
