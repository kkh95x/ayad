import 'package:ayad/src/components/forget_password_component.dart';
import 'package:ayad/src/components/group_form_components.dart';
import 'package:ayad/src/components/product_form_component.dart';
import 'package:ayad/src/components/setting_components.dart';
import 'package:ayad/src/components/slides_form_components.dart';
import 'package:ayad/src/components/user_form_componet.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/models/slides.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';

bool isUrl(String string) {
  // Regular expression to check if the string starts with http://, https://, or www.
  RegExp urlRegExp = RegExp(
      r'^(?:http|https)?(?::\/\/)?(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+[\S]*$');
  return urlRegExp.hasMatch(string);
}

class DilogsHelper {
  static Future<void> showGroupForm(BuildContext context,
      {Group? group, bool isMain = false, Group? parentGroup,required GroupType groupType}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GroupFormComponent(
          groupType: groupType,
          group: group,
          parentGroup: parentGroup,
          isMain: isMain,
        );
      },
    );
  }

  static Future<void> showProductForm(BuildContext context,
      {Product? product, required Group parentGroup}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ProductFormComponent(
          product: product,
          parentGroup: parentGroup,
        );
      },
    );
  }

  static Future<void> showUserForm(BuildContext context,
      {AppUser? user}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return UserFormComponent(
          user: user,
        );
      },
    );
  }

  static Future<void> showSettingsForm(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const SettingsFormComponent();
      },
    );
  }

  static Future<void> showForgetPasswordForm(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const ForgetPasswordFormComponent();
      },
    );
  }

  static Future<void> showSlides(BuildContext context, {Slide? slide}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SlidesFormComponent(
          slide: slide,
        );
      },
    );
  }
}
