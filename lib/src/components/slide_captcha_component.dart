import 'dart:math';

import 'package:ayad/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_captcha.dart';

final _images = [
  Assets.captchaImages.image1.path,
  Assets.captchaImages.image2.path,
  Assets.captchaImages.image3.path,
];
Future<bool> showSlideCaptchaSlider(BuildContext context) async {
  final randomIndex = Random().nextInt(_images.length);
  SliderController? controller = SliderController();

  final value = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SliderCaptcha(
          controller: controller,
          title: "اسحب للتحقق من إختبار الروبوت",
          image: Image.asset(
            _images[randomIndex],
            fit: BoxFit.fitWidth,
          ),
          colorBar: Colors.blue,
          colorCaptChar: Colors.blue,
          onConfirm: (value) async {
            if (value == true) {
              Navigator.of(context).pop(true);
            }else{
        
            return await Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                controller.create.call();
              },
            );
            }
          },
        ),
      );
    },
  );
  return value == true;
}
