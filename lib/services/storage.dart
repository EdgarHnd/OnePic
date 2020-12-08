import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  Future<String> loadImage(String image) async {
    return await FirebaseStorage.instance
        .ref('users_pics')
        .child(image)
        .getDownloadURL();
  }
}
