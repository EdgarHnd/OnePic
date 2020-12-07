import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationStateProvider =
    StateNotifierProvider((ref) => NavigationNotifier());

enum NavigationBarEvent { Trends, Feed, Account }

class NavigationNotifier extends StateNotifier<PageModel> {
  NavigationNotifier() : super(defaultPage);

  static const defaultPage = PageModel(NavigationBarEvent.Feed);

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = PageModel(NavigationBarEvent.Trends);
        break;
      case 1:
        state = PageModel(NavigationBarEvent.Feed);
        break;
      case 2:
        state = PageModel(NavigationBarEvent.Account);
        break;
    }
  }
}

class PageModel {
  const PageModel(this.page);
  final NavigationBarEvent page;
}
