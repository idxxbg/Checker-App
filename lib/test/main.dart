import 'package:checker_nfc/test/modal_fit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomSheet Modals',

      // routes: {
      //   "/": (_) => MyHomePage(title: "title"),
      //   "/list": (_) => Test(),
      // },

      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/list':
            return MaterialWithModalsPageRoute(builder: (_) => Test());
          case '/':
            return MaterialWithModalsPageRoute(builder: (_) => const Test2());
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, "/list")),
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            // transitionBetweenRoutes: false,
            middle: Text('iOS13 Modal Presentation'),
            trailing: GestureDetector(
              child: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).pushNamed('ss'),
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              primary: true,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // ListTile(
                    //     title: Text('Cupertino Photo Share Example'),
                    //     onTap: () => Navigator.of(context).push(
                    //         MaterialWithModalsPageRoute(
                    //             builder: (context) => CupertinoSharePage()))),
                    section('STYLES'),
                    ListTile(
                      title: Text('Material fit'),
                      onTap: () => showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ModalFit(),
                      ),
                    ),
                    // ListTile(
                    //   title: Text('Bar Modal'),
                    //   onTap: () => showBarModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ModalInsideModal(),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Avatar Modal'),
                    //   onTap: () => showAvatarModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ModalInsideModal(),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Float Modal'),
                    //   onTap: () => showFloatingModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => ModalFit(),
                    //   ),
                    // ),
                    ListTile(
                      title: Text('Cupertino Modal fit'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ModalFit(),
                      ),
                    ),
                    section('COMPLEX CASES'),
                    ListTile(
                        title: Text('Cupertino Small Modal forced to expand'),
                        onTap: () => showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ModalFit(),
                            )),
                    // ListTile(
                    //   title: Text('Reverse list'),
                    //   onTap: () => showBarModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ModalInsideModal(reverse: true),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Cupertino Modal inside modal'),
                    //   onTap: () => showCupertinoModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ModalInsideModal(),
                    //   ),
                    // ),
                    // ListTile(
                    //     title: Text('Cupertino Modal with inside navigation'),
                    //     onTap: () => showCupertinoModalBottomSheet(
                    //           expand: true,
                    //           context: context,
                    //           backgroundColor: Colors.transparent,
                    //           builder: (context) => ModalWithNavigator(),
                    //         )),
                    // ListTile(
                    //   title:
                    //       Text('Cupertino Navigator + Scroll + WillPopScope'),
                    //   onTap: () => showCupertinoModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ComplexModal(),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Modal with WillPopScope'),
                    //   onTap: () => showCupertinoModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => ModalWillScope(),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Modal with Nested Scroll'),
                    //   onTap: () => showCupertinoModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     builder: (context) => NestedScrollModal(),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Modal with PageView'),
                    //   onTap: () => showBarModalBottomSheet(
                    //     expand: true,
                    //     context: context,
                    //     builder: (context) => ModalWithPageView(),
                    //   ),
                    // ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget section(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Card(
              child: Text("data"),
            ),
          ),
        ),
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            // transitionBetweenRoutes: false,
            middle: Text('iOS13 Modal Presentation'),
            trailing: GestureDetector(
              child: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).pushNamed('/list'),
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
                primary: true,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => ModalFit(),
          ),
        ),
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            // transitionBetweenRoutes: false,
            middle: Text('test2'),
            trailing: GestureDetector(
              child: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).pushNamed('ss'),
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
                primary: true,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
