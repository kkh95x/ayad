import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperButtonWidget extends StatelessWidget {
  const ImageCropperButtonWidget({super.key, required this.controle});
  final String controle;
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(builder: (context, formGroup, child) {
      final imageUrl = formGroup.control(controle).value;
      if (imageUrl == null) {
        return const SizedBox();
      }
      return TextButton.icon(
          onPressed: () async {
            if (kIsWeb) {
              formGroup.control("imageUrl").value = imageUrl;
              return;
            }
            CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: imageUrl,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
              uiSettings: [
                AndroidUiSettings(
                    toolbarTitle: 'Cropper',
                    toolbarColor: Colors.red,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
                IOSUiSettings(
                  title: 'Cropper',
                ),
                WebUiSettings(
                  context: context,
                ),
              ],
            );
            if (croppedFile != null) {
              final imageUrlCropper = croppedFile.path;
              formGroup.control(controle).value = imageUrlCropper;
            }
          },
          icon: const Icon(Icons.crop),
          label: const Text("قص"));
    });
  }
}
