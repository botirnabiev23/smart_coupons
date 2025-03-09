import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/coupons/bloc/coupon_bloc.dart';

void showDeleteDialog(
  BuildContext context,
  String id,
) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          "Delete Coupon",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("Sure You Want to Delete\nThis Coupon?"),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "No, Cancel",
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              context.read<CouponBloc>().add(DeleteCoupon(id));
              Navigator.of(context).pop();
            },
            child: Text(
              "Yes, Delete",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ],
      );
    },
  );
}
