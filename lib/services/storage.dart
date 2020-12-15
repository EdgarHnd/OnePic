import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String id,
  }) async {
    var imageFileName = 'users_pics/' + id;

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    await for (var event in uploadTask.snapshotEvents) {
      if (event.state == TaskState.success) {
        var downloadUrl = await event.ref.getDownloadURL();
        var url = downloadUrl.toString();
        return CloudStorageResult(
          imageUrl: url,
          id: id,
        );
      }
    }

    return null;
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String id;

  CloudStorageResult({this.imageUrl, this.id});
}
