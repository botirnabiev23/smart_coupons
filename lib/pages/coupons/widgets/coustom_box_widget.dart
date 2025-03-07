import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBox({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            child: const Center(
              child: Icon(Icons.close, size: 24, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
