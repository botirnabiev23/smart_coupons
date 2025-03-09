import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'package:smart_coupons/pages/categories/widgets/categories_item_widget.dart';
import 'package:smart_coupons/pages/categories/widgets/empty_categories_widget.dart';
import 'package:smart_coupons/pages/categories/widgets/show_category_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc()..add(CategoryLoadEvent()),
      child: CategoriesPageBody(),
    );
  }
}

class CategoriesPageBody extends StatefulWidget {
  const CategoriesPageBody({super.key});

  @override
  State<CategoriesPageBody> createState() => _CategoriesPageBodyState();
}

class _CategoriesPageBodyState extends State<CategoriesPageBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.status == CategoryStatus.initial ||
              state.status == CategoryStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == CategoryStatus.error) {
            return Center(
              child: Text('Error'),
            );
          }

          if (state.categories.isEmpty) {
            return EmptyCategoriesWidget();
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
                        onTap: () => showAddOrEditCategoryDialog(
                          context: context,
                          action: DialogAction.add,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        couponCategory: state.categories[index],
                        textColor: textColors[index % textColors.length],
                        bgColor:
                            backgroundColors[index % backgroundColors.length],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
