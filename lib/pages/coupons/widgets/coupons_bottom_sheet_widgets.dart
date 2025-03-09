import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/pages/coupons/coupons_edit_page.dart';

import '../bloc/coupon_bloc.dart';

void showCouponBottomSheet(
  BuildContext context,
  String categoryId,
) async {
  final coupon = await showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => CouponsAddWidget(),
  );
  if (coupon == null) return;
  context.read<CouponBloc>().add(
        AddCoupon(
          categoryId: categoryId,
          coupon: coupon,
        ),
      );
}

void showCouponEditBottomSheet(
  BuildContext context,
  String title,
  String image,
  DateTime dateTime,
  String id,
  String categoryId,
) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext dialogContext) => BlocProvider.value(
      value: BlocProvider.of<CouponBloc>(context),
      child: CouponsEditWidget(
        title: title,
        image: image,
        dateTime: dateTime,
        couponId: id,
        categoryId: categoryId,
      ),
    ),
  );
}
