import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onepic/services/auth.dart';
import 'package:onepic/services/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepic/services/models.dart';

final greetingProvider = Provider((ref) => 'Hello World!');
final userProvider =
    StreamProvider<UserModel>((ref) => Global.userDataRef.documentStream);
final authProvider = StreamProvider<User>((ref) => FirebaseAuthHelper().user);
final onesProvider = StreamProvider<List>((ref) => Global.onesRef.streamData());
final currentUserIdProvider = Provider<String>((ref) {
  final currentUserId = ref.read(userProvider).data.value.id;
  return currentUserId;
});
