import 'package:flutter/cupertino.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/pages/coupons/coupons_edit_page.dart';

void showCouponBottomSheet(BuildContext context) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => const CouponsAddWidget(),
  );
}

void showCouponEditBottomSheet(
  BuildContext context,
  String title,
  String image,
  DateTime dateTime,
  String id,
) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => CouponsEditWidget(
      title: title,
      image: image,
      dateTime: dateTime,
      id: id,
    ),
  );
}
