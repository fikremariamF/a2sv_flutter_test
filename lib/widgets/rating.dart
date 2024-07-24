import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final String ratingText;

  const RatingDisplay({super.key, required this.ratingText});

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'Rating\((\d+\.\d+), (\d+)\)');
    final match = regex.firstMatch(ratingText);
    if (match == null) {
      return Text('Invalid rating format');
    }

    final double rating = double.parse(match.group(1)!);
    final int reviewCount = int.parse(match.group(2)!);

    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(fullStars,
            (index) => Icon(Icons.star, color: Colors.amber, size: 24)),
        if (halfStar) Icon(Icons.star_half, color: Colors.amber, size: 24),
        if (!halfStar && fullStars < 5)
          Icon(Icons.star_border, color: Colors.amber, size: 24),
        SizedBox(width: 5),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '($reviewCount reviews)',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
