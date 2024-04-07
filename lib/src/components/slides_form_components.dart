import 'dart:io';

import 'package:ayad/src/models/slides.dart';
import 'package:ayad/src/providers/slides_admin_provider.dart';
import 'package:ayad/src/providers/slides_form_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:image_picker/image_picker.dart';

class SlidesFormComponent extends ConsumerWidget {
  const SlidesFormComponent({super.key, this.slide});
  final Slide? slide;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = slide != null;
    final formGroup = ref.read(slidesFormProvider(slide));

    final appColor = ref.read(appColorLightProvider);
    final isAdmin = ref.watch(authNotifierProvider).value?.currentUser?.type ==
        UserType.admin;
    if (!isAdmin) {
      return const SizedBox();
    }
    return AlertDialog(
      title: Text(isEdit ? slide!.title : "إضافة إعلان جديد"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _imageWidget(appColor),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("العنوان الرئيسي*")],
                ),
                MainTextFieldWidget(
                  control: "title",
                  placeholder: "",
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("العنوان الفرعي الأيمن*")],
                ),
                MainTextFieldWidget(control: "right", placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("العنوان الفرعي الأيسر")],
                ),
                MainTextFieldWidget(control: "left", placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: "isHiden",
                    ),
                    const Text("إخفاء الإعلان")
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("نوع الجمهور")],
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    final values = [
                      SlidesType.customer,
                      SlidesType.vistor,
                      SlidesType.all
                    ];
                    final titles = ["الزبائن", "الزوار", "الكل"];
                    return Wrap(
                      children: values
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<int>(
                                    value: values.indexOf(e),
                                    groupValue: values.indexOf(
                                        formGroup.control("slidesType").value ??
                                            SlidesType.all),
                                    onChanged: (value) {
                                      if (value != null) {
                                        formGroup.control("slidesType").value =
                                            values[value];
                                      }
                                    },
                                  ),
                                  Text(titles[values.indexOf(e)])
                                ],
                              ))
                          .toList(),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                ReactiveFormConsumer(builder: (context, formGroup, child) {
                  return DynamicButton(
                    type: ButtonTypes.Alternative,
                    title: isEdit ? "تحديث" : "حفظ",
                    radius: 8,
                    onPressed: () async {
                      if (isEdit) {
                        await ref
                            .read(slideNotiferProvider.notifier)
                            .update(formGroup, slide!)
                            .then((value) {
                          context.pop();
                          formGroup.reset();
                        });
                      } else {
                        await ref
                            .read(slideNotiferProvider.notifier)
                            .addSlide(formGroup)
                            .then((value) {
                          formGroup.reset();
                        });
                      }
                    },
                  );
                }),
                if (isEdit) ...[
                  SizedBox(
                    height: 10.h,
                  ),
                  DynamicButton(
                    title: "حذف",
                    onPressed: () async {
                      await ref
                          .read(slideNotiferProvider.notifier)
                          .delete(slide!)
                          .then((value) {
                        context.pop();
                        formGroup.reset();
                      });
                    },
                  ),
                ],
                SizedBox(
                  height: 10.h,
                ),
                DynamicButton(
                  title: "العودة",
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          )),
    );
  }

  ReactiveFormConsumer _imageWidget(AppColor appColor) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, child) {
        final imageUrl = formGroup.control("imageUrl").value;
        if (imageUrl == null) {
          return _buildPickImageWidget(appColor, formGroup);
        }
        if (isUrl(imageUrl)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                //  constraints: const BoxConstraints(maxHeight: 500),
                height: 150,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: appColor.greyish.shade200,
                    borderRadius: BorderRadius.circular(4.r)),
                child: AspectRatio(
                  aspectRatio: (3 / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              _buildReplaceImage(formGroup),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                height: 150,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: appColor.greyish.shade200,
                    borderRadius: BorderRadius.circular(4.r)),
                child: AspectRatio(
                  aspectRatio: (3 / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              _buildReplaceImage(formGroup),
            ],
          );
        }
      },
    );
  }

  Widget _buildReplaceImage(FormGroup formGroup) {
    return Row(
      children: [
        // const ImageCropperButtonWidget(controle: "imageUrl"),
        TextButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              // Pick an image.
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
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
                  ],
                );
                if (croppedFile != null) {
                  final imageUrlCropper = croppedFile.path;
                  formGroup.control("imageUrl").value = imageUrlCropper;
                }
              }
            },
            child: const Text("استبدال صورة")),
      ],
    );
  }

  bool isUrl(String string) {
    // Regular expression to check if the string starts with http://, https://, or www.
    RegExp urlRegExp = RegExp(
        r'^(?:http|https)?(?::\/\/)?(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+[\S]*$');
    return urlRegExp.hasMatch(string);
  }

  Widget _buildPickImageWidget(AppColor appColor, FormGroup formGroup) {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.all(10.r),
        height: 150,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
            color: appColor.greyish.shade200,
            borderRadius: BorderRadius.circular(4.r)),
        child: TextButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              // Pick an image.
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                final ImagePicker picker = ImagePicker();
                // Pick an image.
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  CroppedFile? croppedFile = await ImageCropper().cropImage(
                    sourcePath: image.path,
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
                    ],
                  );
                  if (croppedFile != null) {
                    final imageUrlCropper = croppedFile.path;
                    formGroup.control("imageUrl").value = imageUrlCropper;
                  }
                }
              }
            },
            child: const Text("إختيار صورة")),
      );
    });
  }
}
