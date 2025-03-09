import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/pages/categories/widgets/show_category_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';

class EmptyCategoriesWidget extends StatelessWidget {
  const EmptyCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        onTap: () => showAddOrEditCategoryDialog(
          context: context,
          action: DialogAction.add,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
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
              const Gap(12),
              Text(
                'Add New\nCategory',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
