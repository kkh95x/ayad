import 'package:ayad/src/components/products_component.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key, required this.group});
  static String get routeName => "products-page";
  static String get routePath => "/$routeName";
  final Group group;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
        title: group.name,
        child: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            children: [
               TextSearchWidget(parentGroup: group),
              SizedBox(height: 50.h,),
              ProductsComponent(parentGroup: group,)
            ],
          ),
        ));
  }
}

