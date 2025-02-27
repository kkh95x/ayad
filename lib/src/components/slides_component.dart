import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/providers/slides_admin_provider.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlidesComponent extends StatefulWidget {
  const SlidesComponent({super.key});

  @override
  State<SlidesComponent> createState() => _SlidesComponentState();
}

class _SlidesComponentState extends State<SlidesComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Consumer(builder: (context, ref, child) {
        final appColor = ref.read(appColorLightProvider);
        return ref.watch(slideNotiferProvider).when(
            data: (data) {
              return Container(
                decoration: BoxDecoration(
                    color: appColor.greyish.shade400,
                    borderRadius: BorderRadius.circular(4)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CustomCarouselSlider(
                      items: data.isEmpty
                          ? <CarouselItem>[
                              CarouselItem(
                                boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  // gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.center)
                                ),
                                image:
                                    Assets.captchaImages.image2.image().image,
                                title: 'أهلاّّ وسهلاََ بكم',

                                titleTextStyle: const TextStyle(
                                    fontSize: 12,
                                    //  backgroundColor: Colors.black.withOpacity(.1),

                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 6,
                                          offset: Offset(1, 1),
                                          spreadRadius: 5)
                                    ]),

                                // leftSubtitle: '',
                                // rightSubtitle: 'v1.0.0',
                                rightSubtitleTextStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                          spreadRadius: 3)
                                    ]),
                                leftSubtitleTextStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                          spreadRadius: 3)
                                    ]),
                                onImageTap: (i) {},
                              ),
                            ]
                          : data
                              .map(
                                (e) => CarouselItem(
                                  boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.center)
                                  ),
                                  image: CachedNetworkImageProvider(e.imageUrl),
                                  title: e.title,
                                  titleTextStyle: const TextStyle(
                                      fontSize: 12,
                                      //  backgroundColor: Colors.black.withOpacity(.1),

                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 6,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5)
                                      ]),
                                  leftSubtitle: e.left,
                                  rightSubtitle: e.right,
                                  rightSubtitleTextStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                            spreadRadius: 3)
                                      ]),
                                  leftSubtitleTextStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                            spreadRadius: 3)
                                      ]),
                                  onImageTap: (i) {
                                    final isAdmin = ref
                                            .watch(authNotifierProvider)
                                            .value
                                            ?.currentUser
                                            ?.type ==
                                        UserType.admin;
                                    if (isAdmin) {
                                      DilogsHelper.showSlides(context,
                                          slide: e);
                                    }
                                  },
                                ),
                              )
                              .toList(),
                      height: 150,
                      subHeight: 50,
                      width: MediaQuery.of(context).size.width * .9,
                      autoplay: true,
                      showText: true,
                      // showSubBackground: true,
                      autoplayDuration: const Duration(seconds: 5),
                      indicatorShape: BoxShape.circle,
                      selectedDotColor: appColor.redish,
                      unselectedDotColor: appColor.whiteish),
                ),
              );
            },
            error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => Container(
                  decoration: BoxDecoration(
                      color: appColor.greyish.shade400,
                      borderRadius: BorderRadius.circular(4)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomCarouselSlider(
                        items: <CarouselItem>[
                          CarouselItem(
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.center)
                            ),
                            image: Assets.captchaImages.image2.image().image,
                            title: 'أهلاّّ وسهلاََ بكم',
                            titleTextStyle: const TextStyle(
                                fontSize: 12,
                                //  backgroundColor: Colors.black.withOpacity(.1),

                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 6,
                                      offset: Offset(1, 1),
                                      spreadRadius: 5)
                                ]),
                            rightSubtitleTextStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      spreadRadius: 3)
                                ]),
                            leftSubtitleTextStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      spreadRadius: 3)
                                ]),
                            onImageTap: (i) {},
                          ),
                        ],
                        height: 150,
                        subHeight: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        autoplay: true,
                        showText: true,
                        // showSubBackground: true,
                        autoplayDuration: const Duration(seconds: 5),
                        indicatorShape: BoxShape.circle,
                        selectedDotColor: appColor.redish,
                        unselectedDotColor: appColor.whiteish),
                  ),
                ));
      }),
    );
  }
}
