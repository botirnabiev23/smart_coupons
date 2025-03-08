import 'package:flutter/material.dart';
import 'package:smart_coupons/model/categories_model.dart';
import 'package:smart_coupons/pages/coupons/coupons_page.dart';
import 'package:smart_coupons/pages/home/widgets/categories_bottom_sheet_widget.dart';

class CategoriesItem extends StatelessWidget {
  final String id;
  final Categories coupon;
  final Color colorBack;
  final Color colorText;

  const CategoriesItem({
    super.key,
    required this.coupon,
    required this.colorBack,
    required this.colorText,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onLongPress: () => showCategoryOptions(context, id, coupon.title),
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  CouponsPage(title: coupon.title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(36),
          height: 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: colorText.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              softWrap: false,
              maxLines: 1,
              coupon.title,
              style: TextStyle(
                color: colorBack,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
