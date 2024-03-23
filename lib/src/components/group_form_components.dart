import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/providers/group_form_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_color_picker/reactive_color_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GroupFormComponent extends ConsumerWidget {
  const GroupFormComponent({super.key, this.group});
  final Group? group;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = group != null;
    final formGroup = ref.read(groupformProvider(group));
    return AlertDialog(
      title: Text(isEdit ? group!.name : "إضافة مجموعة جديدة"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text("*اسم المنتح"),
                  ],
                ),
                MainTextFieldWidget(
                  control: "name",
                  placeholder: "",
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [
                    Text("*الاسم الثاني للمنتج"),
                  ],
                ),
                MainTextFieldWidget(control: "name", placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [
                    Text("كود المجموعة"),
                  ],
                ),
                MainTextFieldWidget(
                    control: "groupCode", placeholder:""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [
                    Text("اللون"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
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
}
