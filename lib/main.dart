// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> innerNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return Navigator(
          key: navigatorKey,
          pages: <Page<dynamic>>[
            MaterialPage<Page<dynamic>>(
              child: MainScaffold(navigatorKey: innerNavigatorKey),
            )
          ],
          onPopPage: (Route<dynamic> route, dynamic result) {
            return route.didPop(result);
          },
        );
      },
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(
        child: Center(child: TextField()), // Loses focus immediately!
      ),
      body: Column(
        children: [
          Expanded(child: InnerNavigator(navigatorKey: navigatorKey)),
          const Divider(),
          TextField(), // Loses focus immediately!
          const SizedBox(height: 20)
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class InnerNavigator extends StatelessWidget {
  const InnerNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // This works!
        // const MaterialPage(
        //   child: Center(child: TextField()),
        // ),

        // This doesn't work!
        MaterialPage(
          child: Center(child: Text('Inner Navigator')),
        ),
      ],
      onPopPage: (Route<dynamic> route, dynamic result) {
        return route.didPop(result);
      },
    );
  }
}
