import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
