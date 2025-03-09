import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/pages/coupons/add_or_edit_coupon_page.dart';

import '../bloc/coupon_bloc.dart';

void showCouponAddBottomSheet(
  BuildContext context,
  String categoryId,
) async {
  final coupon = await showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => AddOrEditCouponPage(),
  );
  if (coupon == null) return;
  context.read<CouponBloc>().add(
        AddCoupon(
          categoryId: categoryId,
          coupon: coupon,
        ),
      );
}

void showCouponEditBottomSheet({
  required BuildContext context,
  required String categoryId,
  required Coupon coupon,
}) async {
  final updatedCoupon = await showCupertinoSheet(
    context: context,
    pageBuilder: (_) => AddOrEditCouponPage(
      existingCoupon: coupon,
    ),
  );
  if (updatedCoupon == null) return;
  context.read<CouponBloc>().add(
        EditCoupon(
          categoryId: categoryId,
          updatedCoupon: updatedCoupon,
        ),
      );
}
