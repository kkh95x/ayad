import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/providers/user_form_provider.dart';
import 'package:ayad/src/providers/user_management.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserFormComponent extends ConsumerWidget {
  const UserFormComponent({super.key, this.user});
  final AppUser? user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = user != null;
    final formGroup = ref.read(userformProvider(user));

    return AlertDialog(
      title: Text(isEdit ? user!.fullName : "إضافة زبون جديد"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.png.person.image(height: 100.h),
                SizedBox(
                  height: 20.h,
                ),
                const Row(
                  children: [Text("أسم الزبون")],
                ),
                MainTextFieldWidget(
                  control: "fullName",
                  placeholder: "*اسم الزبون",
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("رقم الجوال")],
                ),
                MainTextFieldWidget(
                    type: Type.phoneNumber, control: "phone", placeholder: ""),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("اسم المستخدم")],
                ),
                MainTextFieldWidget(
                    control: "username", placeholder: "اسم المستخدم"),
                SizedBox(
                  height: 10.h,
                ),
                const Row(
                  children: [Text("كلمة المرور")],
                ),
                MainTextFieldWidget(
                    control: "password", placeholder: "كلمة المرور"),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: "isAdmin",
                    ),
                    const Text("ادمن")
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
                      if (user == null) {
                        await ref
                            .read(userManagmentProvider.notifier)
                            .addUser(formGroup)
                            .then((value) {
                          context.pop();
                          ref.read(userformProvider(user)).reset();
                        });
                      } else {
                        await ref
                            .read(userManagmentProvider.notifier)
                            .updateUser(formGroup, user!)
                            .then((value) {
                          context.pop();
                          ref.read(userformProvider(user)).reset();
                        });
                      }
                    },
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                if (isEdit) ...[
                  DynamicButton(
                    title: "حذف",
                    onPressed: () {
                      ref
                          .read(userManagmentProvider.notifier)
                          .delete(user?.id ?? "", context)
                          .then((value) {
                        if (value == true) {
                          context.pop();
                          ref.read(userformProvider(user)).reset();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
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
