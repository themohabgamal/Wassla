import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselSliderBuilder extends StatefulWidget {
  const CarouselSliderBuilder({super.key});

  @override
  State<CarouselSliderBuilder> createState() => _CarouselSliderBuilderState();
}

class _CarouselSliderBuilderState extends State<CarouselSliderBuilder> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/promo1.png",
              fit: BoxFit.contain,
            ),
          ),
          Image.asset(
            "assets/images/promo2.png",
            fit: BoxFit.fitWidth,
          ),
          Image.asset(
            "assets/images/promo3.png",
            fit: BoxFit.contain,
          ),
        ].map((image) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: image,
          );
        }).toList(),
        options: CarouselOptions(
            aspectRatio: 8,
            enlargeCenterPage: true,
            autoPlay: true,
            height: 200));
  }
}
