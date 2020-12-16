import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/services/models.dart';
import 'package:onepic/services/providers.dart';

class OneCreator {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addOneToDb(BuildContext context) async {
    CollectionReference onesRef = _db.collection('ones');
    UserModel user = context.read(currentUserProvider).data.value;
    String oldOne = context.read(currentUserOneIdProvider);
    String newId;

    await onesRef.doc(oldOne).update({'isCurrent': false});

    await onesRef.add({
      'uid': user.id,
      'username': user.username,
      "likes": [],
      "nbLikes": 0,
      "datePosted": Timestamp.now(),
      "isCurrent": true,
      'url': '',
    }).then((value) {
      newId = value.id;
      value.update({'id': value.id});
    }).whenComplete(() => updateUserOne(context, newId));
    return newId;
  }

  Future<void> updateUserOne(BuildContext context, String id) async {
    String currentUid = context.read(currentUserProvider).data.value.id;
    DocumentReference userRef = _db.collection('users').doc(currentUid);
    return await userRef.update({'one': id});
  }

  Future<void> setUrl(String id, String url) async {
    DocumentReference userRef = _db.collection('ones').doc(id);
    return await userRef.update({'url': url});
  }
}
