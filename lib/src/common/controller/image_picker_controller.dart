import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';

class ImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImageFromGallery() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          selectedImage.value = File(file.path!);
          Get.back();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(Get.context!)!.imagePickerGalleryError,
        backgroundColor: AppColors.error,
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (pickedImage != null) {
        selectedImage.value = File(pickedImage.path);
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(Get.context!)!.imagePickerCameraError,
        backgroundColor: AppColors.error,
      );
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
