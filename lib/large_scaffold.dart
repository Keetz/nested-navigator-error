import 'package:flutter/material.dart';
import 'package:navigator_test/inner_router_delegate.dart';

class LargeScaffold extends StatelessWidget {
  const LargeScaffold({Key? key, required this.innerNavigatorKey}) : super(key: key);

  final GlobalKey<NavigatorState> innerNavigatorKey;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(child: Center(child: TextField())),
      body: Router<dynamic>(
        routerDelegate: InnerRouterDelegate(navigatorKey: innerNavigatorKey),
      ),
      drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
    );
  }
}