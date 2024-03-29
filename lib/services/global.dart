import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/models.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {
  // App Data
  static final String title = 'OnePic';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    UserModel: (data) => UserModel.fromMap(data),
    OneModel: (data) => OneModel.fromMap(data),
  };

  // Firestore References for Writes
  static final UserData<UserModel> userDataRef =
      UserData<UserModel>(collection: 'users');
  static final Collection<UserModel> usersRef =
      Collection<UserModel>(path: 'users');
/*   static final Document<UserModel> otherUserRef =
      Document<UserModel>(path: 'users'); */
  static final Collection<OneModel> onesRef =
      Collection<OneModel>(path: 'ones');
}

class AppColors {
  static const Color purple = Color.fromRGBO(131, 94, 253, 1);
  static const Color rose = Color.fromRGBO(241, 94, 253, 1);
  static const Color pink = Color.fromRGBO(253, 94, 149, 1);
  static const Color red = Color.fromRGBO(253, 94, 94, 1);
  static const Color orange = Color.fromRGBO(247, 171, 95, 1);
  static const Color yellow = Color.fromRGBO(247, 206, 95, 1);
}
