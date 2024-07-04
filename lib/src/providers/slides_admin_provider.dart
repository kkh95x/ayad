

import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/data/supabase_slides_repository.dart';
import 'package:ayad/src/models/slides.dart';
import 'package:ayad/src/providers/supabase_storge_service.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/auth/auth_state.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

final slideNotiferProvider =
    StateNotifierProvider<SlidesNotifer, AsyncValue<List<Slide>>>((ref) {
  return SlidesNotifer(
      ref.read(supabaseSlideRepositoryProvider),
      ref.read(supbaseStorgeServicesProvider),
      ref.read(sharedPrefranceServiceProvider),
      ref.watch(authNotifierProvider).value)..init();
});

class SlidesNotifer extends StateNotifier<AsyncValue<List<Slide>>> {
  final SupabaseSlidesRepository _slidesRepository;
  final SupaStorgeService _storgeService;
  final SharedPrefranceServce sharedPrefranceServce;
  final AuthState? authState;
  SlidesNotifer(this._slidesRepository, this._storgeService,
      this.sharedPrefranceServce, this.authState)
      : super(const AsyncLoading());
  SlidesType? get _slidesType {
    if (authState?.currentUser?.type == UserType.admin) {
      return null;
    } else if (authState?.currentUser?.type == UserType.customer) {
      return SlidesType.customer;
    } else if (authState?.currentUser?.type == UserType.anon) {
      return SlidesType.vistor;
    }
    return null;
  }

  Future<void> init() async {
    state = const AsyncLoading();
    try {
      if (authState?.authStatus != AuthStatus.authorized) {
        return;
      }
      final slides = await _slidesRepository.get(slidesType: _slidesType);
      state = AsyncData(slides);
      sharedPrefranceServce.saveSlides(slides);
    } catch (e, s) {
      BotToast.showText(
          text: "حدث خطأ أثناء الإتصال بالسيرفر",
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      final data = await sharedPrefranceServce.getSlides();
      if (data == null) {
        state = AsyncError(e, s);
      } else {
        state = AsyncData(data);
      }
    }
  }

  Future<void> addSlide(FormGroup formGroup) async {
    if (formGroup.invalid) {
      BotToast.showText(text: "يرجى التأكد من البيانات المدخلة");
      return;
    }
    String? imageUrl = formGroup.control("imageUrl").value;
    String? imageUrlFromSupa;
    BotToast.showLoading();
    if (imageUrl != null) {
      imageUrlFromSupa = await _storgeService.saveGroupsFile(XFile(imageUrl),
          "main/${DateTime.now().toIso8601String().replaceAll(" ", "")}.png");
    }
    final group = Slide(
        title: formGroup.control("title").value,
        left: formGroup.control("left").value,
        right: formGroup.control("right").value,
        imageUrl: imageUrlFromSupa ?? "",
        createdAt: DateTime.now(),
        slidesType: formGroup.control("slidesType").value??SlidesType.all,
        isHiden: formGroup.control("isHiden").value ?? false);

    await _slidesRepository.create(group);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> update(FormGroup formGroup, Slide slide) async {
    String? imageUrl = formGroup.control("imageUrl").value;
    if (formGroup.invalid || imageUrl == null) {
      BotToast.showText(text: "يرجى التأكد من البيانات المدخلة");
      return;
    }
    String? imageUrlFromSupa;
    BotToast.showLoading();

    if (isUrl(imageUrl)) {
      imageUrlFromSupa = imageUrl;
    } else {
      imageUrlFromSupa = await _storgeService.saveGroupsFile(XFile(imageUrl),
          "main/${DateTime.now().toIso8601String().replaceAll(" ", "")}.png");
    }
    final newSlide = slide.copyWith(
        title: formGroup.control("title").value,
        left: formGroup.control("left").value,
        right: formGroup.control("right").value,
        imageUrl: imageUrlFromSupa ?? "",
        slidesType: formGroup.control("slidesType").value,
        isHiden: formGroup.control("isHiden").value ?? false);

    await _slidesRepository.update(newSlide);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> delete(Slide slide) async {
    BotToast.showLoading();
    await _slidesRepository.delete(slide.id ?? "");
    BotToast.closeAllLoading();
    init();
  }
}
