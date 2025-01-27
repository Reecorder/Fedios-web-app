import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class CommonImagePicker {
  /* image picker instance */
  static final picker = ImagePicker();

  /* picking image function from gallery */
  static Future<Uint8List> get pick async {
    try {
      /* image source */
      const imageSource = ImageSource.gallery;

      /* trying to pick image from gallery */
      final xfile = await picker.pickImage(source: imageSource);

      if (xfile != null) {
        return await xfile.readAsBytes();
      } else {
        return Uint8List(0);
      }
    } catch (e) {
      return Uint8List(0);
    }
  }

  static Future<List<Uint8List>> get pickImages async {
    try {
      List<Uint8List> list = [];
      final xfiles = await picker.pickMultiImage();
      for (var file in xfiles) {
        final uint8list = await file.readAsBytes();
        list.add(uint8list);
      }
      return list;
    } catch (e) {
      return [];
    }
  }
}
