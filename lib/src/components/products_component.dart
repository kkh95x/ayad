import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/product_page.dart';
import 'package:ayad/src/providers/get_sub_products_provider.dart';
import 'package:ayad/src/widgets/child_warpper_animation_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/product_list_tile.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductsComponent extends StatelessWidget {
  const ProductsComponent({super.key, required this.parentGroup});
  final Group parentGroup;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(getSupProductProvider(parentGroup)).when(
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
              if (data.isEmpty) {
                return const Center(
                  child: Text("هذ القسم فارغ حالياَ"),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ChildWrpperWithAnimation(
                          animationTypes:const {
                            AnimationType.slide,
                            AnimationType.fade,
                                AnimationType.scall
                          },
                          wantKeepAlive: true,
                    child: ProductsListTileWidget(
                        onLongPress: () async {
                          if (ref
                                  .watch(authNotifierProvider)
                                  .value
                                  ?.currentUser
                                  ?.type ==
                              UserType.admin) {
                            await DilogsHelper.showProductForm(context,
                                parentGroup: parentGroup, product: data[index]);
                          }
                        },
                        onTap: () async {
                          final refresh = await context
                              .push(ProductPage.routePath, extra: data[index]);
                          if (refresh is bool && refresh) {
                            ref
                                .read(getSupProductProvider(parentGroup).notifier)
                                .init();
                          }
                        },
                        product: data[index]),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("حدث خطأ أثناء الإتصال بالسيرفر"),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(getSupProductProvider(parentGroup).notifier)
                            .init();
                      },
                      icon: const Icon(Icons.refresh),
                    )
                  ],
                ),
              );
            },
            loading: () {
              return const Center(
                child: LoadingWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
