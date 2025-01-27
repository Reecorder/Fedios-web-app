import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  // list of restaurant images
  final RxList selectedImages = [].obs;

// image picker
  Future<void> get pickImage async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
      selectedImages.refresh();
      log(selectedImages.toString());
    }
  }
}
