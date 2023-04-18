import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++) ...[
          if (i == rating) ...[
            Icon(Icons.star_rate, color: Colors.grey, size: 16)
          ] else ...[
            Icon(Icons.star_rate, color: Colors.yellow, size: 16)
          ]
        ]
      ],
    );
  }
}
