import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/coupons/bloc/coupon_bloc.dart';

Future<bool?> showDeleteDialog(BuildContext context) async {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: BlocProvider.of<CouponBloc>(context),
        child: CupertinoAlertDialog(
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
                Navigator.of(context).pop(true);
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
        ),
      );
    },
  );
  return null;
}
