import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'image_uploader.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _finalImage;
  File _originalImage;
  final picker = ImagePicker();

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
              ),
              onPressed: () => Navigator.of(context).pop(),
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
          _finalImage == null
              ? Container()
              : Uploader(
                  file: _finalImage,
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
}
