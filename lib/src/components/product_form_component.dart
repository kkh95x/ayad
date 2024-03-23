import 'dart:io';

import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/providers/products_form_component.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormComponent extends ConsumerWidget {
  const ProductFormComponent({super.key, this.product});
  final Product? product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = product != null;
    final formGroup = ref.read(productformProvider(product));

    final appColor = ref.read(appColorLightProvider);
    return AlertDialog(
      title: Text(isEdit ? product!.nameArabic : "إضافة منتج جديد"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReactiveFormConsumer(
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
                            height: 200.r,
                            width:double.infinity,
                            decoration: BoxDecoration(
                                color: appColor.greyish.shade200,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
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
                            height: 200.r,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appColor.greyish.shade200,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: Image.file(
                                File(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          _buildReplaceImage(formGroup),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("*اسم المنتح")],
                ),
                MainTextFieldWidget(
                  control: "groupName",
                  placeholder: "*اسم المنتح",
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("*الاسم الثاني للمنتج")],
                ),
                MainTextFieldWidget(
                    control: "nameArabic", placeholder: "*الاسم الثاني للمنتج"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("كود المنتج")],
                ),
                MainTextFieldWidget(
                    control: "productCode", placeholder: "كود المنتج"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("نوع المنتج")],
                ),
                MainTextFieldWidget(control: "type", placeholder: "نوع المنتج"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("سعر المنتج")],
                ),
                MainTextFieldWidget(
                    type: Type.double,
                    control: "price",
                    placeholder: "سعر المنتج"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("الكمية المتوفرة")],
                ),
                MainTextFieldWidget(
                    type: Type.double,
                    control: "count",
                    placeholder: "الكمية المتوفرة من المنتج المنتج"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("تفاصيل")],
                ),
                MainTextFieldWidget(
                  placeholder: "تفاصيل",
                  control: "description",
                  multiLine: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: "isHiden",
                    ),
                    const Text("إخفاء المنتج")
                  ],
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    final values = [true, false, null];
                    final titles = ["مكفول", "غير مكفول", "إخفاء الكفالة"];
                    return Wrap(
                      children: values
                          .map((e) => Row(
                                children: [
                                  Radio<int>(
                                    value: values.indexOf(e),
                                    groupValue: values.indexOf(
                                        formGroup.control("makfol").value),
                                    onChanged: (value) {
                                      if (value != null) {
                                        formGroup.control("makfol").value =
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
                DynamicButton(
                  type: ButtonTypes.Alternative,
                  title: isEdit ? "تحديث" : "حفظ",
                  radius: 8,
                  onPressed: () {},
                ),
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

  TextButton _buildReplaceImage(FormGroup formGroup) {
    return TextButton(
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          // Pick an image.
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            formGroup.control("imageUrl").value = image.path;
          }
        },
        child: const Text("استبدال صورة"));
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
              formGroup.control("imageUrl").value = image.path;
            }
          },
          child: const Text("إختيار صورة")),
    );
  }
}
