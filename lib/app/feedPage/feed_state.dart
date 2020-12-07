import 'package:hooks_riverpod/hooks_riverpod.dart';

final feedStateProvider = StateNotifierProvider((ref) => FeedNotifier());

enum FeedEvent { Initial, ShowUser }

class FeedNotifier extends StateNotifier<FeedModel> {
  FeedNotifier() : super(defaultFeed);

  static const defaultFeed = FeedModel(FeedEvent.Initial);

  void showUser() {
    state = FeedModel(FeedEvent.ShowUser);
  }

  void backToFeed() {
    state = FeedModel(FeedEvent.Initial);
  }
}

class FeedModel {
  const FeedModel(this.event);
  final FeedEvent event;
}
