import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/pages/product_page.dart';
import 'package:ayad/src/providers/search_provider.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';

class TextSearchWidget extends ConsumerWidget {
  const TextSearchWidget({super.key, this.parentGroup});
  final Group? parentGroup;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: TypeAheadField<Product>(
        suggestionsCallback: (search) =>
            ref.read(searchProvider((parentGroup,search)).future),
        builder: (context, controller, focusNode) {
          return TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              decoration: InputDecoration(
                fillColor: ref.read(appColorLightProvider).whiteish,
                filled: true,
                contentPadding: EdgeInsets.only(right: 20.w),
                label: Text(
                  "  البحث",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ref.read(appColorLightProvider).greyish),
                ),
                prefixIcon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ref.read(appColorLightProvider).redish),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: ref.read(appColorLightProvider).redish),
                  child: Icon(
                    Icons.search,
                    color: ref.read(appColorLightProvider).whiteish,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ref.read(appColorLightProvider).greyish),
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ref.read(appColorLightProvider).redish),
                    borderRadius: BorderRadius.circular(
                      4,
                    )),
              ));
        },
        loadingBuilder: (context) {
          return Container(
            height: 100.h,
            padding: EdgeInsets.all(20.r),
            color: ref.read(appColorLightProvider).whiteish,
            child: const Center(
              child: LoadingWidget(),
            ),
          );
        },
        errorBuilder: (context, error) {
          return Container(
              color: ref.read(appColorLightProvider).whiteish,
              child: const Center(
                child: Text("حدث خطأ"),
              ));
        },
        emptyBuilder: (context) {
          return Container(
              color: ref.read(appColorLightProvider).whiteish,
              child: const Center(
                child: Text("لاتوجد نتائج"),
              ));
        },
        listBuilder: (context, children) {
          if (children.isEmpty) {
            return const Center(
              child: Text("لاتوجد نتائج"),
            );
          }
          return SingleChildScrollView(
            child: Material(
              elevation: 6,
              child: Container(
                color: ref.read(appColorLightProvider).whiteish,
                child: Column(
                  children: children
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        },
        itemBuilder: (context, product) {
          return ListTile(
            leading: const Icon(Icons.search),
            title: Text(product.productFullName),
            trailing: Text("${product.price}\$"),
          );
        },
        onSelected: (product) {
          context.push(ProductPage.routePath, extra: product);
        },
      ),
    );
  }
}
