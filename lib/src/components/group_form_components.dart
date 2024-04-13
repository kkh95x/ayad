import 'dart:io';

import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:ayad/src/providers/get_sub_groub_provider.dart';
import 'package:ayad/src/providers/group_form_provider.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:reactive_color_picker/reactive_color_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GroupFormComponent extends ConsumerWidget {
  const GroupFormComponent(
      {super.key,
      this.group,
      this.isMain = false,
      this.parentGroup,
      required this.groupType});
  final Group? group;
  final Group? parentGroup;
  final bool isMain;
  final GroupType groupType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(authNotifierProvider).value?.currentUser?.type ==
        UserType.admin;
    if (!isAdmin) {
      return const SizedBox();
    }

    final isEdit = group != null;
    final formGroup = ref.read(groupformProvider(group));
    final appColor = ref.read(appColorLightProvider);
    return AlertDialog(
      title: Text(isEdit ? group!.name : "إضافة مجموعة جديدة"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isMain) _imageWidget(appColor),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [
                    Text("اسم المجموعة*"),
                  ],
                ),
                MainTextFieldWidget(
                  control: "name",
                  placeholder: "",
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (!isMain) ...[
                  const Row(
                    children: [
                      Text("الاسم الثاني للمجموعة"),
                    ],
                  ),
                  MainTextFieldWidget(control: "name2", placeholder: ""),
                ],
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [
                    Text("الأولوية - الأعلى اولاََ"),
                  ],
                ),
                MainTextFieldWidget(
                  control: "priority",
                  placeholder: "",
                  type: Type.double,
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // // const Row(
                // //   children: [
                // //     Text("كود المجموعة"),
                // //   ],
                // // ),
                // // MainTextFieldWidget(
                // //     control: "groupCode", placeholder:""),
                // // SizedBox(
                // //   height: 10.h,
                // // ),

                SizedBox(
                  height: 10.h,
                ),

                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    const values = [SubType.groups, SubType.products];
                    final titles = ["مجموعة أقسام", "مجموعة منتجات"];
                    return Wrap(
                      children: values
                          .map((e) => Row(
                                children: [
                                  Radio<SubType>(
                                    value: e,
                                    groupValue:
                                        formGroup.control("subType").value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        formGroup.control("subType").value =
                                            value;
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
                  height: 10.h,
                ),
                if (!isMain) ...[
                  const Row(
                    children: [
                      Text("اللون"),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
                if (!isMain)
                  SizedBox(
                    width: double.infinity,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ReactiveSliderColorPicker(
                        formControlName: "color",
                        contrastIconColorDark:
                            ref.read(appColorLightProvider).redish,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: "isHidn",
                    ),
                    const Text("إخفاء المجموعة")
                  ],
                ),
                if (isMain)
                  Row(
                    children: [
                      ReactiveCheckbox(
                        formControlName: "isSeivce",
                      ),
                      const Text("مجموعة توصية على قطع")
                    ],
                  ),
                SizedBox(
                  height: 20.h,
                ),
                ReactiveFormConsumer(builder: (context, formGroup, child) {
                  return DynamicButton(
                    isDisabled: formGroup.invalid,
                    type: ButtonTypes.Alternative,
                    title: isEdit ? "تحديث" : "حفظ",
                    radius: 8,
                    onPressed: () async {
                      if (isMain) {
                        if (isEdit) {
                          await ref
                              .read(getAllGroupProvider(groupType).notifier)
                              .update(formGroup, group!);
                          if (context.mounted) {
                            context.pop();
                          }
                        } else {
                          await ref
                              .read(getAllGroupProvider(groupType).notifier)
                              .addGroup(formGroup);
                          formGroup.reset();
                        }
                      } else {
                        if (parentGroup != null) {
                          if (isEdit) {
                            await ref
                                .read(
                                    getSubGroupProvider(parentGroup!).notifier)
                                .update(formGroup, group!);
                            if (context.mounted) {
                              context.pop();
                            }
                          } else {
                            await ref
                                .read(
                                    getSubGroupProvider(parentGroup!).notifier)
                                .addGroup(formGroup);
                            formGroup.reset();
                          }
                        }
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
                      await showDialog(
                        context: context,
                        builder: (context2) {
                          return AlertDialog(
                            title: const Text("تحذير"),
                            content: const Text(
                                "أنت على وشك حذف المجموعة نهائياََ , هل تريد المتابعة؟"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    if (isMain) {
                                      await ref
                                          .read(getAllGroupProvider(groupType)
                                              .notifier)
                                          .delete(group!);
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    } else {
                                      await ref
                                          .read(
                                              getSubGroupProvider(parentGroup!)
                                                  .notifier)
                                          .delete(group!);
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    }
                                    if (context2.mounted) {
                                      context2.pop();
                                    }
                                  },
                                  child: const Text("نعم")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("لا"))
                            ],
                          );
                        },
                      );
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
                width: double.infinity,
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
            
                width: double.infinity,
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

  Container _buildPickImageWidget(AppColor appColor, FormGroup formGroup) {
    return Container(
      padding: EdgeInsets.all(10.r),
      height: 200.r,
      width: double.infinity,
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
  }
}
