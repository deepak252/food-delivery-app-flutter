
import 'package:flutter/material.dart';

class RatingTile extends StatelessWidget {
  final double rating;
  const RatingTile({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${rating}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),
          ),
          Icon(
            Icons.star, 
            size: 14, color: 
            Colors.white,
          )
        ],
      ),
    );
  }
}