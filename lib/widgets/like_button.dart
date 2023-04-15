import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final double size;
  final bool enabled;
  final VoidCallback? onTap;
  const LikeButton({
    super.key, 
    this.size=20,
    this.onTap,
    this.enabled=false,
    Padding
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Icon(
              CupertinoIcons.heart_fill,
              color: enabled
                ? Colors.redAccent
                : Colors.white.withOpacity(0.8),
              size: size,
            ),
            Icon(
              CupertinoIcons.heart,
              color: Colors.redAccent,
              size: size,
            ),
          ],
        ),
      ),
    );
    
  }
}