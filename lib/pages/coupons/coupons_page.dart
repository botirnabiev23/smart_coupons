import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:smart_coupons/pages/coupons/bloc/coupon_bloc.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupons_bottom_sheet_widgets.dart';
import 'package:smart_coupons/theme/colors.dart';
import 'package:smart_coupons/widget/format_date.dart';

class CouponsPage extends StatelessWidget {
  final String title;

  const CouponsPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text(title),
        trailing: IconButton(
          onPressed: () => showCouponBottomSheet(context),
          icon: Icon(Icons.add, color: primaryColor),
        ),
      ),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: BlocBuilder<CouponBloc, CouponState>(
                  builder: (context, state) {
                    if (state is CouponsLoaded) {
                      if (state.coupons.isNotEmpty) {
                        return Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1,
                                ),
                                itemCount: state.coupons.length,
                                itemBuilder: (context, index) {
                                  final coupon = state.coupons[index];
                                  return InkWell(
                                    onTap: () => showCouponEditBottomSheet(
                                      context,
                                      coupon.name,
                                      coupon.image!,
                                      coupon.date,
                                      coupon.id,
                                      // временно
                                    ),
                                    child: Container(
                                      height: 164,
                                      width: 164,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              child: coupon.image != null
                                                  ? Image.asset(
                                                      coupon.image!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const Icon(
                                                      Icons.card_giftcard,
                                                      size: 50,
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 4,
                                            left: 36.5,
                                            child: Container(
                                              width: 91,
                                              height: 39,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    coupon.name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatDate(coupon.date),
                                                    style: TextStyle(
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.6),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return Material(
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            onTap: () => showCouponBottomSheet(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 24),
                              decoration: BoxDecoration(
                                color: Color(0xff6600E4).withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
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
                      );
                    } else if (state is CouponsError) {
                      return Center(child: Text("Ошибка: ${state.message}"));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
