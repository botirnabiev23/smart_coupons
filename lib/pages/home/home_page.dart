import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smart_coupons/model/categories_model.dart';
import 'package:smart_coupons/pages/coupons/coupons_page.dart';
import 'package:smart_coupons/pages/home/widgets/new_categories_dialog.dart';
import 'bloc/category_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: changeIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 8),
                child: SvgPicture.asset(
                  'assets/images/coupon_icon.svg',
                  color:
                      selectIndex == 0 ? Color(0xff6600E4) : Color(0xffC7C7C7),
                ),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 8),
                child: SvgPicture.asset(
                  'assets/images/setting_icon.svg',
                  color:
                      selectIndex == 1 ? Color(0xff6600E4) : Color(0xffC7C7C7),
                ),
              ),
              label: 'Setting',
            ),
          ],
        ),
      ),
      body: SafeArea(child: CategoriesList()),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final Categories coupon;
  final Color colorBack;
  final Color colorText;

  const CategoriesItem({
    super.key,
    required this.coupon,
    required this.colorBack,
    required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (BuildContext context) => CouponsPage(title: coupon.title),
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

const List<Color> colorsBack = [
  Color(0xffE40050),
  Color(0xff0063E4),
  Color(0xffE46A00),
  Color(0xff00D03A),
  Color(0xff00C7B0),
  Color(0xff6EC300),
  Color(0xff00ABE4),
  Color(0xff0050E4),
];

const List<Color> colorsText = [
  Color(0xffE40050),
  Color(0xff0063E4),
  Color(0xffE46A00),
  Color(0xff00E440),
  Color(0xff00E4C9),
  Color(0xff81E400),
  Color(0xff00ABE4),
  Color(0xff0050E4),
];

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryListUpdate) {
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
                            color: Color(0xff6600E4).withOpacity(0.1),
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
                                  color: Color(0xff6600E4),
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
                        coupon: state.categories[index],
                        colorText: colorsText[index % colorsText.length],
                        colorBack: colorsBack[index % colorsBack.length],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is CategoryInitial) {
          return Center(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              onTap: () => showNewCategoryDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                decoration: BoxDecoration(
                  color: Color(0xff6600E4).withOpacity(0.1),
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
                    const Gap(10),
                    Text(
                      'Add New Category',
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
          );
        } else {
          return Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
