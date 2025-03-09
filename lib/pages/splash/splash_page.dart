import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6600E4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44),
            child: SvgPicture.asset('assets/images/union.svg'),
          ),
          const Gap(48),
          Text(
            'Discount Hub',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Smart Coupons',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // ignore: use_full_hex_values_for_flutter_colors
              color: Color(0xffffffffcc),
            ),
          ),
        ],
      ),
    );
  }
}
