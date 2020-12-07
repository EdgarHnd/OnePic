import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/global.dart';
import 'package:onepic/services/models.dart';

class UserPageModel {
  void unFollow(String id, String uid) {
    Document<UserModel> user = Document<UserModel>(path: 'users/' + id);
    user.upsert(({
      'nbFollowers': FieldValue.increment(-1),
      'followers': FieldValue.arrayRemove([uid])
    }));
    Global.userDataRef.upsert(({
      'nbFollowing': FieldValue.increment(-1),
      'following': FieldValue.arrayRemove([id])
    }));
  }

  void follow(String id, String uid) {
    Document<UserModel> user = Document<UserModel>(path: 'users/' + id);
    user.upsert(({
      'nbFollowers': FieldValue.increment(1),
      'followers': FieldValue.arrayUnion([uid])
    }));
    Global.userDataRef.upsert(({
      'nbFollowing': FieldValue.increment(1),
      'following': FieldValue.arrayUnion([id])
    }));
  }
}
