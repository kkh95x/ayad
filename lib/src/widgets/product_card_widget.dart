import 'package:ayad/src/models/product.dart';
import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        decoration: BoxDecoration(
            color: appColor.whiteish,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: appColor.greyish,
                  offset: const Offset(1, 1)),
              BoxShadow(color: appColor.greenish, offset: const Offset(2, 2))
            ]),
        height: 100.h,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: CustomBackgroundPainter(color: appColor.redish),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: product.imageUrl == null
                    ? CircleAvatar(
                        backgroundImage: Assets.png.logo.image().image,
                        radius: 40.r,
                        backgroundColor: appColor.redish.shade200,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(product.imageUrl!),
                        radius: 40.r,
                        backgroundColor: appColor.redish.shade200,
                      )),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(10.r),
                height: 40.r,
                width: 40.r,
                padding: EdgeInsets.all(3.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appColor.whiteish,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${product.price}\$",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: appColor.greenish, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nameEnglis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: appColor.whiteish,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                    ),
                    Text(
                      product.nameArabic,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: appColor.greyish.shade200,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBackgroundPainter extends CustomPainter {
  CustomBackgroundPainter({
    required this.color,
  });
  Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.66);
    path.lineTo(size.width, size.height * 0.3);

    // path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
