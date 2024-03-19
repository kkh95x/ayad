import 'package:ayad/core/models/group.dart';
import 'package:ayad/core/pages/page_template.dart';
import 'package:ayad/core/pages/product_page.dart';
import 'package:ayad/core/providers/get_sub_products_provider.dart';
import 'package:ayad/core/widgets/product_list_tile.dart';
import 'package:ayad/core/widgets/type_ahead_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
              const TextSearchWidget(),
              SizedBox(height: 50.h,),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(getSupProductProvider).when(
                      data: (data) {
                        // return Center(
                        //     child: GridView.builder(
                        //       itemCount: data.length,
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisSpacing: 10,
                        //               mainAxisSpacing: 10,
                        //                 crossAxisCount: 2),

                        //         itemBuilder: (context, index) {
                        //           return ProductCardWidget(product: data[index]);
                        //         },));
                        if(data.isEmpty){
                          return const Center(
                            child: Text("هذ القسم فارغ حالياَ"),
                          );
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ProductsListTileWidget(
                              onTap: () {
                                context.push(ProductPage.routePath,extra: data[index]);
                              },
                                product: data[index]);
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return const Center(
                          child: Text("Error"),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
