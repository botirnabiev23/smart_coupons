import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_coupons/pages/home/widgets/categories_list_widget.dart';
import 'package:smart_coupons/theme/colors.dart';

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
                      selectIndex == 0 ? primaryColor : Color(0xffC7C7C7),
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
                      selectIndex == 1 ? primaryColor : Color(0xffC7C7C7),
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



