import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'package:smart_coupons/pages/categories/widgets/categories_item_widget.dart';
import 'package:smart_coupons/pages/categories/widgets/new_categories_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            if (state.categories.isEmpty) {
              return Center(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  onTap: () => showNewCategoryDialog(context),
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
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          onTap: () => showNewCategoryDialog(context),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/coupon_icon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const Gap(10),
                                Text(
                                  'Add New Category',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        state.categories.length,
                        (index) => CategoriesItem(
                          id: state.categories[index].id,
                          coupon: state.categories[index],
                          colorText: textColors[index % textColors.length],
                          colorBack:
                              backgroundColors[index % backgroundColors.length],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CategoryInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
