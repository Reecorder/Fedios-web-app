import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

/* this is common upload image to firebase storage function */
class UploadImageToFirebase {
/* creating instance of firebase storage */
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> upload(
      {required Uint8List data, required String folderName}) async {
    /* Create a reference to the location you want to upload to in firebase */
    Reference reference = storage
        .ref()
        .child("$folderName/${DateTime.now().microsecondsSinceEpoch}.jpg");

    try {
      /* Upload the file to firebase */
      final uploadImage = await reference.putData(
        data,
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );

      /* Waits till the file is uploaded then stores the download url */
      String location = await reference.getDownloadURL();
      log(location.toString());

      // return the url
      return location;
    } catch (e) {
      return "";
    }
  }
}
