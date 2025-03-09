import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupon_delete_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';
import 'package:smart_coupons/widget/format_date.dart';

class CouponsEditWidget extends StatelessWidget {
  final String title;
  final String image;
  final DateTime dateTime;
  final String id;

  const CouponsEditWidget({
    super.key,
    required this.title,
    required this.image,
    required this.dateTime,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          previousPageTitle: 'Quit',
          middle: Text(
            title,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(
                fontSize: 17,
                color: primaryColor,
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        height: 164,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(24),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff000000).withOpacity(0.03),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Use Before',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                formatDate(dateTime),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    foregroundColor: WidgetStateProperty.all(Color(0xffE40000)),
                    backgroundColor: WidgetStateProperty.all(
                        Color(0xffE40000).withOpacity(0.05)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  ),
                  onPressed: () => showDeleteDialog(context, id),
                  child: Text(
                    'Delete Coupon',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Gap(82),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
