import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:shimmer/shimmer.dart';

class CarouselSliderBuilder extends StatefulWidget {
  const CarouselSliderBuilder({super.key});

  @override
  State<CarouselSliderBuilder> createState() => _CarouselSliderBuilderState();
}

class _CarouselSliderBuilderState extends State<CarouselSliderBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: FutureBuilder<List<String>>(
        future: FirebaseHelper.getBannerImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[500]!,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white, // Added a background color for testing
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          List<String> bannerUrls = snapshot.data ?? [];
          return CarouselSlider(
            items: bannerUrls.map((imageUrl) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      }),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 8,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 4),
              height: 200,
            ),
          );
        },
      ),
    );
  }
}
