import 'package:flutter/material.dart';
import 'package:navigator_test/page_model.dart';
import 'package:navigator_test/pages.dart';
import 'package:navigator_test/route_path.dart';
import 'package:provider/provider.dart';

class InnerRouterDelegate extends RouterDelegate<MyRoutePath>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<MyRoutePath> {
  InnerRouterDelegate({required this.navigatorKey});

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        key: navigatorKey,
        // pages: _convertToMaterialPages(
        //   Provider.of<PageModel>(context).pages,
        // ),
        pages: [
          // This works!
          // const MaterialPage(child: Home())

          // This does NOT work as the MaterialPage isn't const
          // MaterialPage(
          //   child: const Home(),
          //   key: ValueKey<MyPage>(HomePage()),
          // )
          MaterialPage(child: Home())
        ],
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (!route.didPop(result)) {
            return false;
          }

          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    // This is not required for inner router delegate because it does not parse route
    assert(false, 'configuration must not be false');
  }

  List<MaterialPage<MyPage>> _convertToMaterialPages(List<MyPage> pages) {
    final List<MaterialPage<MyPage>> listMaterialPages =
        <MaterialPage<MyPage>>[];

    if (pages.isEmpty) {
      listMaterialPages.add(_buildMaterialPage(const Home(), HomePage()));

      return listMaterialPages;
    }

    for (var page in pages) {
      if (page is HomePage) {
        listMaterialPages.add(_buildMaterialPage(const Home(), page));
      }

      if (page is AboutPage) {
        listMaterialPages.add(_buildMaterialPage(const About(), page));
      }
    }

    return listMaterialPages;
  }

  MaterialPage<MyPage> _buildMaterialPage(Widget child, MyPage page) {
    return MaterialPage<MyPage>(
      child: child,
      key: ValueKey<MyPage>(page),
    );
  }
}
