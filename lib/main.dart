import 'package:flutter/material.dart';
import 'package:navigator_test/page_model.dart';
import 'package:navigator_test/route_information_parser.dart';
import 'package:navigator_test/router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<PageModel>(
            create: (BuildContext context) => PageModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate _routerDelegate;
  late MyRouteInformationParser _routeInformationParser;

  @override
  void initState() {
    super.initState();

    _routerDelegate = MyRouterDelegate(context);
    _routeInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Navigator Test',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      ),
    );
  }
}
