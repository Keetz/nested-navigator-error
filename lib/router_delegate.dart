import 'package:flutter/material.dart';
import 'package:navigator_test/large_scaffold.dart';
import 'package:navigator_test/page_model.dart';
import 'package:navigator_test/pages.dart';
import 'package:navigator_test/route_path.dart';
import 'package:navigator_test/small_scaffold.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<MyRoutePath> {
  MyRouterDelegate(BuildContext context)
      : navigatorKey = GlobalKey<NavigatorState>() {
    _pageModel = Provider.of<PageModel>(context, listen: false);
    _pageModel.addListener(notifyListeners);
  }

  final GlobalKey<NavigatorState> innerNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  late PageModel _pageModel;

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        key: navigatorKey,
        pages: <Page<dynamic>>[
          MaterialPage<Page<dynamic>>(
            child: MediaQuery.of(context).size.width < 400
                ? SmallScaffold(innerNavigatorKey: innerNavigatorKey)
                : LargeScaffold(innerNavigatorKey: innerNavigatorKey),
          )
        ],
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (!route.didPop(result)) {
            return false;
          }
          notifyListeners();
          return true;
        },
      ),
    );
  }

  @override
  MyRoutePath get currentConfiguration {
    if (_pageModel.pages.isNotEmpty) {
      if (_pageModel.pages.last is HomePage) {
        return HomePath();
      }

      if (_pageModel.pages.last is AboutPage) {
        return AboutPath();
      }
    }

    return HomePath();
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    if (configuration is HomePath) {
      _pageModel.clearAndReset(HomePage());
    }

    if (configuration is AboutPath) {
      _pageModel.clearAndReset(AboutPage());
    }
  }
}
