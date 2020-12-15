import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:onepic/routing/router.gr.dart';
import 'package:onepic/services/create_one.dart';
import 'package:onepic/services/global.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/services/storage.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _finalImage;
  File _originalImage;

  final picker = ImagePicker();
  final oneCreator = OneCreator();

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _originalImage.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          showCropGrid: false,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: false,
          statusBarColor: Colors.black,
          cropFrameColor: Colors.black,
          activeControlsWidgetColor: Colors.pink,
          backgroundColor: Colors.black,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      _finalImage = cropped ?? _finalImage;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    final cropped = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          showCropGrid: false,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: false,
          statusBarColor: Colors.black,
          cropFrameColor: Colors.black,
          activeControlsWidgetColor: Colors.pink,
          backgroundColor: Colors.black,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      if (cropped != null) {
        _finalImage = File(cropped.path);
        _originalImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CloudStorageService storage = CloudStorageService();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: AppColors.purple),
              ),
              onPressed: () async {
                _showUploadDialog(context);
                var newId = await oneCreator.addOneToDb(context);
                CloudStorageResult storageResult = await storage.uploadImage(
                    imageToUpload: _finalImage, id: newId);
                await oneCreator.setUrl(newId, storageResult.imageUrl);
                var count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            ),
          ),
        ],
        centerTitle: false,
        title: Text("Reset your One",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: _finalImage == null
                  ? Text('No image selected.')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: Image.file(
                          _finalImage,
                          /* fit: BoxFit.fill,
                          height: 400,
                          width: 400, */
                        ),
                      ),
                    ),
            ),
          ),
          _finalImage == null
              ? Container()
              : IconButton(
                  icon: Icon(CupertinoIcons.pencil_outline),
                  iconSize: 40,
                  onPressed: _cropImage,
                ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.photo_camera_solid),
            onPressed: () => _getImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.photo_fill),
            onPressed: () => _getImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  _showUploadDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              'Uploading',
              style: Theme.of(context).textTheme.headline1,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Wait mate..'),
                CircularProgressIndicator(
                  backgroundColor: AppColors.purple,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
