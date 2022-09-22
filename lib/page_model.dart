import 'package:flutter/foundation.dart';
import 'package:navigator_test/pages.dart';

class PageModel extends ChangeNotifier {
  final List<MyPage> _pages = [];

  List<MyPage> get pages => _pages;

  void addPage(MyPage page) {
    if (_pages.isEmpty || _pages.last != page) {
      _pages.add(page);
    }
    notifyListeners();
  }

  void pop() {
    _pages.removeLast();
    notifyListeners();
  }

  void clearAndReset(MyPage page) {
    _pages.clear();
    addPage(page);
    notifyListeners();
  }
}
