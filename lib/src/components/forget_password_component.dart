
import 'package:ayad/src/providers/user_form_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgetPasswordFormComponent extends ConsumerWidget {
  const ForgetPasswordFormComponent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = ref.read(userPasswordformProvider);

    return AlertDialog(
      title: const Text( "تغيير كلمة المرور"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const Row(
                  children: [Text("كلمة المرور الحالية")],
                ),
                MainTextFieldWidget(
                    control: "password", placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("كلمة المرور الجديدة")],
                ),
                MainTextFieldWidget(
                    control: "password2", placeholder: ""),
               SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("تاكيد كلمة المرور الجديدة")],
                ),
                MainTextFieldWidget(
                    control: "password3", placeholder: ""),
                SizedBox(
                  height: 20.h,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child)  {
                    return DynamicButton(
                      isDisabled: formGroup.invalid,
                      type: ButtonTypes.Alternative,
                      title: "تغيير كلمة المرور",
                      radius: 8,
                      onPressed: ()async {
                         ref.read(authNotifierProvider.notifier).changePassword(formGroup.control("password").value, formGroup.control("password2").value);
                         context.pop();
                         formGroup.reset();
                      },
                    );
                  }
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
