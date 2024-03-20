import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';

final formProvider = Provider((ref) => FormGroup({
      "username": FormControl<String>(),
      "password": FormControl<String>(),
      "obs": FormControl<bool>(value: false)
    }));

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  static String get routeName => "login";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.read(formProvider);
    return PageTemplate(
        child: ReactiveForm(
      formGroup: form,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
          ),
          LottieBuilder.asset(
            Assets.json.login,
            repeat: true,
            height: 150.h,
            fit: BoxFit.cover,
          ),
          MainTextFieldWidget(
            
            suffixIcon: const Icon(Icons.person),
            placeholder: "اسم المستخدم",
            control: "username",
          ),
          SizedBox(
            height: 10.h,
          ),
          MainTextFieldWidget(
            suffixIcon: const Icon(Icons.password),
            placeholder: "كلمة المرور",
            control: "password",
          ),
          SizedBox(
            height: 20.h,
          ),
          DynamicButton(
            title: "تسجيل الدخول",
            onPressed: () {
              ref.read(authNotifierProvider.notifier).login();
            },
          )
        ],
      ),
    ));
  }
}
