import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/backgrounds/AANMAI.jpg',
      'assets/images/backgrounds/bookclub.jpg',
      'assets/images/backgrounds/team.jpg',
      'assets/images/backgrounds/discord.jpg'
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset(item, fit: BoxFit.fill, width: 1000.0)),
        ))
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1.5,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}
