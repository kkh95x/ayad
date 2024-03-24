
import 'package:ayad/theme.dart';
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
  List<CarouselItem> itemList = [
   for(int i=0;i<5;i++)
    CarouselItem(
      boxDecoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        // gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.center)
      ),
      image:  CachedNetworkImageProvider(
        ["https://cdn2.bigcommerce.com/n-nr1m3w/cnam78/product_images/uploaded_images/welcome-003.jpg",
        'https://www.americanblanketcompany.com/cdn/shop/articles/blanketsforcoldnightscold_winters_2500x_e4aa93e7-3785-4801-88fc-debd31c9ec44_1600x.webp?v=1690230217',
        "https://www.mediastorehouse.com/p/251/pine-forest-winter-lapland-finland-19945339.jpg.webp"
  ][i%3]),
      title: '${i+1} عنوان النص عنوان النص',
    
      titleTextStyle:const  TextStyle(
        fontSize: 12,
        //  backgroundColor: Colors.black.withOpacity(.1),
         
        color: Colors.white,
        shadows: [BoxShadow(color: Colors.black,blurRadius: 6,offset: Offset(1, 1),spreadRadius: 5)]
      ),
      
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      rightSubtitleTextStyle:const TextStyle(
        fontSize: 12,
        color: Colors.white,
        shadows: [BoxShadow(color: Colors.black,blurRadius: 2,offset: Offset(0, 0),spreadRadius: 3)]
      ) ,
      leftSubtitleTextStyle:const TextStyle(
        fontSize: 12,
        color: Colors.white,
        shadows: [BoxShadow(color: Colors.black,blurRadius: 2,offset: Offset(0, 0),spreadRadius: 3)]
      ) ,
      onImageTap: (i) {},
    
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Consumer(builder: (context, ref, child) {
        final appColor = ref.read(appColorLightProvider);
        return Container(
         
          decoration: BoxDecoration( color: appColor.greyish.shade400,  borderRadius: BorderRadius.circular(4)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CustomCarouselSlider(
              items: itemList,
              height: 150,
              subHeight: 50,
              width: MediaQuery.of(context).size.width * .9,
              autoplay: true,
              showText: true,
              // showSubBackground: true,
              autoplayDuration: const Duration(seconds: 5),
              indicatorShape: BoxShape.circle,
              selectedDotColor: appColor.redish,
              unselectedDotColor: appColor.whiteish
            ),
          ),
        );
      }),
    );
  }
}
