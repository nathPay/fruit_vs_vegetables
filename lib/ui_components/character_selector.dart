import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Carousel to choose character
class CharacterSelector extends HookWidget {
  const CharacterSelector({
    Key? key,
    required this.page,
  }) : super(key: key);

  final ValueNotifier<int> page;

  @override
  Widget build(BuildContext context) {
    final List<String> fruits = [
      'assets/fruits/1.png',
      'assets/fruits/2.png',
      'assets/fruits/3.png',
      'assets/fruits/4.png',
      'assets/fruits/5.png',
      'assets/fruits/6.png',
      'assets/fruits/7.png',
      'assets/fruits/8.png',
      'assets/fruits/9.png',
      'assets/fruits/10.png'
    ];

    return Container(
      child: CarouselSlider(
        items: fruits
            .map(
              (fruit) => Container(
                child: Image.asset(fruit),
              ),
            )
            .toList(),
        options: CarouselOptions(
          aspectRatio: 2.0,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            page.value = index;
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
