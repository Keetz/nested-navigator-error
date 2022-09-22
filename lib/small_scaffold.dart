import 'package:flutter/material.dart';
import 'package:navigator_test/inner_router_delegate.dart';

class SmallScaffold extends StatelessWidget {
  const SmallScaffold({Key? key, required this.innerNavigatorKey})
      : super(key: key);

  final GlobalKey<NavigatorState> innerNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(child: Center(child: TextField())), // This textfield loses focus immediately!
      body: Column(
        children: [
          Expanded(
            child: Router<dynamic>(
              routerDelegate:
                  InnerRouterDelegate(navigatorKey: innerNavigatorKey),
            ),
          ),
          const Divider(),
          const SizedBox(
            width: 200,
            height: 50,
            child: TextField(), // This textfield loses focus immediately!
          ),
          const SizedBox(height: 20)
        ],
      ),
      drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
    );
  }
}
