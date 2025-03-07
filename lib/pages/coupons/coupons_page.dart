import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupons_bottom_sheet_widget.dart';

class CouponsPage extends StatelessWidget {
  final String title;

  const CouponsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          onTap: () => showNewCouponBottomSheet(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            decoration: BoxDecoration(
              color: Color(0xff6600E4).withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/coupon_icon.svg',
                  width: 32,
                  height: 32,
                ),
                const Gap(10),
                Text(
                  'Add New Coupon',
                  style: TextStyle(
                    color: Color(0xff6600E4),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
