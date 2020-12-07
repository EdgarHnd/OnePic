import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/global.dart';
import 'package:onepic/services/models.dart';

class OnePageModel {
  void unLike(String id, String uid) {
    Document<OneModel> userOne = Document<OneModel>(path: 'ones/' + id);
    userOne.upsert(({
      'nbLikes': FieldValue.increment(-1),
      'likes': FieldValue.arrayRemove([uid])
    }));
    Global.userDataRef.upsert(({
      'liked': FieldValue.arrayRemove([id])
    }));
  }

  void like(String id, String uid) {
    Document<OneModel> userOne = Document<OneModel>(path: 'ones/' + id);
    userOne.upsert(({
      'nbLikes': FieldValue.increment(1),
      'likes': FieldValue.arrayUnion([uid])
    }));
    Global.userDataRef.upsert(({
      'liked': FieldValue.arrayUnion([id])
    }));
  }
}
