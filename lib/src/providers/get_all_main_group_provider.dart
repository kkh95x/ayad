import 'dart:io';

import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/data/supabase_group_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/providers/supabase_storge_service.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/auth/auth_state.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

const fakeGroups = <Group>[
  // Group(isMainGroup: true,   name: "الشاشات", name2: "", isHiden: false,imageUrl: "https://www.lifehacker.com.au/wp-content/uploads/sites/4/2021/10/12/6172902dbcbd25c7595d8d61184a28cb-scaled.jpg"),
  // Group(isMainGroup: true,   name: "الجامات", name2: "", isHiden: false,imageUrl: "https://www.lifehacker.com.au/wp-content/uploads/sites/4/2021/10/12/6172902dbcbd25c7595d8d61184a28cb-scaled.jpg"),
  // Group(isMainGroup: true,   name: "البطاريات", name2: "", isHiden: false,imageUrl: "https://4.imimg.com/data4/MP/AT/ANDROID-57535866/product-500x500.jpeg"),
  // Group(isMainGroup: true,   name: "أكسسوارات الجامات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "البفلات", name2: "", isHiden: false,imageUrl: "https://shop.baltrade.eu/img/product/allegro/Przenosny_glosnik_Bluetooth_5_0_z_odtwarzaczem_MP3_Defender_Boomer_20-9.jpg"),
  // Group(isMainGroup: true,   name: "الشاسيات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "أغطية", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "فريمات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "البصمات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "بلورات الكميرات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "بيوت السيم", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "تتشات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "أقلام", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "البوردات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "ايسيات الشحن", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "أكسسوارات الصيانة", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "أزرار البور", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "حساسات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "جكات الشحن", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "فلاتات الشحن", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "فلاتات الوصل", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "السماعات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "الكميرات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "كونكترات بوردات", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "فلاتات الرجوع", name2: "", isHiden: false),
  // Group(isMainGroup: true,   name: "كبس فلاتات الشاشات", name2: "", isHiden: false),
];
final getAllGroupProvider = StateNotifierProvider.family<MainGroupNotifer,
    AsyncValue<List<Group>>, GroupType>((ref, groupT) {
  final auth = ref.watch(authNotifierProvider).value;
  return MainGroupNotifer(
      ref.read(supabaseGroupRepositoryProvider),
      ref.read(supbaseStorgeServicesProvider),
      ref.read(sharedPrefranceServiceProvider),
      auth,
      groupT)
    ..init();
});

class MainGroupNotifer extends StateNotifier<AsyncValue<List<Group>>> {
  final SupabaseGroupRepository _supabaseGroupRepository;
  final SupaStorgeService _storgeService;
  final AuthState? authState;
  final SharedPrefranceServce sharedPrefranceServce;
  final GroupType? groupType;

  bool? get isHiden {
    if (authState?.currentUser?.type == UserType.admin) {
      return null;
    } else {
      return false;
    }
  }

  MainGroupNotifer(this._supabaseGroupRepository, this._storgeService,
      this.sharedPrefranceServce, this.authState, this.groupType)
      : super(const AsyncLoading());
  Future<void> init() async {
    state = const AsyncLoading();
    try {
      final groups = await _supabaseGroupRepository.getMainGroup(
          isHiden: isHiden, groupType: groupType);
      sharedPrefranceServce.saveGroups(groups);
      state = AsyncData(groups);
    } catch (e, s) {
      BotToast.showText(
          text: "حدث خطأ أثناء الإتصال بالسيرفر",
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      // print("-----> ${e.toString()}");
      final data = await sharedPrefranceServce.getGroups();
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
    final group = Group(
        name: formGroup.control("name").value,
        type: groupType ?? GroupType.vistor,
        subType: formGroup.control("subType").value,
        parentGroupId: "",
        isMainGroup: true,
        priority: formGroup.control("priority").value,
        isSeivce: formGroup.control("isSeivce").value,
        createdAt: DateTime.now(),
        imageUrl: imageUrlFromSupa,
        isHiden: formGroup.control("isHidn").value ?? false);

    await _supabaseGroupRepository.create(group);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> update(FormGroup formGroup, Group group) async {
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
    final newGroup = group.copyWith(
        name: formGroup.control("name").value,
        subType: formGroup.control("subType").value,
        parentGroupId: "",
        isMainGroup: true,
        createdAt: DateTime.now(),
        isSeivce: formGroup.control("isSeivce").value,
        priority: formGroup.control("priority").value,
        imageUrl: imageUrlFromSupa,
        isHiden: formGroup.control("isHidn").value ?? false);

    await _supabaseGroupRepository.update(newGroup);
    BotToast.closeAllLoading();
    init();
  }

  Future<void> delete(Group group) async {
    BotToast.showLoading();
    await _supabaseGroupRepository.delete(group.id ?? "");
    BotToast.closeAllLoading();
    init();
  }
}
