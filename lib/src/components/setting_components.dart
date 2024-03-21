import 'package:ayad/src/models/settings.dart';
import 'package:ayad/src/providers/setting_form_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsFormComponent extends ConsumerWidget {
  const SettingsFormComponent({super.key, this.settings});
  final Settings? settings;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = settings != null;
    final formGroup = ref.read(settingsformProvider(settings));
// marketInfo
// whatsAppPhone
// username
// appUrl
    return AlertDialog(
      title: const Text("الإعدادات"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Assets.png.person.image(height: 100.h),

                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("رقم الواتساب")],
                ),
                MainTextFieldWidget(
                    type: Type.phoneNumber,
                    control: "whatsAppPhone",
                    placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("الحد الأدنى لأصدار التطبيق")],
                ),
                MainTextFieldWidget(control: "minVersin", placeholder: "1.0.1"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("رابط تحميل التطبيق")],
                ),
                MainTextFieldWidget(
                  control: "appUrl",
                  placeholder: "",
                  multiLine: true,
                ),
                SizedBox(
                  height: 10.h,
                ),

                const Row(
                  children: [
                    Text(
                      "معلومات المتجر",
                    )
                  ],
                ),
                MainTextFieldWidget(
                  control: "marketInfo",
                  multiLine: true,
                  placeholder: "معلومات المتجر",
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
