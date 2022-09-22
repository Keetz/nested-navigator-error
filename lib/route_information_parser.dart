import 'package:flutter/material.dart';
import 'package:navigator_test/route_path.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  static const String homeLocation = '';
  static const String aboutLocation = 'about';

  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == homeLocation) {
      return HomePath();
    }

    if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == aboutLocation) {
      return AboutPath();
    }

    return HomePath();
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath configuration) {
    if (configuration is HomePath) {
      return const RouteInformation(location: '/');
    }

    if (configuration is AboutPath) {
      return const RouteInformation(location: '/$aboutLocation');
    }

    return const RouteInformation(location: '/');
  }
}
