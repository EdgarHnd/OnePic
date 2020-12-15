import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/services/auth.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepic/services/models.dart';

final greetingProvider = Provider((ref) => 'Hello World!');

final currentUserProvider = StreamProvider<UserModel>(
    (ref) => UserData<UserModel>(collection: 'users').documentStream);

final authProvider = StreamProvider<User>((ref) => FirebaseAuthHelper().user);

final onesProvider = StreamProvider<List>(
    (ref) => Collection<OneModel>(path: 'ones').streamData());

final currentUserIdProvider = Provider<String>((ref) {
  final currentUserId = ref.read(currentUserProvider).data.value.id;
  return currentUserId;
});

final currentUserModelProvider = Provider<UserModel>((ref) {
  final currentUserModel = ref.watch(currentUserProvider).data.value;
  return currentUserModel;
});

final userProvider = StreamProvider.family<UserModel, String>(
    (ref, uid) => Document<UserModel>(path: 'users/$uid').streamData());

final oneProvider = StreamProvider.family<OneModel, String>(
    (ref, id) => Document<OneModel>(path: 'ones/$id').streamData());

final userOnesProvider = StreamProvider.family<OneModel, String>((ref, uid) {
  final userOne = ref.watch(userProvider(uid)).data.value.one;
  return Document<OneModel>(path: 'ones/$userOne').streamData();
});

final currentUserOneIdProvider = Provider<String>((ref) {
  final currentUserOneId = ref.watch(currentUserProvider).data.value.one;
  return currentUserOneId;
});

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

final allCurrentUserOnesProvider = Provider<List<OneModel>>((ref) {
  final currentUid = ref.read(currentUserIdProvider);
  final List<OneModel> ones = ref.read(onesProvider).data.value;
  List<OneModel> userOnes = [];
  for (var one in ones) {
    if (one.uid == currentUid) {
      userOnes.add(one);
    }
  }
  return userOnes;
});

final allCurrentOnesProvider = StreamProvider<List<OneModel>>((ref) {
  return CurrentOnesCollection<OneModel>(path: 'ones').streamData();
});

final newOneIdProvider = Provider<String>((ref) {
  final currentUid = ref.read(currentUserIdProvider);
  final List<OneModel> ones = ref.read(onesProvider).data.value;
  String oneId;
  for (var one in ones) {
    if (one.uid == currentUid && one.isCurrent) {
      oneId = one.id;
    }
  }
  return oneId;
});

final currentUserOneProvider = StreamProvider<OneModel>((ref) {
  final currentModel = ref.watch(currentUserModelProvider);
  return Document<OneModel>(path: 'ones/${currentModel.one}').streamData();
});
