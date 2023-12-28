import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;

  const CustomBanner({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
    this.borderRadius = 12.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
