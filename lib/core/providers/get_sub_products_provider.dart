import 'package:ayad/core/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const fakeSubProducts = <Product>[
  Product(
      nameEnglis: "WF",
      groupName: "شاشات سامسونغ A01",
      nameArabic: "دبليو أف",
      price: 40,
      description:
          "شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي",
      count: 12,
      makfol: true,
      productCode: "LC232334",
      type: "أصلي"),
  Product(
      nameEnglis: "Omlide",
      groupName: "شاشات سامسونغ A01",

      imageUrl:
          "https://atlas-content-cdn.pixelsquid.com/assets_v2/244/2448810350577980946/jpeg-600/G11.jpg?modifiedAt=1",
      nameArabic: "أومليد",
      price: 70,
      count: 120,
      type: "تقليد",
      productCode: "LC232334",
      makfol: false,
      description:
          "شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي"),
  Product(
      nameEnglis: "China Service",
      nameArabic: "سيرفس صيني",
      makfol: true,      groupName: "شاشات سامسونغ A01",

      imageUrl:
          "https://ae01.alicdn.com/kf/S214c97682eec48e3820898c6b4b81f29u/LCD-For-BLUBOO-S8-Plus-Touch-Screen-Display-Original-MTK6750T-Octa-Core-6-0Inch-Mobile-Phone.jpg",
      price: 60,
      productCode: "LC232334",
      type: "أصلي",
      description:
          "شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي"),
  Product(
      nameEnglis: "TFT",
      nameArabic: "تي أف تي",      groupName: "شاشات سامسونغ A01",

      price: 65.5,
      productCode: "LC232334",
      description:
          "شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي شرح تفاصيل عن المنتج الحالي"),
];
final getSupProductProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return fakeSubProducts;
});
