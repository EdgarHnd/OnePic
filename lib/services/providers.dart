import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/services/auth.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepic/services/models.dart';

final greetingProvider = Provider((ref) => 'Hello World!');

final currentUserProvider =
    StreamProvider<UserModel>((ref) => Global.userDataRef.documentStream);

final authProvider = StreamProvider<User>((ref) => FirebaseAuthHelper().user);

final onesProvider = StreamProvider<List>((ref) => Global.onesRef.streamData());

final currentUserIdProvider = Provider<String>((ref) {
  final currentUserId = ref.read(currentUserProvider).data.value.id;
  return currentUserId;
});

final userProvider = StreamProvider.family<UserModel, String>(
    (ref, uid) => Document<UserModel>(path: 'users/$uid').streamData());

final oneProvider = StreamProvider.family<OneModel, String>(
    (ref, id) => Document<OneModel>(path: 'ones/$id').streamData());

final isFollowedProvider =
    FutureProvider.family<bool, String>((ref, uid) async {
  final currentUid = ref.watch(currentUserIdProvider);
  final user = ref.watch(userProvider(uid));
  if (user.data.value.followers.contains(currentUid)) {
    return true;
  } else {
    return false;
  }
});

final isLikedProvider = FutureProvider.family<bool, String>((ref, id) async {
  final currentUid = ref.watch(currentUserIdProvider);
  final one = ref.watch(oneProvider(id));
  if (one.data.value.likes.contains(currentUid)) {
    return true;
  } else {
    return false;
  }
});
