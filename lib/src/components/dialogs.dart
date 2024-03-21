import 'package:ayad/src/components/forget_password_component.dart';
import 'package:ayad/src/components/group_form_components.dart';
import 'package:ayad/src/components/product_form_component.dart';
import 'package:ayad/src/components/setting_components.dart';
import 'package:ayad/src/components/user_form_componet.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:ayad/src/models/user.dart';
import 'package:flutter/material.dart';

class DilogsHelper {
  static Future<void> showGroupForm(BuildContext context,
      {Group? group}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GroupFormComponent(
          group: group,
        );
      },
    );
  }

  static Future<void> showProductForm(BuildContext context,
      {Product? product}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ProductFormComponent(
          product: product,
        );
      },
    );
  }

  static Future<void> showUserForm(BuildContext context, {User? user}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return UserFormComponent(
          user: user,
        );
      },
    );
  }
  static Future<void> showSettingsForm(BuildContext context, {Settings? settings}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SettingsFormComponent(
          settings: settings,
        );
      },
    );
  }
   static Future<void> showForgetPasswordForm(BuildContext context, ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const ForgetPasswordFormComponent(
        );
      },
    );
  }
}
