import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OneCreator {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addUserToDb(User user, username) {
    DocumentReference usersRef = _db.collection('ones').doc(user.uid);
    return usersRef.set({
      'uid': user.uid,
      'username': username,
      'email': user.email,
      "one": '',
      "followers": {},
      "following": {},
      "likes": 0,
    });
  }
}
