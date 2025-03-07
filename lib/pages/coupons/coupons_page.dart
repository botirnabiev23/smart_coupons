import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupons_bottom_sheet_widgets.dart';

class CouponsPage extends StatelessWidget {
  final String title;

  const CouponsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text(title),
      ),
      child: CustomScrollView(
        slivers: [
          // CupertinoSliverNavigationBar(
          //   stretch: true,
          //   alwaysShowMiddle: false,
          //   border: null,
          //   previousPageTitle: 'Back',
          //   middle: Text(
          //     title ?? '',
          //     textAlign: TextAlign.center,
          //   ),
          //   largeTitle: Text(title ?? ''),
          //   trailing: IconButton(onPressed: (){}, icon: Icon(Icons.add))
          // ),
          SliverFillRemaining(
            child: Material(
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  onTap: () => showCouponBottomSheet(context),
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
                          'Add New\n Coupon',
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
            ),
          ),
        ],
      ),
    );
  }
}
