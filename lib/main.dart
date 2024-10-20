import 'package:checker_nfc/app/app.dart';
import 'package:checker_nfc/data/models/isar_guest.dart';
import 'package:checker_nfc/data/repository/isar_guest_repo.dart';
import 'package:checker_nfc/presentation/bloc/guest_cubit.dart';
import 'package:checker_nfc/presentation/view/list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';

part 'resources/styles/styles.dart';
part 'resources/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

  // open isar database
  final isar = await Isar.open([IsarGuestSchema], directory: dir.path);

  // initialize the repo with isar database
  final isarGuestRepo = IsarGuestRepo(db: isar);

  runApp(MyApp(db: isarGuestRepo));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});
  final IsarGuestRepo db;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuestCubit(db),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/":
              return MaterialWithModalsPageRoute(
                builder: (_) => const App(title: "Guest Form"),
              );
            case "/list":
              return CupertinoPageRoute(builder: (_) => const ListScreen());
            // return _createRoute(const ListScreen());
          }
          return null;
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
      ),
    );
  }

  // hieu ung chuyen canh
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin =
            Offset(1.0, 0.0); // Bắt đầu từ phải (1.0 là phải, 0.0 là trái)
        const end = Offset.zero; // Kết thúc tại vị trí hiện tại
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
