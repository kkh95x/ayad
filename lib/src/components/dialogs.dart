import 'package:ayad/src/components/group_form_components.dart';
import 'package:ayad/src/components/product_form_component.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:flutter/material.dart';

class DilogsHelper {
  static Future<void> showGroupForm(BuildContext context,
      {Group? group}) async {
  await  showDialog(
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
  await  showDialog(
      context: context,
      builder: (context) {
        return ProductFormComponent(
          product: product,
        );
      },
    );
  }
}
