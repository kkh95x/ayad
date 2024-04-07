import 'dart:io';

import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/data/supabase_product_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/providers/supabase_storge_service.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/auth/auth_state.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final getSupProductProvider = StateNotifierProvider.family<ProductsNotifer,
    AsyncValue<List<Product>>, Group>((ref, g) {
  return ProductsNotifer(
      ref.read(supabaseProductRepositoryProvider),
      ref.read(supbaseStorgeServicesProvider),
      ref.read(sharedPrefranceServiceProvider),
      g,
      ref.watch(authNotifierProvider).value)
    ..init();
});

class ProductsNotifer extends StateNotifier<AsyncValue<List<Product>>> {
  final SupabaseProductRepository _supabaseProductRepository;
  final SupaStorgeService _storgeService;
  final SharedPrefranceServce sharedPrefranceServce;
  final Group parentGroup;
  final AuthState? authState;
  bool? get isHidden {
    if (authState?.currentUser?.type == UserType.admin) {
      return null;
    } else {
      return false;
    }
  }

  ProductsNotifer(this._supabaseProductRepository, this._storgeService,
      this.sharedPrefranceServce, this.parentGroup, this.authState)
      : super(const AsyncLoading());
  Future<void> init() async {
    state = const AsyncLoading();
    try {
      final products = await _supabaseProductRepository
          .getSubProduct(parentGroup.id ?? "", isHiden: isHidden);
      state = AsyncData(products);
      sharedPrefranceServce.saveProduct(products, parentGroup.id ?? "3323232");
    } catch (e, s) {
      BotToast.showText(
          text: "حدث خطأ أثناء الإتصال بالسيرفر",
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      // print("-----> ${e.toString()}");
      final data =
          await sharedPrefranceServce.getProduct(parentGroup.id ?? "343243242");
      if (data == null) {
        state = AsyncError(e, s);
      } else {
        state = AsyncData(data);
      }
    }
  }

  Future<void> addGroup(FormGroup formGroup) async {
    if (formGroup.invalid) {
      BotToast.showText(text: "يرجى التأكد من البيانات المدخلة");
      return;
    }
    String? imageUrl = formGroup.control("imageUrl").value;
    String? imageUrlFromSupa;
    BotToast.showLoading();
    if (imageUrl != null) {
      imageUrlFromSupa = await _storgeService.saveGroupsFile(File(imageUrl),
          "main/${DateTime.now().toIso8601String().replaceAll(" ", "")}.png");
    }

    final product = Product(
      productName: formGroup.control("productName").value,
      productFullName: formGroup.control("productFullName").value ?? "",
      parentGroupId: parentGroup.id ?? 'r3424234',
      createdAt: DateTime.now(),
      imageUrl: imageUrlFromSupa,
      groupType: parentGroup.type,
      count: formGroup.control("count").value,
      description: formGroup.control("description").value,
      isHiden: formGroup.control("isHiden").value ?? false,
      makfol: formGroup.control("makfol").value,
      priority: formGroup.control("priority").value,
      productsSearching1: formGroup.control("productsSearching1").value,
      productsSearching2: formGroup.control("productsSearching2").value,
      productsSearching3: formGroup.control("productsSearching3").value,
      productsSearching4: formGroup.control("productsSearching4").value,
      type: formGroup.control("type").value,
      price: formGroup.control("price").value ?? 0.0,
    );

    await _supabaseProductRepository.create(product);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> update(FormGroup formGroup, Product product) async {
    if (formGroup.invalid) {
      BotToast.showText(text: "يرجى التأكد من البيانات المدخلة");
      return;
    }
    String? imageUrl = formGroup.control("imageUrl").value;
    String? imageUrlFromSupa;
    BotToast.showLoading();
    if (imageUrl != null && isUrl(imageUrl)) {
      imageUrlFromSupa = imageUrl;
    } else if (imageUrl != null) {
      imageUrlFromSupa = await _storgeService.saveGroupsFile(File(imageUrl),
          "main/${DateTime.now().toIso8601String().replaceAll(" ", "")}.png");
    }
    final newProduct = product.copyWith(
      productName: formGroup.control("productName").value,
      productFullName: formGroup.control("productFullName").value,
      imageUrl: imageUrlFromSupa,
      count: formGroup.control("count").value,
      description: formGroup.control("description").value,
      isHiden: formGroup.control("isHiden").value ?? false,
      makfol: formGroup.control("makfol").value,
      productsSearching1: formGroup.control("productsSearching1").value,
      productsSearching2: formGroup.control("productsSearching2").value,
      productsSearching3: formGroup.control("productsSearching3").value,
      productsSearching4: formGroup.control("productsSearching4").value,
      type: formGroup.control("type").value,
      price: formGroup.control("price").value,
      priority: formGroup.control("priority").value,
    );

    await _supabaseProductRepository.update(newProduct);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> delete(Product product) async {
    BotToast.showLoading();
    await _supabaseProductRepository.delete(product.id ?? "");
    BotToast.closeAllLoading();
    init();
  }
}
