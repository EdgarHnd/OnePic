/* import 'package:hooks_riverpod/hooks_riverpod.dart';

final userStateProvider = StateNotifierProvider((ref) => UserStateNotifier());

enum FollowEvent { Followed, NotFollowed }

class UserStateNotifier extends StateNotifier<FollowModel> {
  UserStateNotifier() : super(defaultFeed);

  static const defaultFeed = FollowModel(FollowEvent.NotFollowed);

  void follow() {
    state = FollowModel(FollowEvent.Followed);
  }

  void unFollow() {
    state = FollowModel(FollowEvent.NotFollowed);
  }
}

class FollowModel {
  const FollowModel(this.event);
  final FollowEvent event;
}
 */
